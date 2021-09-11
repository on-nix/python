{
  inputs = {
    makes.url = "github:fluidattacks/makes";
    makes.flake = false;
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = inputs:
    let
      nixpkgsPython = import ./default.nix;
    in
    {
      packages.x86_64-linux = builtins.mapAttrs
        (project: versions: versions.outPath)
        (nixpkgsPython.projects);
    };
}
