let
  nixpkgs = import <nixpkgs> { };

  nixpkgsPython = import ./.;

  env = nixpkgsPython.makeEnv {
    name = "example";
    projects = [
      "awscli-1.20.31" # Version `1.20.32` of `awscli`
      "numpy" # Latest version of `numpy`
      "requests" # Latest version of `requests`
      "torch-1.9.0" # Version `1.9.01 of `torch`
    ];
    pythonVersion = "3.9";
  };
in
nixpkgs.stdenv.mkDerivation {
  builder = builtins.toFile "test" ''
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
  buildInputs = [ env ];
}
