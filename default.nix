{
  nixpkgs ? null,
  system ? null,
  ...
}
@ evalConfig:
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);

  system =
    if (builtins.hasAttr "system" evalConfig) && evalConfig.system != null
    then evalConfig.system
    else builtins.currentSystem;

  makes =
    with lock.nodes.makes.locked; let
      src = builtins.fetchTarball {
        url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        sha256 = narHash;
      };
    in
      import "${src}/src/args/agnostic.nix" { inherit system; };

  nixpkgs =
    if (builtins.hasAttr "nixpkgs" evalConfig) && evalConfig.nixpkgs != null
    then evalConfig.nixpkgs
    else
      with lock.nodes.nixpkgs.locked; let
        src = builtins.fetchTarball {
          url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
          sha256 = narHash;
        };
      in
        import src { inherit system; };

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

  pythonVersions = builtins.filter
  (pythonVersion: builtins.hasAttr pythonVersion nixpkgs)
  [ "python37" "python38" "python39" "python310" ];
  pythons = builtins.map
  (pythonVersion: nixpkgs.${pythonVersion})
  (pythonVersions);

  #

  projectsPath = ./projects;
  projectsMeta = mapListToAttrs buildProjectMeta (lsDirs projectsPath);

  buildProjectMeta = project: let
    latest = getLatestVersion (builtins.attrNames versions);
    versions = mapListToAttrs
    (buildProjectVersionMeta project)
    (lsDirs (projectsPath + "/${project}"));

    metaPath = projectsPath + "/${project}/meta.json";
    meta = fromJsonFile metaPath;
    setupPath = projectsPath + "/${project}/setup.nix";
    setup =
      (
        {
          extraInstallers = { };
          patchClosure = closure: closure;
          searchPathsBuild = _: { };
          searchPathsRuntime = _: { };

          buildExtra = "";
          buildGccBin = false;
          buildPostgresqlBin = false;
          buildSetuptools_57_5_0 = false;
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
          runtimeZlibRpath = false;
        }
      )
      // (
        if builtins.pathExists setupPath
        then import setupPath
        else { }
      );
  in
    if versions == { }
    then null
    else
      {
        name = project;
        value = {
          inherit meta;
          inherit project;
          inherit setupPath;
          inherit setup;
          testPath = projectsPath + "/${project}/test.py";
          versions =
            versions
            // { latest = versions.${latest} // { version = "latest"; }; };
        };
      };
  buildProjectVersionMeta = project: version: {
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
          else
            supported
            // {
              pythonLatest =
                supported.${pythonLatest}
                // { pythonVersion = "pythonLatest"; };
            };
      inherit version;
      version' = version;
    };
  };
  buildProjectVersionForInterpreterMeta = project: version: pythonVersion: let
    closureCommonPath = projectsPath + "/${project}/${version}/python3*.json";
    closurePath = projectsPath + "/${project}/${version}/${pythonVersion}.json";
    closure = projectsMeta.${project}.setup.patchClosure
    ((fromJsonFile closureCommonPath) // (fromJsonFile closurePath));
  in
    if builtins.pathExists closurePath
    then
      {
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
        let
          outputs = builtins.mapAttrs buildProject projectsMeta;
        in
          outputs // { outPath = attrsToLinkFarm "python-on-nix" outputs; };

      buildProject = project: projectMeta: let
        outputs = builtins.mapAttrs
        (buildProjectVersion project)
        (projectMeta.versions);
      in
        outputs // { outPath = attrsToLinkFarm project outputs; };

      buildProjectVersion = project: version: versionMeta: let
        outputs = builtins.mapAttrs
        (buildProjectVersionForInterpreter project version)
        (versionMeta.pythonVersions);
      in
        outputs // { outPath = attrsToLinkFarm "${project}-${version}" outputs; };

      buildProjectVersionForInterpreter = project: version: pythonVersion': _: let
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
  flakeOutputs = {
    devShells = builtins.foldl'
    (
      all: project:
        all
        // (
          builtins.foldl'
          (
            all: version:
              all
              // (
                builtins.foldl'
                (
                  all: pythonVersion:
                    all
                    // {
                      "${project.project}-${version.version}-${pythonVersion}" =
                        projects.${project.project}.${version.version}.${pythonVersion}.dev;
                    }
                )
                { }
                (builtins.attrNames version.pythonVersions)
              )
          )
          { }
          (builtins.attrValues project.versions)
        )
    )
    { }
    (builtins.attrValues projectsMeta);
    lib = makeEnvs;
    packages = builtins.foldl'
    (
      all: project:
        all
        // (
          builtins.foldl'
          (
            all: version:
              all
              // (
                builtins.foldl'
                (
                  all: pythonVersion:
                    all
                    // (
                      mapListToAttrs
                      (
                        output: {
                          name = output.name;
                          value = output;
                        }
                      )
                      (builtins.attrValues projects.${project.project}.${version.version}.${pythonVersion})
                    )
                )
                { }
                (builtins.attrNames version.pythonVersions)
              )
          )
          { }
          (builtins.attrValues project.versions)
        )
    )
    { }
    (builtins.attrValues projectsMeta);
  };
  apps = builtins.mapAttrs
  (
    project: projectMeta:
      builtins.mapAttrs
      (version: _: projects.${project}.${version}.pythonLatest.bin)
      (projectMeta.versions)
  )
  (projectsMeta);

  #

  makePip = pythonVersion: let
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

  build = project: version': pythonVersion': let
    version = projectsMeta.${project}.versions.${version'}.version';
    pythonVersion = projectsMeta.${project}.versions.${version}.pythonVersions.${pythonVersion'}.pythonVersion';

    name = "${project}-${version'}-${pythonVersion'}";
    python = nixpkgs.${pythonVersion};
    setup = projectsMeta.${project}.setup;
    searchPathsBuild =
      let
        searchPaths = setup.searchPathsBuild searchPathsArgs;
      in
        searchPaths
        // {
          bin = builtins.concatLists [
            (attrsGet searchPaths "bin" [ ])
            (listOptional setup.buildGccBin nixpkgs.gcc)
            (listOptional setup.buildPostgresqlBin nixpkgs.postgresql)
          ];
          source = builtins.concatLists [
            (attrsGet searchPaths "source" [ ])
            (listOptional setup.buildSetuptools_57_5_0 projects.setuptools."57.5.0".${pythonVersion}.dev)
            (listOptional setup.buildWheel projects.wheel.latest.${pythonVersion}.dev)
          ];
        };
    searchPathsRuntime =
      let
        searchPaths = setup.searchPathsRuntime searchPathsArgs;
      in
        searchPaths
        // {
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
            (listOptional setup.runtimeZlibRpath nixpkgs.zlib.out)
          ];
        };

    installers = builtins.concatLists [
      (
        mapAttrsToList
        (makePypiInstaller pythonVersion)
        (setup.extraInstallers)
      )
      [ (makePypiInstaller pythonVersion project version) ]
    ];

    searchPathsArgs = {
      inherit makes;
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
        export = [ [ "PYTHONPATH" pip "/${python.sitePackages}" ] ];
        source = [ (makeSearchPaths searchPathsBuild) ];
      };
    };
    venvSearchPaths =
      let
        wrapped = makeSearchPaths {
          bin = [ python venvContents ];
          export = [ [ "PYTHONPATH" venvContents "/${python.sitePackages}" ] ];
          source = [ (makeSearchPaths searchPathsRuntime) ];
        };
      in
        nixpkgs.stdenv.mkDerivation {
          builder = builtins.toFile "builder.sh" ''
            source $stdenv/setup

            mkdir $out
            mkdir $out/nix-support

            ln -s $envWrapped/template $out/setup
            ln -s $envWrapped/template $out/template
            ln -s $envWrapped/template $out/nix-support/setup-hook
          '';
          envWrapped = wrapped;
          name = "${name}-dev";
          shellHook = ''
            echo ---
            echo Activating Python on Nix environment: ${name}
            echo
            echo Enjoy!
            echo ---
            source ${wrapped}/template
          '';
        };
  in
    {
      out = venvContents;
      dev = venvSearchPaths;
    };

  #

  supportedArchs =
    [ "any" ]
    ++ (optional (isDarwin) "macosx_10_9_universal2")
    ++ (optional (isDarwin && isx86_64) "macosx_10_9_x86_64")
    ++ (optional (isDarwin && isx86_64) "macosx_10_14_x86_64")
    ++ (optional (isDarwin && isi686) "macosx_10_9_i686")
    ++ (optional (isDarwin && isi686) "macosx_10_14_i686")
    ++ (optional (isLinux && isx86_64) "manylinux1_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux_2_5_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux_2_12_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux_2_24_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux2010_x86_64")
    ++ (optional (isLinux && isx86_64) "manylinux2014_x86_64")
    ++ (optional (isLinux && isi686) "manylinux1_i686")
    ++ (optional (isLinux && isi686) "manylinux_2_5_i686")
    ++ (optional (isLinux && isi686) "manylinux_2_12_i686")
    ++ (optional (isLinux && isi686) "manylinux_2_24_i686")
    ++ (optional (isLinux && isi686) "manylinux2010_i686")
    ++ (optional (isLinux && isi686) "manylinux2014_i686");
  supportedAbis =
    {
      "python37" = [ "none" "abi3" "cp37" "cp37m" ];
      "python38" = [ "none" "abi3" "cp38" "cp38m" ];
      "python39" = [ "none" "abi3" "cp39" "cp39m" ];
      "python310" = [ "none" "abi3" "cp310" "cp10m" ];
    };
  supportedPythonImplementations =
    {
      "python37" = [ "any" "cp37" "py3" "py37" "3.7" ];
      "python38" = [ "any" "cp38" "py3" "py38" "3.8" ];
      "python39" = [ "any" "cp39" "py3" "py39" "3.9" ];
      "python310" = [ "any" "cp310" "py3" "py310" "3.10" ];
    };
  isSupported = required: supported:
    builtins.any (elem: builtins.elem elem supported) required;
  isSupportedWheel = pythonVersion: (
    installer:
      installer.type
      == "whl"
      && isSupported installer.abis supportedAbis.${pythonVersion}
      && isSupported installer.archs supportedArchs
      && (
        (isSupported installer.abis [ "abi3" ])
        ||
        (isSupported installer.pys supportedPythonImplementations.${pythonVersion})
      )
  );
  isSupportedSrc = installer: installer.type == "src";

  enrichInstaller = pythonVersion: project: version: name: sha256: let
    egg = builtins.match "(.*)-(.*?)-(.*).egg" name;
    exe = builtins.match "(.*?)-(.*).(.*?).exe" name;
    src = builtins.match "(.*)-(.*?).(tar.bz2|tar.gz|zip)" name;
    whl = builtins.match "(.*?)-(.*)-(.*?)-(.*?)-(.*?).whl" name;
    meta =
      if whl != null
      then
        rec {
          abis = splitString "." (builtins.elemAt whl 3);
          archs = splitString "." (builtins.elemAt whl 4);
          impl = builtins.elemAt whl 2;
          pys = splitString "." impl;
          type = "whl";
        }
      else if src != null
      then
        {
          ext = builtins.elemAt src 2;
          type = "src";
        }
      else if egg != null
      then
        {
          type = "egg";
        }
      else if exe != null
      then
        {
          type = "exe";
        }
      else abort "Unable to parse installer: ${name}";
    projectL = builtins.substring 0 1 project;
    base = "https://files.pythonhosted.org/packages";
    impls =
      [ meta.impl ]
      ++ (builtins.map (py: py.pythonVersion) pythons)
      ++ [ "py2.py3" "py3" "3.6" "3.5" "2.7" ];
  in
    meta
    // {
      inherit name;
      inherit project;
      path = nixpkgs.fetchurl {
        inherit name;
        inherit sha256;
        urls =
          if meta.type == "src"
          then [ "${base}/source/${projectL}/${project}/${name}" ]
          else
            (
              builtins.map
              (impl: "${base}/${impl}/${projectL}/${project}/${name}")
              (impls)
            );
      };
    };

  makePypiInstaller = pythonVersion: project: version: let
    installersPath = projectsMeta.${project}.versions.${version}.installersPath;
    installers = mapAttrsToList
    (enrichInstaller pythonVersion project version)
    (fromJsonFile installersPath);
    installer = findFirst (installer: installer != null) null (
      builtins.map
      (predicate: findFirst predicate null installers)
      [
        (isSupportedWheel pythonVersion)
        (isSupportedSrc)
      ]
    );
  in
    if installer == null
    then
      abort ''


        ${pythonVersion} installer not found:
        ${
        builtins.concatStringsSep "\n"
        (builtins.map (i: i.name) installers)
      }

      ''
    else installer;
  makePypiMirror = name: installers:
    nixpkgs.linkFarm "mirror-for-${name}" (
      (
        builtins.map
        (
          installer: {
            name = "${installer.project}/index.html";
            path = builtins.toFile "${installer.project}-index.html" ''
              <html><body>
                <a href="./${installer.name}">${installer.name}</a>
              </body></html>
            '';
          }
        )
        (installers)
      )
      ++ (
        builtins.map
        (
          installer: {
            name = "${installer.project}/${installer.name}";
            path = installer.path;
          }
        )
        (installers)
      )
      ++ [
        {
          name = "index.html";
          path =
            builtins.toFile "index.html" ''
              <html><body>
                ${
              builtins.concatStringsSep " " (
                builtins.map
                (installer: "<a href=/${installer.project}/>${installer.project}</a>")
                (installers)
              )
            }
              </body></html>
            '';
        }
      ]
    );

  #

  makeEnvs =
    mapListToAttrs
    (
      pythonVersion: {
        name = "${pythonVersion}Env";
        value = makeEnv pythonVersion;
      }
    )
    pythonVersions;
  makeEnv = pythonVersion:
    {
      name,
      projects,
    }:
    let
      makeClosure = projects: let
        closureDirect = builtins.foldl'
        (
          closure:
            {
              name,
              value,
            }:
              closure
              // { "${name}" = value; }
              // (
                let
                  projectData =
                    if builtins.hasAttr name projectsMeta
                    then projectsMeta.${name}
                    else
                      builtins.abort ''


                        Ups! Project "${name}" is not On Nix already.

                        A few tips that may help:

                        - Please check that you typed the project name correctly
                          and that it exists on PyPI:
                          https://pypi.org/project/${name}

                        - Please create an issue
                          requesting the adition of ${name}, here:
                          https://github.com/on-nix/python/issues

                        Thanks!

                      '';
                  versionData =
                    if builtins.hasAttr value projectData.versions
                    then projectData.versions.${value}
                    else
                      builtins.abort ''


                        Ups! Version "${value}" is not available for ${name} already.

                        A few tips that may help:

                        - Please check that you typed the version correctly
                          and that it exists on PyPI:
                          https://pypi.org/project/${name}/#history

                        - Please create an issue
                          requesting the adition of ${name} (${value}), here:
                          https://github.com/on-nix/python/issues

                        Thanks!

                      '';

                  pythonVersionData =
                    if builtins.hasAttr pythonVersion versionData.pythonVersions
                    then versionData.pythonVersions.${pythonVersion}
                    else
                      builtins.abort ''


                        Ups! ${name} (${value}) is not available for ${pythonVersion}.

                        Certain projects do not support ${pythonVersion}
                        and therefore we cannot support them On Nix.

                        If you believe this is not the case
                        and the project does support ${pythonVersion};
                        Please create an issue
                        requesting the adition of ${pythonVersion} support
                        to ${name} (${value}), here:
                        https://github.com/on-nix/python/issues

                        Thanks!

                      '';
                in
                  pythonVersionData.closure
              )
        )
        { }
        (attrsToList projects);

        closureDirectPlusRuntimeWanted = builtins.foldl'
        (
          closure:
            {
              name,
              value,
            }:
              builtins.foldl'
              (
                closure: project:
                  if builtins.hasAttr project closure
                  then closure
                  else closure // (makeClosure { "${project}" = "latest"; })
              )
              (closure)
              (projectsMeta.${name}.setup.runtimeWants)
        )
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
      closureContents = attrsToLinkFarm "${name}-out" (
        builtins.mapAttrs
        (project: outputs: outputs.out)
        (closureBuilt)
      );
      closureSearchPaths =
        let
          dev = makeSearchPaths {
            source = mapAttrsToList (_: outputs: outputs.dev) closureBuilt;
          };
        in
          nixpkgs.stdenv.mkDerivation {
            builder = builtins.toFile "builder.sh" ''
              source $stdenv/setup
              mkdir $out
              mkdir $out/nix-support
              ln -s $envDev/template $out/setup
              ln -s $envDev/template $out/template
              ln -s $envDev/template $out/nix-support/setup-hook
            '';
            envDev = dev;
            name = "${name}-dev";
            shellHook = ''
              echo ---
              echo Activating Python on Nix environment: ${name}
              echo
              echo Enjoy!
              echo ---
              source ${dev}/template
            '';
          };

      closureTests = attrsToLinkFarm "${name}-test" (
        builtins.mapAttrs
        (
          project: outputs:
            makeDerivation {
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
                popd > /dev/null
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
            }
        )
        (closureBuilt)
      );

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
    nixpkgs.linkFarm name (
      mapAttrsToList
      (name: path: { inherit name path; })
      attrs
    );
  getLatestVersion = versions:
    builtins.head (
      builtins.sort
      (a: b: (builtins.compareVersions a b) > 0)
      versions
    );
  lsDirs = path: let
    contents = builtins.readDir path;
  in
    builtins.filter
    (name: contents.${name} == "directory")
    (builtins.attrNames contents);
  mapAttrsToList = func: attrs:
    builtins.attrValues (builtins.mapAttrs func attrs);
  mapListToAttrs = func: list:
    builtins.listToAttrs (
      builtins.filter
      (e: e != null)
      (builtins.map func list)
    );

  #

  self =
    makeEnvs
    // {
      inherit apps;
      inherit flakeOutputs;
      inherit projects;
      inherit projectsMeta;
      inherit pythonVersions;
    };

  ads = ''


    $ You are using Python on Nix!

      Repo: https://github.com/on-nix/python
      Home: https://python.on-nix.com
      Funding: https://patreon.com/kamadorueda

      Found a bug? Are we missing a feature?
      Want us to package a new project or version?
      Let us know in the issues section.

      Please consider starring, funding, or contributing to the project!

  '';
in
builtins.trace ads self
