{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = {
    flakeUtils,
    nixpkgs,
    ...
  }: let
    systems = ["x86_64-linux"];
    systemOutputs = system: let
      pythonOnNix = import ./default.nix {
        nixpkgs = nixpkgs.legacyPackages.${system};
        nixpkgsSrc = nixpkgs.sourceInfo.outPath;
        inherit system;
      };
    in
      pythonOnNix.flakeOutputs;
  in (flakeUtils.lib.eachSystem systems systemOutputs);
}
