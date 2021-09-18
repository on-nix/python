{
  inputs = {
    makes.url = "github:fluidattacks/makes";
    makes.flake = false;
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { nixpkgs, ... }:
    let
      pythonOnNix = import ./default.nix;
      system = "x86_64-linux";
    in
    {
      lib = pythonOnNix;
      packages.${system} = pythonOnNix.projectsForFlake;
    };
}
