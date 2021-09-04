# Nixpkgs Python

Extensive collection
of [Python][PYTHON] Packages
from the [Python Packaging Index][PYPI].
That can be installed with the [Nix][NIX] package manager.

## Goal

Packaging every package on PyPI.

- :heavy_check_mark: Pure and reproducible: with Nix
- :heavy_check_mark: Linux and MacOS, all architectures
- :heavy_check_mark: Self contained units:
  The package + its python dependencies + its OS/Lib dependencies.
- :heavy_check_mark:
  All [active python releases][PYTHON_RELEASES] (`3.6`, `3.7`, `3.8`, `3.9`)

## Using

### Available packages

Checkout the [pkgs](./pkgs) folder,
each entry represents a package and its available versions,
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

  nixpkgsPython =
    let src = nixpkgs.fetchFromGitHub {
      owner = "kamadorueda";
      repo = "nixpkgs-python";
      # Pick one from this list:
      #   https://github.com/kamadorueda/nixpkgs-python/commits/main
      rev = "ee68d41b3ca8e180a65bcb78c7375dc962162e3a";
      # Update this manually
      sha256 = "0000000000000000000000000000000000000000000000000000";
    };
    in import src { };
in
# Keep reading for more information
```

### makeEnv

Cook an environment where the desired [Python][PYTHON] packages
are present.

Example:

```nix
nixpkgsPython.makeEnv {
  pkgs = [
    "awscli" # Latest
    "requests-2.26.0" # Version 2.26.0
  ];
  pythonVersion = "3.9";
}
```

Valid `pythonVersion`s are: `3.6`, `3.7`, `3.8` and `3.9`.

---

[NIX]: https://nixos.org/
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
