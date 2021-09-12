{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgsPython.url = "github:kamadorueda/nixpkgs-python";
  };
  outputs = { nixpkgs, nixpkgsPython, self, ... }: {
    packages.x86_64-linux = {
      example = nixpkgsPython.lib.python39Env {
        name = "example";
        projects = with nixpkgsPython.lib.projects; [
          awscli."1.20.31"
          numpy."latest"
          requests."latest"
          torch."1.9.0"
        ];
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
        '';
        name = "example";
      };
    };
  };
}
