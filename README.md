# Nixpkgs Python

Extensive collection
of [Python][PYTHON] projects
from the [Python Packaging Index][PYPI].
That can be installed with the [Nix][NIX] package manager.

## Repository state

- Scope:
  - :heavy_check_mark:
    All [active python releases][PYTHON_RELEASES] (`3.6`, `3.7`, `3.8`, `3.9`)
  - :heavy_check_mark: 270+ projects already packaged, 310+ versions
- Quality:
  - :heavy_check_mark: Pure and reproducible (Nix with sandbox)
  - :heavy_check_mark: Hashes everywhere (fixed-output derivations)
  - :heavy_check_mark: Secure (No supply-chain attacks)
  - :heavy_check_mark: No broken packages, if it's there, it works!
  - :heavy_check_mark: Projects are tested
- Platforms:
  - :heavy_check_mark: Linux x86-64
  - :construction: MacOS x86-64
- Performance:
  - :heavy_check_mark: We **always** pick [Wheels][PYTHON_WHEELS]
  - :heavy_check_mark: A highly granular cache
  - :heavy_check_mark: Available on [Cachix][CACHIX_NIXPKGS_PYTHON]

## Using

### Available projects

Checkout the [projects](./projects) folder,
each entry represents a project and its available versions,
for example:
- `"awscli"`, or
- `"awscli-1.20.31"`

The format is in general like this:
- `"project"`: To reference the latest version.
- `"project-version"`: To reference a specific version.

### Importing

In order to use this repository you need to import it
into your project. For example:

```nix
let
  nixpkgs = import <nixpkgs> { };

  nixpkgsPython = import (nixpkgs.fetchFromGitHub {
    owner = "kamadorueda";
    repo = "nixpkgs-python";
    # Pick a commit from this list:
    # https://github.com/kamadorueda/nixpkgs-python/commits/main
    rev = "0000000000000000000000000000000000000000";
    # Update this manually
    sha256 = "0000000000000000000000000000000000000000000000000000";
  });
in
# Keep reading for more information
```

### makeEnv

Cook an environment where the desired [Python][PYTHON] projects
are present.

Example:

```nix
nixpkgsPython.makeEnv {
  name = "example";
  projects = [
    "awscli-1.20.31" # Version `1.20.32` of `awscli`
    "numpy" # Latest version of `numpy`
    "requests" # Latest version of `requests`
    "torch-1.9.0" # Version `1.9.0` of `torch`
  ];
  pythonVersion = "3.9";
}
```

Valid `pythonVersion`s are: `3.6`, `3.7`, `3.8` and `3.9`.

The output contains a setup script that you can `source`.
For instance:

```bash
# Build your environment
$ nix-build /path/to/my/env.nix

# Source it's output
$ source ./result/setup
```

Dependencies are not available in this shell !! :rocket:

```bash
$ python --version

  Python 3.9.6

$ aws --version

  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.57 botocore/1.21.31

$ python -c 'import numpy; print(numpy.__version__)'

  1.21.2

$ python -c 'import requests; print(requests.__version__)'

  2.26.0

$ python -c 'import torch; print(torch.__version__)'

  1.9.0+cu102
```

### Using the binary cache

You can configure [nixpkgs-python's binary cache][CACHIX_NIXPKGS_PYTHON]
to speed up your builds.

---

[CACHIX]: https://www.cachix.org/
[CACHIX_NIXPKGS_PYTHON]: https://app.cachix.org/cache/nixpkgs-python
[NIX]: https://nixos.org/
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
[PYTHON_WHEELS]: https://pythonwheels.com/
