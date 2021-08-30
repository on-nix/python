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

      closurePath =
        pkgsSrc + "/${project}/${version}/python${pythonVersion}.json";
      closure = makes.fromJsonFile closurePath;

      links = builtins.foldl'
        (links: project:
          let
            version = closure.${project};
            projectLinksPath =
              pkgsSrc + "/${project}/${version}/installers.json";
            projectLinks = makes.fromJsonFile projectLinksPath;
          in
          links ++ projectLinks)
        [ ]
        (builtins.attrNames closure);

      venv = makes.makePythonPypiEnvironment {
        inherit name;
        sourcesRaw = {
          inherit closure;
          inherit links;
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
    let src = nixpkgs.fetchFromGitHub {
      owner = "fluidattacks";
      repo = "makes";
      rev = "37acf1438aacdcbe610091a50d4b0415803b73c0";
      sha256 = "1f21zcyz7bw98x1y6sbqcxy02lqvg9mqv3jmcsqm53frb22a3hag";
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
