let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  system = "x86_64-linux";

  makes = import "${makesSrc}/src/args/agnostic.nix" { inherit system; };
  makesSrc = with lock.nodes.makes.locked;
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    };
  nixpkgs = import nixpkgsSrc { inherit system; };
  nixpkgsSrc = with lock.nodes.nixpkgs.locked;
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    };

  #

  inherit (makes) attrsGet;
  inherit (makes) attrsOptional;
  inherit (makes) fromJsonFile;
  inherit (makes) listOptional;
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
    (pythonVersions);

  #

  projectsPath = ./projects;
  projectsMeta = mapListToAttrs buildProjectMeta (lsDirs projectsPath);

  buildProjectMeta = project:
    let
      latest = getLatestVersion (builtins.attrNames versions);
      versions = mapListToAttrs
        (buildProjectVersionMeta project)
        (lsDirs (projectsPath + "/${project}"));

      metaPath = projectsPath + "/${project}/meta.json";
      meta = fromJsonFile metaPath;
      setupPath = projectsPath + "/${project}/setup.nix";
      setup =
        ({
          extraInstallers = { };
          patchClosure = closure: closure;
          searchPathsBuild = _: { };
          searchPathsRuntime = _: { };

          buildExtra = "";
          buildGccBin = false;
          buildPostgresqlBin = false;
          buildSetuptools = true;
          buildWheel = false;
          runtimeFileBin = false;
          runtimeFileRpath = false;
          runtimeFontconfigRpath = false;
          runtimeGlibRpath = false;
          runtimeGitBin = false;
          runtimeNodeBin = false;
          runtimePangoRpath = false;
          runtimeLibstdcppRpath = false;
          runtimeWants = [ ];
        }) // (if builtins.pathExists setupPath then import setupPath else { });
    in
    if versions == { }
    then null
    else {
      name = project;
      value = {
        inherit meta;
        inherit project;
        inherit setupPath;
        inherit setup;
        testPath = projectsPath + "/${project}/test.py";
        versions = versions
          // { latest = versions.${latest} // { version = "latest"; }; };
      };
    };
  buildProjectVersionMeta = project: version:
    {
      name = version;
      value = {
        installersPath = projectsPath + "/${project}/${version}/installers.json";
        pythonVersions =
          let
            pythonLatest = getLatestVersion (builtins.attrNames supported);
            supported = mapListToAttrs
              (buildProjectVersionForInterpreterMeta project version)
              (pythonVersions);
          in
          if supported == { }
          then supported
          else supported
            // {
            pythonLatest = supported.${pythonLatest}
              // { pythonVersion = "pythonLatest"; };
          };
        inherit version;
        version' = version;
      };
    };
  buildProjectVersionForInterpreterMeta = project: version: pythonVersion:
    let
      closureCommonPath = projectsPath + "/${project}/${version}/python3*.json";
      closurePath = projectsPath + "/${project}/${version}/${pythonVersion}.json";
      closure = projectsMeta.${project}.setup.patchClosure
        ((fromJsonFile closureCommonPath) // (fromJsonFile closurePath));
    in
    if builtins.pathExists closurePath
    then {
      name = pythonVersion;
      value = {
        inherit closure;
        inherit pythonVersion;
        pythonVersion' = pythonVersion;
      };
    }
    else null;

  #

  projects =
    let
      outputs =
        let outputs = builtins.mapAttrs buildProject projectsMeta;
        in outputs // { outPath = attrsToLinkFarm "python-on-nix" outputs; };

      buildProject = project: projectMeta:
        let outputs = builtins.mapAttrs
          (buildProjectVersion project)
          (projectMeta.versions);
        in
        outputs // { outPath = attrsToLinkFarm project outputs; };

      buildProjectVersion = project: version: versionMeta:
        let outputs = builtins.mapAttrs
          (buildProjectVersionForInterpreter project version)
          (versionMeta.pythonVersions);
        in
        outputs // { outPath = attrsToLinkFarm "${project}-${version}" outputs; };

      buildProjectVersionForInterpreter = project: version: pythonVersion': _:
        let
          name = "${project}-${version}-${pythonVersion}";
          outputs = makeEnv pythonVersion {
            inherit name;
            projects = { "${project}" = version; };
          };
          pythonVersion = projectsMeta.${project}.versions.${version}.pythonVersions.${pythonVersion'}.pythonVersion';
        in
        outputs // { outPath = attrsToLinkFarm name outputs; };
    in
    outputs // { outPath = attrsToLinkFarm "python-on-nix" outputs; };
  projectsForFlake = builtins.foldl'
    (all: project: all // (builtins.foldl'
      (all: version: all // (builtins.foldl'
        (all: pythonVersion: all // (mapListToAttrs
          (output: { name = output.name; value = output; })
          (builtins.attrValues projects.${project.project}.${version.version}.${pythonVersion})))
        { }
        (builtins.attrNames version.pythonVersions)))
      { }
      (builtins.attrValues project.versions)))
    { }
    (builtins.attrValues projectsMeta);
  apps = builtins.mapAttrs
    (project: projectMeta: builtins.mapAttrs
      (version: _: projects.${project}.${version}.pythonLatest.bin)
      (projectMeta.versions))
    (projectsMeta);

  #

  makePip = pythonVersion:
    let
      version = "21.2.4";
      name = "pip-${version}-${pythonVersion}";
      mirror = makePypiMirror "pip" [
        (makePypiInstaller pythonVersion "pip" version)
      ];
      python = nixpkgs.${pythonVersion};
    in
    makeDerivation {
      builder = ''
        python -m venv --symlinks --system-site-packages venv
        source venv/bin/activate
        python -m pip install \
          --disable-pip-version-check \
          --force-reinstall \
          --index-url file://$envMirror \
          --no-cache-dir \
          --no-compile \
          --no-deps \
          --no-warn-script-location \
          --quiet \
          --prefix $out \
          --upgrade \
          pip
      '';
      env.envMirror = mirror;
      name = "${name}-out";
      searchPaths.bin = [ python ];
    };

  build = project: version': pythonVersion':
    let
      version = projectsMeta.${project}.versions.${version'}.version';
      pythonVersion = projectsMeta.${project}.versions.${version}.pythonVersions.${pythonVersion'}.pythonVersion';

      name = "${project}-${version'}-${pythonVersion'}";
      python = nixpkgs.${pythonVersion};
      setup = projectsMeta.${project}.setup;
      searchPathsBuild =
        let searchPaths = setup.searchPathsBuild searchPathsArgs;
        in
        searchPaths // {
          bin = builtins.concatLists [
            (attrsGet searchPaths "bin" [ ])
            (listOptional setup.buildGccBin nixpkgs.gcc)
            (listOptional setup.buildPostgresqlBin nixpkgs.postgresql)
          ];
          source = builtins.concatLists [
            (attrsGet searchPaths "source" [ ])
            (listOptional setup.buildSetuptools projects.setuptools.latest.${pythonVersion}.dev)
            (listOptional setup.buildWheel projects.wheel.latest.${pythonVersion}.dev)
          ];
        };
      searchPathsRuntime =
        let searchPaths = setup.searchPathsRuntime searchPathsArgs;
        in
        searchPaths // {
          bin = builtins.concatLists [
            (attrsGet searchPaths "bin" [ ])
            (listOptional setup.runtimeFileBin nixpkgs.file)
            (listOptional setup.runtimeGitBin nixpkgs.git)
            (listOptional setup.runtimeNodeBin nixpkgs.nodejs)
          ];
          rpath = builtins.concatLists [
            (attrsGet searchPaths "rpath" [ ])
            (listOptional setup.runtimeFileRpath nixpkgs.file)
            (listOptional setup.runtimeFontconfigRpath nixpkgs.fontconfig.lib)
            (listOptional setup.runtimeGlibRpath nixpkgs.glib.out)
            (listOptional setup.runtimePangoRpath nixpkgs.pango.out)
            (listOptional setup.runtimeLibstdcppRpath nixpkgs.gcc.cc.lib)
          ];
        };

      installers = builtins.concatLists [
        (mapAttrsToList
          (makePypiInstaller pythonVersion)
          (setup.extraInstallers))
        [ (makePypiInstaller pythonVersion project version) ]
      ];

      searchPathsArgs = {
        inherit nixpkgs;
        pythonOnNix = self;
        inherit pythonVersion;
      };

      pip = makePip pythonVersion;

      venvContents = makeDerivation {
        builder = ''
          export DETERMINISTIC_BUILD=1
          export LANG=C.UTF-8
          export PYTHONDONTWRITEBYTECODE=1
          export PYTHONIOENCODING=UTF-8
          export PYTHONPYCACHEPREFIX=$PWD
          export PYTHONHASHSEED=0
          export PYTHONNOUSERSITE=1
          python -m pip install \
            --disable-pip-version-check \
            --index-url file://$envMirror \
            --no-cache-dir \
            --no-compile \
            --no-deps \
            --no-warn-script-location \
            --prefix $out \
            --quiet \
            ${project}==${version}

          ${setup.buildExtra}
        '';
        env.envMirror = makePypiMirror name installers;
        name = "${name}-out";
        searchPaths = {
          bin = [ python ];
          pythonPackage36 = optional (pythonVersion == "python36") pip;
          pythonPackage37 = optional (pythonVersion == "python37") pip;
          pythonPackage38 = optional (pythonVersion == "python38") pip;
          pythonPackage39 = optional (pythonVersion == "python39") pip;
          source = [ (makeSearchPaths searchPathsBuild) ];
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
          bin = [ python venvContents ];
          pythonPackage36 = optional (pythonVersion == "python36") venvContents;
          pythonPackage37 = optional (pythonVersion == "python37") venvContents;
          pythonPackage38 = optional (pythonVersion == "python38") venvContents;
          pythonPackage39 = optional (pythonVersion == "python39") venvContents;
          source = [ (makeSearchPaths searchPathsRuntime) ];
        };
        name = "${name}-dev";
      };
    in
    {
      out = venvContents;
      dev = venvSearchPaths;
    };

  #

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
      exe = builtins.match "(.*?)-(.*).(.*?).exe" name;
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
        else if exe != null
        then {
          type = "exe";
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
  makePypiMirror = name: installers:
    nixpkgs.linkFarm "mirror-for-${name}" (
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

  #

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
    let
      makeClosure = projects:
        let
          closureDirect = builtins.foldl'
            (closure: { name, value }:
              closure
              // { "${name}" = value; }
              // projectsMeta.${name}.versions.${value}.pythonVersions.${pythonVersion}.closure)
            { }
            (attrsToList projects);

          closureDirectPlusRuntimeWanted = builtins.foldl'
            (closure: { name, value }:
              builtins.foldl'
                (closure: project:
                  if builtins.hasAttr project closure
                  then closure
                  else closure // (makeClosure { "${project}" = "latest"; }))
                (closure)
                (projectsMeta.${name}.setup.runtimeWants))
            (closureDirect)
            (attrsToList closureDirect);
        in
        closureDirectPlusRuntimeWanted;

      closureBuilt = builtins.mapAttrs
        (project: version: build project version pythonVersion)
        (makeClosure projects);

      closureBinaries = makeDerivation {
        builder = ''
          shopt -s nullglob

          mkdir $out
          mkdir $out/bin

          for content in $envClosureContents; do
            for bin in $content/bin/*; do
              bin_basename="$(basename "$bin")"
              {
                echo "#! $envBash/bin/bash"
                echo
                echo source $envClosureSearchPaths/setup
                echo
                echo "'$bin' \"\$@\""
              } > "$out/bin/$bin_basename"
              if test -x "$bin"; then
                chmod +x "$out/bin/$bin_basename"
              fi
            done
          done
        '';
        env = {
          envBash = nixpkgs.bash;
          envClosureContents = mapAttrsToList
            (_: outputs: outputs.out)
            (closureBuilt);
          envClosureSearchPaths = closureSearchPaths;
        };
        name = "${name}-bin";
      };
      closureContents = attrsToLinkFarm "${name}-out" (builtins.mapAttrs
        (project: outputs: outputs.out)
        (closureBuilt));
      closureSearchPaths = makeDerivation {
        builder = ''
          mkdir $out
          mkdir $out/nix-support
          ln -s $envDev/template $out/setup
          ln -s $envDev/template $out/template
          ln -s $envDev/template $out/nix-support/setup-hook
        '';
        env.envDev = makeSearchPaths {
          source = mapAttrsToList (_: outputs: outputs.dev) closureBuilt;
        };
        name = "${name}-dev";
      };

      closureTests = attrsToLinkFarm "${name}-test" (builtins.mapAttrs
        (project: outputs: makeDerivation {
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
            if test -e lib/python*/site-packages; then
              find -L lib/python*/site-packages \
                -exec du -B KiB {} \; \
                -maxdepth 1 \
                -mindepth 1 \
                -type d
            fi
            popd
            echo

            source $envClosureSearchPaths/setup

            if test -n "$envTest"; then python $envTest; fi

            touch $out
          '';
          env = {
            envClosureSearchPaths = closureSearchPaths;
            envTest = projectsMeta.${project}.testPath;
            envVenvContents = outputs.out;
          };
          name = "${name}-test";
          searchPaths.bin = [ nixpkgs.findutils ];
        })
        (closureBuilt));

      outputs = {
        bin = closureBinaries;
        dev = closureSearchPaths;
        out = closureContents;
        test = closureTests;
      };
    in
    outputs // { outPath = outputs.dev; };

  #
  attrsToList = mapAttrsToList (name: value: { inherit name value; });
  attrsToLinkFarm = name: attrs:
    nixpkgs.linkFarm name (mapAttrsToList
      (name: path: { inherit name path; })
      attrs);
  getLatestVersion = versions: builtins.head (builtins.sort
    (a: b: (builtins.compareVersions a b) > 0)
    versions);
  lsDirs = path:
    let contents = builtins.readDir path;
    in
    builtins.filter
      (name: contents.${name} == "directory")
      (builtins.attrNames contents);
  mapAttrsToList = func: attrs:
    builtins.attrValues (builtins.mapAttrs func attrs);
  mapListToAttrs = func: list:
    builtins.listToAttrs (builtins.filter
      (e: e != null)
      (builtins.map func list));

  #

  self = makeEnvs // {
    inherit apps;
    inherit mapListToAttrs;
    inherit projects;
    inherit projectsForFlake;
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
