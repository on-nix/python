let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  system = "x86_64-linux";

  makes = import "${makesSrc}/src/args/agnostic.nix" { inherit system; };
  makesSrc = with lock.nodes.makes.locked; builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    sha256 = narHash;
  };

  nixpkgs = import nixpkgsSrc { inherit system; };
  nixpkgsSrc = with lock.nodes.nixpkgs.locked; builtins.fetchTarball {
    url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
    sha256 = narHash;
  };

  inherit (makes) attrsOptional;
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

  projectsPath = ./projects;
  projectsMeta = mapListToAttrs buildProjectMeta (lsDirs projectsPath);

  buildProjectMeta = project:
    let
      latest = getLatestVersion (builtins.attrNames versions);
      versions = mapListToAttrs
        (buildProjectVersionMeta project)
        (lsDirs (projectsPath + "/${project}"));
    in
    if versions == { }
    then null
    else {
      name = project;
      value = {
        inherit project;
        setupPath = projectsPath + "/${project}/setup.nix";
        testPath = projectsPath + "/${project}/test.py";
        versions = versions
          // { latest = versions.${latest} // { version = "latest"; }; };
      };
    };
  buildProjectVersionMeta = project: version:
    {
      name = version;
      value = {
        closurePath = projectsPath + "/${project}/${version}/python3*.json";
        installersPath = projectsPath + "/${project}/${version}/installers.json";
        pythonVersions =
          let
            latest = getLatestVersion (builtins.attrNames supported);
            supported = mapListToAttrs
              (buildProjectVersionForInterpreterMeta project version)
              (pythonVersions);
          in
          if supported == { }
          then supported
          else supported
            // { latest = supported.${latest} // { pythonVersion = "latest"; }; };
        setupPath = projectsPath + "/${project}/${version}/setup.nix";
        testPath = projectsPath + "/${project}/${version}/test.py";
        inherit version;
        version' = version;
      };
    };
  buildProjectVersionForInterpreterMeta = project: version: pythonVersion:
    let
      closurePath = projectsPath + "/${project}/${version}/${pythonVersion}.json";
    in
    if builtins.pathExists closurePath
    then {
      name = pythonVersion;
      value = {
        inherit closurePath;
        inherit pythonVersion;
        pythonVersion' = pythonVersion;
      };
    }
    else null;

  projects =
    let
      projects = mapListToAttrs
        (buildProject)
        (builtins.attrNames projectsMeta);
    in
    projects // { outPath = attrsToLinkFarm "python-on-nix" projects; };

  apps = builtins.mapAttrs
    (project: projectMeta: builtins.mapAttrs
      (version: _:
        let latest = projectMeta.versions.${version}.pythonVersions.latest.pythonVersion;
        in projects.${project}.${version}.${latest}.bin)
      (projectMeta.versions))
    (projectsMeta);

  buildProject = project:
    let versions = buildProjectVersions project;
    in
    {
      name = project;
      value = versions // { outPath = attrsToLinkFarm project versions; };
    };
  buildProjectVersions = project:
    mapListToAttrs
      (version: {
        name = version;
        value = buildProjectVersion project version;
      })
      (builtins.attrNames projectsMeta.${project}.versions);
  buildProjectVersion = project: version:
    let
      results = mapListToAttrs
        (buildProjectVersionForInterpreter project version)
        (builtins.attrNames projectsMeta.${project}.versions.${version}.pythonVersions);
    in
    results // { outPath = attrsToLinkFarm "${project}-${version}" results; };

  buildProjectVersionForInterpreter = project: version': pythonVersion':
    let
      version = projectsMeta.${project}.versions.${version'}.version';
      pythonVersion = projectsMeta.${project}.versions.${version}.pythonVersions.${pythonVersion'}.pythonVersion';

      closureCommonPath = projectsMeta.${project}.versions.${version}.closurePath;
      closurePath = projectsMeta.${project}.versions.${version}.pythonVersions.${pythonVersion}.closurePath;
      setupGlobalPath = projectsMeta.${project}.setupPath;
      setupVersionPath = projectsMeta.${project}.versions.${version}.setupPath;
      testGlobalPath = projectsMeta.${project}.testPath;
      testVersionPath = projectsMeta.${project}.versions.${version}.testPath;

      name = "${project}-${version'}-${pythonVersion'}";
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

      installers = builtins.concatLists [
        (mapAttrsToList
          (makePypiInstaller pythonVersion)
          (setup.extraInstallers))
        [
          (makePypiInstaller pythonVersion "pip" "21.2.4")
          (makePypiInstaller pythonVersion project version)
        ]
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
      propagated = mapAttrsToList
        (project: version: projects.${project}.${version}.${pythonVersion}.dev)
        (setup.patchClosure closure);
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
          export LANG=C.UTF-8
          export LC_ALL=C.UTF-8
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
        '';
        env.envMirror = makePypiMirror name installers;
        name = "${name}-out";
        searchPaths = {
          bin = [ python ];
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
          echo
          pushd $envVenvContents
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
          popd
          echo

          source $envVenvSearchPaths/setup

          if test -n "$envTest"; then python $envTest; fi

          touch $out
        '';
        env = {
          envVenvContents = venvContents;
          envVenvSearchPaths = venvSearchPaths;
          envTest = test;
        };
        name = "${name}-test";
        searchPaths.bin = [ nixpkgs.findutils ];
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

      outputs = {
        bin = venvBins;
        out = venvContents;
        dev = venvSearchPaths;
        test = venvTests;
      };
    in
    {
      name = pythonVersion';
      value = outputs // { outPath = attrsToLinkFarm name outputs; };
    };

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
        ++ [ "py2.py3" "3.5" "2.7" ];
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
      installersPath = projectsMeta.${project}.versions.${version}.installersPath;
      installers = mapAttrsToList
        (enrichInstaller pythonVersion project version)
        (fromJsonFile installersPath);
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


        ${pythonVersion} installer not found:
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

  makeEnvs = mapListToAttrs
    (pythonVersion: {
      name = "${pythonVersion}Env";
      value = makeEnv pythonVersion;
    })
    pythonVersions;
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

  attrsToLinkFarm = name: attrs:
    nixpkgs.linkFarm name (mapAttrsToList
      (name: path: { inherit name path; })
      attrs);
  mapAttrsToList = func: attrs:
    builtins.attrValues (builtins.mapAttrs func attrs);
  mapListToAttrs = func: list:
    builtins.listToAttrs (builtins.filter
      (e: e != null)
      (builtins.map func list));

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

  self = makeEnvs // {
    inherit apps;
    inherit mapListToAttrs;
    inherit projects;
    inherit projectsMeta;
    inherit pythonVersions;
  };

  ads = ''


    $ You are using Python on Nix!

      https://github.com/kamadorueda/python-on-nix

      Found a bug? Are we missing a feature?
      Let us know in the issues section.

      Please consider starring, funding or contributing to the project!

  '';
in
builtins.trace ads self
