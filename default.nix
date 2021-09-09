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

  pythonVersions = [ "python36" "python37" "python38" "python39" ];
  pythons = builtins.map
    (pythonVersion: nixpkgs.${pythonVersion})
    pythonVersions;

  projectsSrc = ./projects;
  projects =
    builtins.listToAttrs (builtins.map
      (project: {
        name = project;
        value = buildProject project;
      })
      (lsDirs projectsSrc));
  apps =
    builtins.mapAttrs
      (project: versions: builtins.mapAttrs
        (version: pythonVersions:
          let
            latest = getLatestVersion (builtins.attrNames pythonVersions);
          in
          pythonVersions.${latest}.bin)
        versions)
      projects;

  buildProject = project:
    let
      versions = buildProjectVersions project;
      latest = getLatestVersion (builtins.attrNames versions);
    in
    if versions == { }
    then { }
    else versions // { latest = versions.${latest}; };
  buildProjectVersions = project:
    builtins.listToAttrs (builtins.map
      (version: {
        name = version;
        value = buildProjectVersion project version;
      })
      (lsDirs (projectsSrc + "/${project}")));
  buildProjectVersion = project: version:
    builtins.listToAttrs (builtins.map
      (pythonVersion: {
        name = pythonVersion;
        value = buildProjectVersionForInterpreter project version pythonVersion;
      })
      (pythonVersions));
  buildProjectVersionForInterpreter = project: version: pythonVersion:
    let
      closureCommonPath = projectsSrc + "/${project}/${version}/python3*.json";
      closurePath = projectsSrc + "/${project}/${version}/${pythonVersion}.json";
      setupGlobalPath = projectsSrc + "/${project}/setup.nix";
      setupVersionPath = projectsSrc + "/${project}/${version}/setup.nix";
      testGlobalPath = projectsSrc + "/${project}/test.py";
      testVersionPath = projectsSrc + "/${project}/${version}/test.py";

      name = "${pythonVersion}-${project}-${version}";
      python = nixpkgs.${pythonVersion};
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

      closure = (fromJsonFile closureCommonPath) // (fromJsonFile closurePath);

      installers = (builtins.attrValues (builtins.mapAttrs
        (makePypiInstaller pythonVersion)
        (setup.extraInstallers)))
      ++ [
        (makePypiInstaller pythonVersion "pip" "21.2.4")
        (makePypiInstaller pythonVersion project version)
      ];

      cleanPhase = builtins.concatStringsSep "" [
        (if setup.cleanPkgResources then ''
          rm -rf $out/${python.sitePackages}/pkg_resources
        '' else "")
        (if setup.cleanSetuptools then ''
          rm -rf $out/${python.sitePackages}/_distutils_hack
          rm -rf $out/${python.sitePackages}/distutils-precedence.pth
          rm -rf $out/${python.sitePackages}/setuptools
          rm -rf $out/${python.sitePackages}/setuptools*.dist-info
        '' else "")
      ];
      propagated = builtins.attrValues (builtins.mapAttrs
        (project: version: projects.${project}.${version}.${pythonVersion}.dev)
        (setup.patchClosure closure));
      searchPathsArgs = {
        inherit nixpkgs;
        nixpkgsPython = self;
        inherit pythonVersion;
      };
      searchPathsBuild = makeSearchPaths
        (setup.searchPathsBuild searchPathsArgs);
      searchPathsRuntime = makeSearchPaths
        (setup.searchPathsRuntime searchPathsArgs);

      venvContents = makeDerivation {
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
          rm -rf $out/${python.sitePackages}/__pycache__
          rm -rf $out/${python.sitePackages}/easy_install.py

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
          if test -e ${python.sitePackages}; then
            find -L ${python.sitePackages} \
              -exec du -B KiB {} \; \
              -maxdepth 1 \
              -mindepth 1 \
              -type d
          fi
          echo
        '';
        env.envMirror = makePypiMirror name installers;
        name = "${name}-out";
        searchPaths = {
          bin = [ python nixpkgs.findutils ];
          source = [ searchPathsBuild ];
        };
      };
      venvSearchPaths = makeDerivation {
        builder = ''
          mkdir $out
          mkdir $out/nix-support

          ln -s $envWrapped/template $out/setup
          ln -s $envWrapped/template $out/template
          ln -s $envWrapped/template $out/nix-support/setup-hook
        '';
        env.envWrapped = makeSearchPaths {
          bin = [ venvContents ];
          pythonPackage36 = optional (pythonVersion == "python36") venvContents;
          pythonPackage37 = optional (pythonVersion == "python37") venvContents;
          pythonPackage38 = optional (pythonVersion == "python38") venvContents;
          pythonPackage39 = optional (pythonVersion == "python39") venvContents;
          source = propagated ++ [ searchPathsRuntime ];
        };
        name = "${name}-dev";
      };
      venvTests = makeDerivation {
        builder = ''
          source $envVenvSearchPaths/setup

          if test -n "$envTest"; then python $envTest; fi

          touch $out
        '';
        env = {
          envVenvSearchPaths = venvSearchPaths;
          envTest = test;
        };
        name = "${name}-test";
      };
      venvBins = makeDerivation {
        builder = ''
          shopt -s nullglob

          mkdir $out
          mkdir $out/bin

          for bin in $envVenvContents/bin/*; do
            bin_basename="$(basename "$bin")"
            {
              echo "#! $envBash/bin/bash"
              echo
              echo source $envVenvSearchPaths/setup
              echo
              echo "'$bin' \"\$@\""
            } > "$out/bin/$bin_basename"
            if test -x "$bin"; then
              chmod +x "$out/bin/$bin_basename"
            fi
          done
        '';
        env = {
          envBash = nixpkgs.bash;
          envVenvContents = venvContents;
          envVenvSearchPaths = venvSearchPaths;
        };
        name = "${name}-bin";
      };
    in
    if builtins.pathExists closurePath
    then {
      bin = venvBins;
      out = venvContents;
      dev = venvSearchPaths;
      test = venvTests;
    }
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
  supportedAbis =
    {
      "python36" = [ "none" "abi3" "cp36" "cp36m" ];
      "python37" = [ "none" "abi3" "cp37" "cp37m" ];
      "python38" = [ "none" "abi3" "cp38" "cp38m" ];
      "python39" = [ "none" "abi3" "cp39" "cp39m" ];
    };
  supportedPythonImplementations =
    {
      "python36" = [ "any" "cp36" "py3" "py36" "3.6" ];
      "python37" = [ "any" "cp37" "py3" "py37" "3.7" ];
      "python38" = [ "any" "cp38" "py3" "py38" "3.8" ];
      "python39" = [ "any" "cp39" "py3" "py39" "3.9" ];
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
      egg = builtins.match "(.*)-(.*?)-(.*).egg" name;
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
        else if egg != null
        then {
          type = "egg";
        }
        else abort "Unable to parse installer: ${name}";
      projectL = builtins.substring 0 1 project;
      base = "https://files.pythonhosted.org/packages";
      impls = [ meta.impl ]
        ++ (builtins.map (py: py.pythonVersion) pythons)
        ++ [ "2.7" ];
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
              (impls));
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

  makeEnv = pythonVersion:
    { name
    , projects
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
          (project: project.${pythonVersion}.dev)
          (projects);
      };
      name = "python${pythonVersion}-env-for-${name}";
    };

  getLatestVersion = versions: builtins.head (builtins.sort
    (a: b: (builtins.compareVersions a b) > 0)
    versions);

  lsDirs = path:
    let
      contents = builtins.readDir path;
    in
    builtins.filter
      (name: contents.${name} == "directory")
      (builtins.attrNames contents);

  __all__ = nixpkgs.linkFarm "nixpkgs-python"
    (builtins.attrValues (builtins.mapAttrs
      (project: versions: {
        name = project;
        path = nixpkgs.linkFarm project
          (builtins.attrValues (builtins.mapAttrs
            (version: pythonVersions: {
              name = version;
              path = nixpkgs.linkFarm "${project}-${version}"
                (builtins.attrValues (builtins.mapAttrs
                  (pythonVersion: outputs: {
                    name = pythonVersion;
                    path = nixpkgs.linkFarm "${project}-${version}"
                      (builtins.attrValues (builtins.mapAttrs
                        (output: value: {
                          name = output;
                          path = value;
                        })
                        outputs));
                  })
                  pythonVersions));
            })
            versions));
      })
      projects));

  self = {
    inherit __all__;
    inherit apps;
    inherit projects;
  } // (
    builtins.listToAttrs (builtins.map
      (pythonVersion: {
        name = "${pythonVersion}Env";
        value = makeEnv pythonVersion;
      })
      pythonVersions));

  ads = ''


    $ You are using Nixpkgs Python!

      https://github.com/kamadorueda/nixpkgs-python

      Found a bug? Are we missing a feature?
      Let us know in the issues section.

      Please consider starring, funding or contributing to the project!

  '';
in
builtins.trace ads self
