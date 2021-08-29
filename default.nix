{ nixpkgs ? import <nixpkgs> { }
}:
let
  # Import: https://github.com/fluidattacks/makes
  makesSrc = nixpkgs.fetchzip {
    url = "https://github.com/fluidattacks/makes/archive/5c973a6031a5858200d1524d8248401d5922a38b.tar.gz";
    sha256 = "02kf2qikvlqib5vqrcz0zdwkm90wpw9j60m02170gvy2n115g0x8";
  };
  makes = import "${makesSrc}/src/args/agnostic.nix" { };

  pkgsSrc = ./pkgs;

  ls = dir: builtins.attrNames (builtins.readDir dir);

  buildProjects = pythonVersion:
    builtins.foldl'
      (projects: project: projects // (buildProject project))
      { }
      (ls pkgsSrc);

  buildProject = project:
    let
      versions = buildProjectVersions project;
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

  buildProjectVersions = project:
    builtins.foldl'
      (versions: version: versions // { "${version}" = null; })
      { }
      (ls (pkgsSrc + "/${project}"));
in
{
  python36Packages = buildProjects "3.6";
  python37Packages = buildProjects "3.7";
  python38Packages = buildProjects "3.8";
  python39Packages = buildProjects "3.9";
}
