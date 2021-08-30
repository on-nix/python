{ nixpkgs ? import <nixpkgs> { }
}:
let
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
    # All versions
    (nixpkgs.lib.mapAttrs'
      (version: value: { name = "${project}-${version}"; inherit value; })
      (versions)) //
    # Latest version
    { "${project}" = versions.${latest}; };


  buildProjectVersions = pythonVersion: project:
    builtins.foldl'
      (versions: version:
        versions // (buildProjectVersion pythonVersion project version))
      { }
      (ls (pkgsSrc + "/${project}"));


  buildProjectVersion = pythonVersion: project: version:
    let
      name = "python${pythonVersion}-${project}-${version}";
      closure = pkgsSrc + "/${project}/${version}/closure-${pythonVersion}.json";
      links = pkgsSrc + "/${project}/${version}/files.json";

      venv = makes.makePythonPypiEnvironment {
        inherit name;
        sourcesYaml = makes.toFileYaml "${name}-sources.yaml" {
          closure = makes.fromJsonFile closure;
          links = makes.fromJsonFile links;
          python = pythonVersion;
        };
      };
    in
    { "${version}" = venv; };


  makeEnv =
    { pkgs
    , pythonVersion
    ,
    }:
    makes.makeSearchPaths {
      source = builtins.map
        (project: builtProjects.${pythonVersion}.${project})
        (pkgs);
    };

  builtProjects = {
    "3.6" = buildProjects "3.6";
    "3.7" = buildProjects "3.7";
    "3.8" = buildProjects "3.8";
    "3.9" = buildProjects "3.9";
  };

  __all__ =
    let
      makeEnvFor = pythonVersion:
        makeEnv {
          pkgs = builtins.attrNames builtProjects.${pythonVersion};
          inherit pythonVersion;
        };
    in
    nixpkgs.linkFarm "nixpkgs-python"
      (builtins.map
        (pythonVersion: {
          name = pythonVersion;
          path = makeEnvFor pythonVersion;
        })
        [ "3.6" "3.7" "3.8" "3.9" ]);

  ls = dir: builtins.attrNames (builtins.readDir dir);
  makes =
    let src = nixpkgs.fetchzip {
      url = "https://github.com/fluidattacks/makes/archive/5c973a6031a5858200d1524d8248401d5922a38b.tar.gz";
      sha256 = "02kf2qikvlqib5vqrcz0zdwkm90wpw9j60m02170gvy2n115g0x8";
    };
    in import "${src}/src/args/agnostic.nix" { };
in
{
  inherit __all__;
  inherit makeEnv;
  python36Packages = builtProjects."3.6";
  python37Packages = builtProjects."3.7";
  python38Packages = builtProjects."3.8";
  python39Packages = builtProjects."3.9";
}
