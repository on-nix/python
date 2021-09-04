{ nixpkgs ? import <nixpkgs> { }
}:
let
  inherit (makes) attrsMapToList;
  inherit (makes) mapAttrsToList;
  inherit (makes) makeDerivation;
  inherit (makes) makeSearchPaths;
  inherit (makes) toFileLst;
  inherit (nixpkgs.lib.lists) findFirst;
  inherit (nixpkgs.stdenv) isDarwin;
  inherit (nixpkgs.stdenv) isi686;
  inherit (nixpkgs.stdenv) isLinux;
  inherit (nixpkgs.stdenv) isx86_64;
  inherit (nixpkgs.lib.lists) optional;
  inherit (nixpkgs.lib.lists) optionals;
  inherit (nixpkgs.lib.strings) splitString;

  pythonVersions = [ "3.6" "3.7" "3.8" "3.9" ];

  pkgsSrc = ./pkgs;

  buildProjects = pythonVersion:
    builtins.foldl'
      (projects: project: projects // (buildProject pythonVersion project))
      { }
      (ls pkgsSrc);

  buildProject = pythonVersion: project:
    let
      versions = buildProjectVersions pythonVersion project;
      latest = builtins.head
        (builtins.sort
          (a: b: (builtins.compareVersions a b) > 0)
          (builtins.attrNames versions));
    in
    if versions == { }
    then { }
    else
      ((nixpkgs.lib.mapAttrs'
        (version: value: { name = "${project}-${version}"; inherit value; })
        (versions)) //
      { "${project}" = versions.${latest}; });

  buildProjectVersions = pythonVersion: project:
    builtins.foldl'
      (versions: version:
        versions // (buildProjectVersion pythonVersion project version))
      { }
      (ls (pkgsSrc + "/${project}"));

  buildProjectVersion = pythonVersion: project: version:
    let
      name = "python${pythonVersion}-${project}-${version}";

      closurePath = pkgsSrc + "/${project}/${version}/python${pythonVersion}.json";
      setupGlobalPath = pkgsSrc + "/${project}/setup.nix";
      setupVersionPath = pkgsSrc + "/${project}/${version}/setup.nix";

      setup = (
        ({
          patchClosure = closure: closure;
          patchInstallers = installers: installers;
          searchPaths = _: { };
        }) //
        (if builtins.pathExists setupGlobalPath
        then import setupGlobalPath else { }) //
        (if builtins.pathExists setupVersionPath
        then import setupVersionPath else { })
      );

      # Raw inputs
      closureRaw = makes.fromJsonFile closurePath;
      installersRaw = builtins.foldl'
        (installers: project:
          let
            version = closure.${project};
            projectInstallersPath = pkgsSrc + "/${project}/${version}/installers.json";
            projectInstallersRaw = builtins.map
              (enrichInstaller project version)
              (makes.fromJsonFile projectInstallersPath);
            projectInstaller =
              let
                installer =
                  if builtins.length projectInstallersRaw == 1
                  then builtins.head projectInstallersRaw
                  else
                    findFirst (installer: installer != null) null (builtins.map
                      (predicate: findFirst predicate null projectInstallersRaw)
                      [
                        (isSupportedWheel pythonVersion)
                      ]);
              in
              if installer == null
              then
                abort ''
                  Unable to guess installer for python${pythonVersion} from:
                  ${builtins.concatStringsSep "\n- "
                    (builtins.map (i: i.name) projectInstallersRaw)}
                ''
              else installer;
          in
          installers ++ [ projectInstaller ])
        [ ]
        (builtins.attrNames closure);

      # Post-processed inputs
      closure = setup.patchClosure closureRaw;
      installers = setup.patchInstallers installersRaw;
      searchPaths = setup.searchPaths { inherit nixpkgs; };

      venv = makePythonEnv {
        inherit closure;
        inherit installers;
        inherit name;
        inherit pythonVersion;
        inherit searchPaths;
      };
    in
    if builtins.pathExists closurePath
    then { "${version}" = venv; }
    else { };

  supportedArchs = [ "any" ]
    ++ (optional (isDarwin) "macosx_10_9_universal2")
    ++ (optional (isDarwin && isx86_64) "macosx_10_9_x86_64")
    ++ (optional (isDarwin && isx86_64) "macosx_10_14_x86_64")
    ++ (optional (isDarwin && isi686) "macosx_10_9_i686")
    ++ (optional (isDarwin && isi686) "macosx_10_14_i686")
    ++ (optional (isLinux && isx86_64) "manylinux1_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux_2_24_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux2010_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux2014_x86_64")
    ++ (optional (isLinux && isi686) "manylinux1_i686")
    ++ (optional (isLinux && isi686) "manylinux_2_24_i686")
    ++ (optional (isLinux && isi686) "manylinux2010_i686")
    ++ (optional (isLinux && isi686) "manylinux2014_i686");

  supportedAbis = {
    "3.6" = [ "none" "abi3" "cp36" "cp36m" ];
    "3.7" = [ "none" "abi3" "cp37" "cp37m" ];
    "3.8" = [ "none" "abi3" "cp38" "cp38m" ];
    "3.9" = [ "none" "abi3" "cp39" "cp39m" ];
  };

  supportedPythonImplementations = {
    "3.6" = [ "any" "cp36" "py3" "py36" "3.6" ];
    "3.7" = [ "any" "cp37" "py3" "py37" "3.7" ];
    "3.8" = [ "any" "cp38" "py3" "py38" "3.8" ];
    "3.9" = [ "any" "cp39" "py3" "py39" "3.9" ];
  };

  isSupported = required: supported:
    builtins.any (elem: builtins.elem elem supported) required;

  enrichInstaller = project: version: installer:
    let
      src = builtins.match "(.*?)-(.*).(tar.gz|zip)" installer.name;
      whl = builtins.match "(.*?)-(.*)-(.*?)-(.*?)-(.*?).whl" installer.name;
      meta =
        if whl != null
        then {
          abis = splitString "." (builtins.elemAt whl 3);
          archs = splitString "." (builtins.elemAt whl 4);
          pys = splitString "." (builtins.elemAt whl 2);
          type = "whl";
        }
        else if src != null
        then {
          ext = builtins.elemAt src 2;
          type = "src";
        }
        else abort "Unable to parse installer: ${installer.name}";
    in
    installer // meta // {
      inherit project;
      inherit version;
      path = nixpkgs.fetchurl installer;
    };

  isSupportedWheel = pythonVersion:
    (installer: installer.type == "whl"
      && isSupported installer.abis supportedAbis.${pythonVersion}
      && isSupported installer.archs supportedArchs
      && (
      (isSupported installer.abis [ "abi3" ]) ||
        (isSupported installer.pys supportedPythonImplementations.${pythonVersion})
    ));

  makePythonEnv =
    { closure
    , installers
    , name
    , pythonVersion
    , searchPaths ? { }
    }:
    let
      python = builtins.getAttr pythonVersion {
        "3.6" = nixpkgs.python36;
        "3.7" = nixpkgs.python37;
        "3.8" = nixpkgs.python38;
        "3.9" = nixpkgs.python39;
      };

      bootstraped = builtins.concatLists [
        [ (makeSearchPaths searchPaths) ]
      ];

      mirror = installers:
        let
          projects = builtins.map
            (installer: "<a href=/${installer.project}/>${installer.project}</a>")
            (installers);
        in
        nixpkgs.linkFarm "mirror-for-${name}" (builtins.concatLists [
          [{
            name = "index.html";
            path = builtins.toFile "index.html" ''
              <!DOCTYPE html><html><body>
                ${builtins.concatStringsSep "" projects}
              </body></html>
            '';
          }]

          (builtins.map
            (installer: {
              name = "${installer.project}/index.html";
              path = builtins.toFile "${installer.project}-index.haml" ''
                <!DOCTYPE html><html><body>
                  <a href="./${installer.name}">${installer.name}</a>
                </body></html>
              '';
            })
            (installers))

          (builtins.map
            (installer: {
              name = "${installer.project}/${installer.name}";
              path = installer.path;
            })
            installers)
        ]);

      venv = makeDerivation {
        builder = ''
          python -m venv "$out"
          source $out/bin/activate
          HOME=. python -m pip install \
            --index-url file://$envMirror \
            --no-compile \
            --no-deps \
            --quiet \
            --upgrade pip
          HOME=. python -m pip install \
            --index-url file://$envMirror \
            --no-compile \
            --no-deps \
            --quiet \
            --requirement $envClosure
        '';
        env = {
          envClosure = toFileLst "closure.lst"
            (attrsMapToList (req: version: "${req}==${version}") closure);
          envMirror = mirror (installers ++ [
            (enrichInstaller "pip" "21.2.4" {
              name = "pip-21.2.4-py3-none-any.whl";
              sha256 = "fa9ebb85d3fd607617c0c44aca302b1b45d87f9c2a1649b46c26167ca4296323";
              url = "https://files.pythonhosted.org/packages/ca/31/b88ef447d595963c01060998cb329251648acf4a067721b0452c45527eb8/pip-21.2.4-py3-none-any.whl";
            })
          ]);
        };
        inherit name;
        searchPaths = {
          bin = [ python ];
          source = bootstraped;
        };
      };

      out = makeSearchPaths {
        bin = [ venv ];
        pythonPackage36 = optional (pythonVersion == "3.6") venv;
        pythonPackage37 = optional (pythonVersion == "3.7") venv;
        pythonPackage38 = optional (pythonVersion == "3.8") venv;
        pythonPackage39 = optional (pythonVersion == "3.9") venv;
        source = bootstraped;
      };
    in
    out;

  makeEnv =
    { pkgs
    , pythonVersion
    }:
    makes.makeSearchPaths {
      source = builtins.map
        (project: builtProjects.${pythonVersion}.${project})
        (pkgs);
    };

  ls = dir: builtins.attrNames (builtins.readDir dir);

  makes =
    let src = nixpkgs.fetchFromGitHub {
      owner = "fluidattacks";
      repo = "makes";
      rev = "767979d2c1fc7fdebaf85ea322ed7487227a639a";
      sha256 = "07bcn6nc7k4l1iz7ipcm7wknwqiv0ypsxaq6rzlzh1fa0q1iq62q";
    };
    in import "${src}/src/args/agnostic.nix" { };

  builtProjects = builtins.listToAttrs (builtins.map
    (pythonVersion: {
      name = pythonVersion;
      value = buildProjects pythonVersion;
    })
    (pythonVersions));

  __all__ = nixpkgs.linkFarm "nixpkgs-python"
    (builtins.map
      (pythonVersion: {
        name = pythonVersion;
        path = makeEnv {
          pkgs = builtins.attrNames builtProjects.${pythonVersion};
          inherit pythonVersion;
        };
      })
      pythonVersions);
in
builtProjects // {
  inherit __all__;
  inherit makeEnv;
}
