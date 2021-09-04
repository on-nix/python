{ nixpkgs ? import <nixpkgs> { }
}:
let
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
            projectInstallers = makes.fromJsonFile projectInstallersPath;
          in
          installers ++ projectInstallers)
        [ ]
        (builtins.attrNames closure);

      # Post-processed inputs
      closure = setup.patchClosure closureRaw;
      installers = setup.patchInstallers installersRaw;
      searchPaths = setup.searchPaths { inherit nixpkgs; };

      venv = makes.makePythonPypiEnvironment {
        inherit name;
        inherit searchPaths;
        sourcesRaw = {
          inherit closure;
          links = installers;
          python = pythonVersion;
        };
      };
    in
    if builtins.pathExists closurePath
    then { "${version}" = venv; }
    else { };

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
