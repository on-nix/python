{
  inputs = {
    makes.url = "github:fluidattacks/makes";
    makes.flake = false;
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { nixpkgs, ... }:
    let
      nixpkgsPython = import ./default.nix;

      inherit (nixpkgs.lib.strings) removeSuffix;
      inherit (nixpkgsPython) mapAttrsToList;
      inherit (nixpkgsPython) mapListToAttrs;
    in
    {
      packages.x86_64-linux = builtins.foldl'
        (all: project: all // (builtins.foldl'
          (all: version: all // (mapListToAttrs
            (pythonVersion:
              if builtins.hasAttr pythonVersion version
              then {
                name = removeSuffix "-dev" version.${pythonVersion}.dev.name;
                value = version.${pythonVersion}.dev;
              }
              else null)
            (nixpkgsPython.pythonVersions)))
          { }
          (project.__values__)))
        { }
        (nixpkgsPython.projects.__values__);
    };
}
