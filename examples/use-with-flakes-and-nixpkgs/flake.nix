{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "/data/github/kamadorueda/python-on-nix";
  };
  outputs = { nixpkgs, pythonOnNix, self, ... }: {
    packages.x86_64-linux = {
      example = pythonOnNix.lib.python39Env {
        name = "example";
        projects = {
          awscli = "1.20.31";
          numpy = "latest";
          requests = "latest";
          torch = "1.9.0";
        };
      };

      something = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
        buildInputs = [ self.packages.x86_64-linux.example ];
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
        name = "example";
      };
    };
  };
}
