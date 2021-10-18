let
  # import projects as explained in previous sections
  nixpkgs = import <nixpkgs> { };
  pythonOnNix = import
    (builtins.fetchGit {
      ref = "main";
      # url = "https://github.com/on-nix/python";
      url = ../.;
    })
    { inherit nixpkgs; };

  # Create a Python on Nix environment
  env = pythonOnNix.python39Env {
    name = "example";
    projects = {
      awscli = "1.20.31";
      numpy = "latest";
      requests = "latest";
      torch = "1.9.0";
    };
  };
in
nixpkgs.stdenv.mkDerivation {
  buildInputs = [ env ];
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
}
