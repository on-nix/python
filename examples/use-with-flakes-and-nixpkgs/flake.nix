{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    # pythonOnNix.url = "github:on-nix/python";
    pythonOnNix.url = "/data/github/on-nix/python";
  };
  outputs = { self, ... } @ inputs:
    inputs.flakeUtils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
        pythonOnNix = inputs.pythonOnNix.lib {
          # You can also omit this parameter
          # in order to use a default `nixpkgs` bundled with Python on Nix
          inherit nixpkgs;
          inherit system;
        };
      in
      {
        packages = rec {

          example = (pythonOnNix.python39Env {
            name = "example";
            projects = {
              awscli = "1.20.31";
              numpy = "latest";
              requests = "latest";
              torch = "1.9.0";
            };
          }).dev;

          something = nixpkgs.stdenv.mkDerivation {
            buildInputs = [ example ];
            builder = builtins.toFile "builder.sh" ''
              source $stdenv/setup

              set -x

              python --version
              aws --version
              python -c 'import numpy; print(numpy.__version__)'
              python -c 'import requests; print(requests.__version__)'
              python -c 'import torch; print(torch.__version__)'

              touch $out

              set +x
            '';
            name = "something";
          };

        };
      }
    );
}
