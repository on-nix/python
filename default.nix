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
            projectInstallersRaw = makes.fromJsonFile projectInstallersPath;
            projectInstaller =
              let
                installer =
                  if builtins.length projectInstallersRaw == 1
                  then builtins.head projectInstallersRaw
                  else
                    findFirst (installer: installer != null) null (builtins.map
                      (predicate: findFirst predicate null projectInstallersRaw)
                      (installersPriority pythonVersion));
                installerNames = builtins.map (i: i.name) projectInstallersRaw;
              in
              if installer == null
              then
                abort ''
                  Unable to guess installer for python${pythonVersion} from:
                  ${builtins.concatStringsSep "\n- " installerNames}
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

  installersPriority = pythonVersion: [
    (installer:
      let
        abis = [ "none" ]
          ++ (optionals (pythonVersion == "3.6") [ "abi3" "cp36" "cp36m" ])
          ++ (optionals (pythonVersion == "3.7") [ "abi3" "cp37" "cp37m" ])
          ++ (optionals (pythonVersion == "3.8") [ "abi3" "cp38" "cp38m" ])
          ++ (optionals (pythonVersion == "3.9") [ "abi3" "cp39" "cp39m" ]);

        archs = [ "any" ]
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

        pys = [ "any" ]
          ++ (optionals (pythonVersion == "3.6") [ "cp36" "py3" "py36" "3.6" ])
          ++ (optionals (pythonVersion == "3.7") [ "cp37" "py3" "py37" "3.7" ])
          ++ (optionals (pythonVersion == "3.8") [ "cp38" "py3" "py38" "3.8" ])
          ++ (optionals (pythonVersion == "3.9") [ "cp39" "py3" "py39" "3.9" ]);

        matches = required: available:
          builtins.any (elem: builtins.elem elem available) required;

        src = builtins.match "(.*?)-(.*).(tar.gz|zip)" installer.name;
        whl = builtins.match "(.*?)-(.*)-(.*?)-(.*?)-(.*?).whl" installer.name;
        meta =
          if src != null
          then {
            ext = builtins.elemAt src 2;
            type = "src";
          }
          else if whl != null
          then {
            abis = splitString "." (builtins.elemAt whl 3);
            archs = splitString "." (builtins.elemAt whl 4);
            pys = splitString "." (builtins.elemAt whl 2);
            type = "whl";
          }
          else abort "Unable to parse installer: ${installer.name}";
      in
      meta.type == "whl"
      && matches meta.abis abis
      && matches meta.archs archs
      && (
        (matches meta.abis [ "abi3" ]) ||
        (matches meta.pys pys)
      ))
  ];

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

      pypiEnvironment = makeDerivation {
        builder = ''
          mirror=file://$PWD/mirror
          pypi-mirror create -d $envInstallers -m mirror
          python -m venv "$out"
          source $out/bin/activate
          HOME=. python -m pip install \
            --index-url $mirror \
            --no-compile \
            --no-deps \
            --quiet \
            --upgrade pip
          HOME=. python -m pip install \
            --index-url $mirror \
            --no-compile \
            --no-deps \
            --quiet \
            --requirement $envClosure
        '';
        env = {
          envClosure = toFileLst "closure.lst"
            (attrsMapToList (req: version: "${req}==${version}") closure);
          envInstallers = nixpkgs.linkFarm name (builtins.map
            (installer: { name = installer.name; path = nixpkgs.fetchurl installer; })
            (installers ++ [{
              name = "pip-21.2.4-py3-none-any.whl";
              sha256 = "fa9ebb85d3fd607617c0c44aca302b1b45d87f9c2a1649b46c26167ca4296323";
              url = "https://files.pythonhosted.org/packages/ca/31/b88ef447d595963c01060998cb329251648acf4a067721b0452c45527eb8/pip-21.2.4-py3-none-any.whl";
            }]));
        };
        inherit name;
        searchPaths = {
          bin = [ makes.__nixpkgs__.pypi-mirror python ];
          source = bootstraped;
        };
      };

      out = makeSearchPaths {
        bin = [ pypiEnvironment ];
        pythonPackage36 = optional (pythonVersion == "3.6") pypiEnvironment;
        pythonPackage37 = optional (pythonVersion == "3.7") pypiEnvironment;
        pythonPackage38 = optional (pythonVersion == "3.8") pypiEnvironment;
        pythonPackage39 = optional (pythonVersion == "3.9") pypiEnvironment;
        source = bootstraped;
      };
    in
    "${out}/template";

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
