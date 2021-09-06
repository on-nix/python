let
  sources = import ./nix/sources.nix;
  makes = import "${sources.makes}/src/args/agnostic.nix" { };
  nixpkgs = import sources.nixpkgs { };

  inherit (makes) fromJsonFile;
  inherit (makes) makeDerivation;
  inherit (makes) makeSearchPaths;
  inherit (nixpkgs.lib.lists) findFirst;
  inherit (nixpkgs.stdenv) isDarwin;
  inherit (nixpkgs.stdenv) isi686;
  inherit (nixpkgs.stdenv) isLinux;
  inherit (nixpkgs.stdenv) isx86_64;
  inherit (nixpkgs.lib.lists) optional;
  inherit (nixpkgs.lib.lists) optionals;
  inherit (nixpkgs.lib.strings) splitString;

  pythonVersions = [ "3.6" "3.7" "3.8" "3.9" ];

  projectsSrc = ./projects;

  buildProjects = pythonVersion:
    builtins.foldl'
      (projects: project: projects // (buildProject pythonVersion project))
      { }
      (ls projectsSrc);

  buildProject = pythonVersion: project:
    let
      versions = buildProjectVersions pythonVersion project;
      latest = builtins.head (builtins.sort
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
      (versions: version: versions // (buildProjectVersion pythonVersion project version))
      { }
      (ls (projectsSrc + "/${project}"));

  buildProjectVersion = pythonVersion: project: version:
    let
      closurePath = projectsSrc + "/${project}/${version}/python${pythonVersion}.json";
      setupGlobalPath = projectsSrc + "/${project}/setup.nix";
      setupVersionPath = projectsSrc + "/${project}/${version}/setup.nix";
      testGlobalPath = projectsSrc + "/${project}/test.py";
      testVersionPath = projectsSrc + "/${project}/${version}/test.py";

      name = "python${pythonVersion}-${project}-${version}";
      python = builtins.getAttr pythonVersion {
        "3.6" = nixpkgs.python36;
        "3.7" = nixpkgs.python37;
        "3.8" = nixpkgs.python38;
        "3.9" = nixpkgs.python39;
      };
      setup = (
        ({
          extraInstallers = { };
          patchClosure = closure: closure;
          cleanPkgResources = true;
          cleanSetuptools = true;
          searchPathsBuild = _: { };
          searchPathsRuntime = _: { };
        }) //
        (if builtins.pathExists setupGlobalPath
        then import setupGlobalPath else { }) //
        (if builtins.pathExists setupVersionPath
        then import setupVersionPath else { })
      );
      test =
        if builtins.pathExists testVersionPath
        then testVersionPath
        else if builtins.pathExists testGlobalPath
        then testGlobalPath
        else null;

      closure = builtins.removeAttrs (fromJsonFile closurePath) [ project ];

      installers = (builtins.attrValues (builtins.mapAttrs
        (makePypiInstaller pythonVersion)
        (setup.extraInstallers)))
      ++ [
        (makePypiInstaller pythonVersion "pip" "21.2.4")
        (makePypiInstaller pythonVersion project version)
      ];

      cleanPhase = builtins.concatStringsSep "" [
        (if setup.cleanSetuptools then ''
          rm -rf $out/lib/python${pythonVersion}/site-packages/_distutils_hack
          rm -rf $out/lib/python${pythonVersion}/site-packages/distutils-precedence.pth
        '' else "")
        (if setup.cleanPkgResources then ''
          rm -rf $out/lib/python${pythonVersion}/site-packages/pkg_resources
        '' else "")
        (if setup.cleanSetuptools then ''
          rm -rf $out/lib/python${pythonVersion}/site-packages/setuptools
          rm -rf $out/lib/python${pythonVersion}/site-packages/setuptools*.dist-info
        '' else "")
      ];
      propagated = builtins.attrValues (builtins.mapAttrs
        (project: version: builtProjects.${pythonVersion}."${project}-${version}")
        (setup.patchClosure closure));
      searchPathsArgs = {
        inherit nixpkgs;
        nixpkgsPython = builtProjects.${pythonVersion};
      };
      searchPathsBuild = makeSearchPaths
        (setup.searchPathsBuild searchPathsArgs);
      searchPathsRuntime = makeSearchPaths
        (setup.searchPathsRuntime searchPathsArgs);

      venvRaw = makeDerivation {
        builder = ''
          export DETERMINISTIC_BUILD=1
          export PYTHONDONTWRITEBYTECODE=1
          export PYTHONPYCACHEPREFIX=$PWD
          export PYTHONHASHSEED=0
          export PYTHONNOUSERSITE=1
          python -m venv $out
          source $out/bin/activate
          python -m pip install \
            --index-url file://$envMirror \
            --no-cache-dir \
            --no-compile \
            --no-deps \
            --quiet \
            --upgrade \
            pip
          python -m pip install \
            --disable-pip-version-check \
            --index-url file://$envMirror \
            --no-cache-dir \
            --no-compile \
            --no-deps \
            --quiet \
            ${project}==${version}
          python -m pip uninstall \
            --no-cache-dir \
            --quiet \
            --yes \
            pip
          rm -rf $out/bin/[Aa]ctivate*
          rm -rf $out/bin/easy_install*
          rm -rf $out/lib/python${pythonVersion}/site-packages/__pycache__
          rm -rf $out/lib/python${pythonVersion}/site-packages/easy_install.py

          ${cleanPhase}

          echo
          echo $out
          cd $out
          if test -e bin; then
            find -L bin \
              -exec du -B KiB {} \; \
              -mindepth 1 \
              -type f
          fi
          if test -e include; then
            find -L include \
              -exec du -B KiB {} \; \
              -mindepth 1 \
              -type f
          fi
          if test -e lib/python${pythonVersion}/site-packages; then
            find -L lib/python${pythonVersion}/site-packages \
              -exec du -B KiB {} \; \
              -maxdepth 1 \
              -mindepth 1 \
              -type d
          fi
          echo
        '';
        env.envMirror = makePypiMirror name installers;
        inherit name;
        searchPaths = {
          bin = [ python nixpkgs.findutils ];
          source = [ searchPathsBuild ];
        };
      };
      venvSetup = makeSearchPaths {
        bin = [ venvRaw ];
        pythonPackage36 = optional (pythonVersion == "3.6") venvRaw;
        pythonPackage37 = optional (pythonVersion == "3.7") venvRaw;
        pythonPackage38 = optional (pythonVersion == "3.8") venvRaw;
        pythonPackage39 = optional (pythonVersion == "3.9") venvRaw;
        source = propagated ++ [ searchPathsRuntime ];
      };
      venv = makeDerivation {
        builder = ''
          mkdir $out
          mkdir $out/nix-support
          ln -s $envVenvSetup/template $out/setup
          ln -s $envVenvSetup/template $out/template
          ln -s $envVenvSetup/template $out/nix-support/setup-hook

          if test -n "$envTest"; then
            source $out/setup
            python $envTest
          fi
        '';
        env = {
          envVenvSetup = venvSetup;
          envTest = test;
        };
        inherit name;
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
  isSupportedWheel = pythonVersion:
    (installer: installer.type == "whl"
      && isSupported installer.abis supportedAbis.${pythonVersion}
      && isSupported installer.archs supportedArchs
      && (
      (isSupported installer.abis [ "abi3" ]) ||
        (isSupported installer.pys supportedPythonImplementations.${pythonVersion})
    ));
  isSupportedSrc = installer: installer.type == "src";

  enrichInstaller = pythonVersion: project: version: name: sha256:
    let
      src = builtins.match "(.*)-(.*?).(tar.bz2|tar.gz|zip)" name;
      whl = builtins.match "(.*?)-(.*)-(.*?)-(.*?)-(.*?).whl" name;
      meta =
        if whl != null
        then rec {
          abis = splitString "." (builtins.elemAt whl 3);
          archs = splitString "." (builtins.elemAt whl 4);
          impl = builtins.elemAt whl 2;
          pys = splitString "." impl;
          type = "whl";
        }
        else if src != null
        then {
          ext = builtins.elemAt src 2;
          type = "src";
        }
        else abort "Unable to parse installer: ${name}";
      projectL = builtins.substring 0 1 project;
      base = "https://files.pythonhosted.org/packages";
    in
    meta // {
      inherit name;
      inherit project;
      path = nixpkgs.fetchurl {
        inherit name;
        inherit sha256;
        urls =
          if meta.type == "src"
          then [ "${base}/source/${projectL}/${project}/${name}" ]
          else
            (builtins.map
              (impl: "${base}/${impl}/${projectL}/${project}/${name}")
              ([ meta.impl ] ++ pythonVersions ++ [ "2.7" ]));
      };
    };

  makePypiInstaller = pythonVersion: project: version:
    let
      installersPath = projectsSrc + "/${project}/${version}/installers.json";
      installers = builtins.attrValues (builtins.mapAttrs
        (enrichInstaller pythonVersion project version)
        (fromJsonFile installersPath));
      installer = findFirst (installer: installer != null) null (builtins.map
        (predicate: findFirst predicate null installers)
        [
          (isSupportedWheel pythonVersion)
          (isSupportedSrc)
        ]);
    in
    if installer == null
    then
      abort ''
        Python${pythonVersion} installer not found:
        ${builtins.concatStringsSep "\n"
          (builtins.map (i: i.name) installers)}
      ''
    else installer;
  makePypiMirror = name: installers: nixpkgs.linkFarm "mirror-for-${name}" (
    (builtins.map
      (installer: {
        name = "${installer.project}/index.html";
        path = builtins.toFile "${installer.project}-index.html" ''
          <html><body>
            <a href="./${installer.name}">${installer.name}</a>
          </body></html>
        '';
      })
      (installers))
    ++ (builtins.map
      (installer: {
        name = "${installer.project}/${installer.name}";
        path = installer.path;
      })
      (installers))
    ++ [{
      name = "index.html";
      path =
        builtins.toFile "index.html" ''
          <html><body>
            ${builtins.concatStringsSep " " (builtins.map
              (installer: "<a href=/${installer.project}/>${installer.project}</a>")
              (installers))}
          </body></html>
        '';
    }]
  );

  makeEnv =
    { name
    , projects
    , pythonVersion
    }:
    makeDerivation {
      builder = ''
        mkdir $out
        mkdir $out/nix-support
        ln -s $envOut/template $out/setup
        ln -s $envOut/template $out/template
        ln -s $envOut/template $out/nix-support/setup-hook
      '';
      env.envOut = makeSearchPaths {
        source = builtins.map
          (project: builtProjects.${pythonVersion}.${project})
          (projects);
      };
      name = "python${pythonVersion}-env-for-${name}";
    };

  ls = dir: builtins.attrNames (builtins.readDir dir);

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
          name = pythonVersion;
          projects = builtins.attrNames builtProjects.${pythonVersion};
          inherit pythonVersion;
        };
      })
      pythonVersions);
in
builtins.trace ''


You are using Nixpkgs Python!

  https://github.com/kamadorueda/nixpkgs-python

Found a bug? Are we missing a feature?
Let us know in the issues section.

Please consider starring, funding or contributing to the project!

''
{
  inherit __all__;
  inherit makeEnv;
  python36 = builtProjects."3.6";
  python37 = builtProjects."3.7";
  python38 = builtProjects."3.8";
  python39 = builtProjects."3.9";
}
