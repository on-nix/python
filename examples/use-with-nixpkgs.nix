let
  nixpkgs = import <nixpkgs> { };

  pythonOnNix = import ./.;

  env = pythonOnNix.python39Env {
    name = "example";
    projects = with pythonOnNix.projects; [
      awscli."1.20.31"
      numpy."latest"
      requests."latest"
      torch."1.9.0"
    ];
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
