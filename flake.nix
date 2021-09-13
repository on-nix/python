{
  inputs = {
    makes.url = "github:fluidattacks/makes";
    makes.flake = false;
    nixpkgs.url = "github:nixos/nixpkgs";
  };
  outputs = { nixpkgs, ... }:
    let
      pythonOnNix = import ./default.nix;

      inherit (pythonOnNix) mapListToAttrs;
    in
    {
      lib = pythonOnNix;
      packages.x86_64-linux = builtins.foldl'
        (all: project: all // (builtins.foldl'
          (all: version: all // (builtins.foldl'
            (all: pythonVersion: all // (mapListToAttrs
              (output: { name = output.name; value = output; })
              (builtins.attrValues pythonOnNix.projects.${project.project}.${version.version}.${pythonVersion})))
            { }
            (builtins.attrNames version.pythonVersions)))
          { }
          (builtins.attrValues project.versions)))
        { }
        (builtins.attrValues pythonOnNix.projectsMeta);
    };
}
