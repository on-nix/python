# Nixpkgs Python

Extensive collection
of [Python][PYTHON] projects
from the [Python Packaging Index][PYPI].
That can be installed with the [Nix][NIX] package manager.

- Scope:
  - :heavy_check_mark:
    All [active Python releases][PYTHON_RELEASES] (`3.6`, `3.7`, `3.8`, `3.9`)
  - :heavy_check_mark: 850+ projects already packaged
- Quality:
  - :heavy_check_mark: It is 100% Nix, with love :heart:
  - :heavy_check_mark: Data integrity checksums are used everywhere
  - :heavy_check_mark: We test projects before you use them
- Platforms:
  - :heavy_check_mark: Linux x86-64
  - :construction: MacOS x86-64
- Performance:
  - :heavy_check_mark: We **always** pick [Wheels][PYTHON_WHEELS]
  - :heavy_check_mark: A highly granular cache
  - :heavy_check_mark: Available on [Cachix][CACHIX_NIXPKGS_PYTHON]

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Contents

- [List of available projects](#list-of-available-projects)
- [Applications vs Libraries](#applications-vs-libraries)
- [Installing projects as applications](#installing-projects-as-applications)
- [Creating Python Environments](#creating-python-environments)
    - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs)
- [Using the binary cache](#using-the-binary-cache)
- [Contributing](#contributing)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# List of available projects

Checkout the [projects](./projects) folder,
each entry represents a project and its available versions.

For example:
- Project: `awscli` and version: `1.20.31`, or
- Project: `requests` and version `2.26.0`

# Applications vs Libraries

On Python, projects can offer two types of components:

- **Applications**: Binaries that you can run from the command line.

  For example:

  - [AWS CLI](https://pypi.org/project/awscli/): `$ aws --version`
  - [Bandit](https://pypi.org/project/bandit/): `$ bandit --version`

- **Libraries**: Packages and modules that you can import in your projects.

  For example:

  - [Boto3](https://pypi.org/project/boto3/): `>>> import boto3`
  - [Django](https://pypi.org/project/django/): `>>> import django`

- **Both**: They work either as an Application or as a Library:

  For example:

  - [PyTest](https://pypi.org/project/pytest/): `>>> import pytest`

# Installing projects as applications

If you want to **only** use the binaries of a project
you can install them on your system like this:

```bash
$ nix-env -iA 'apps."<project>"."<version>"' -f https://github.com/kamadorueda/nixpkgs-python/tarball/main
```

For example:

```bash
$ nix-env -iA 'apps."awscli"."latest"' -f https://github.com/kamadorueda/nixpkgs-python/tarball/main
```

or

```bash
$ nix-env -iA 'apps."awscli"."1.20.31"' -f https://github.com/kamadorueda/nixpkgs-python/tarball/main
```

After the process have completed,
you will be able to use the project's binaries:

```bash

$ aws --version

  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
```

:warning: You won't be able to import the project libraries with Python (`import xxx`). If you want to do this please keep reading.

# Creating Python Environments

First,
you need to import Nixpkgs Python
into your project.

For example:

```nix
# /path/to/my/env.nix

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

This repository offers you
the following functions.
Please pick the Python version of your choice:
- `python36Env`: Python 3.6
- `python37Env`: Python 3.7
- `python38Env`: Python 3.8
- `python39Env`: Python 3.9

For example:

```nix
# /path/to/my/env.nix (continuation)

nixpkgsPython.python39Env {
  name = "example";
  projects = with nixpkgsPython.projects; [
    awscli."1.20.31"
    numpy."latest"
    requests."latest"
    torch."1.9.0"
  ];
}
```

The output of this function
contains a setup script
that you can `source`:

```bash
# Build your environment
$ nix-build /path/to/my/env.nix

# Source it's output
$ source ./result/setup
```

After doing this,
the specified dependencies will be available in your shell ! :rocket:

Also, you'll be able to use the applications and libraries provided
by the projects in the environment:

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

## Compatibility with Nixpkgs

You can use Nixpkgs Python and Nixpkgs together.

For example:

```nix
# /path/to/my/expression.nix

let
  # import projects as explained in previous sections
  nixpkgs = import { ... };
  nixpkgsPython = import { ... };

  # Create a Nixpkgs Python environment as explained in previous sections
  env = nixpkgsPython.python39Env {
    name = "example";
    projects = with nixpkgsPython.projects; [
      awscli."1.20.31"
      numpy."latest"
      requests."latest"
      torch."1.9.0"
    ];
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
  '';
  name = "example";
}
```

Now just `$ nix-build /path/to/my/expression.nix` ! :rocket:

```bash
these derivations will be built:
  /nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv

building '/nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv'...

+ python --version
Python 3.9.6

+ aws --version
aws-cli/1.20.31 Python/3.9.6 Linux/5.10.57 botocore/1.21.31

+ python -c 'import numpy; print(numpy.__version__)'
1.21.2

+ python -c 'import requests; print(requests.__version__)'
2.26.0

+ python -c 'import torch; print(torch.__version__)'
1.9.0+cu102

+ touch /nix/store/9cckx5zpbiakx507g253fv08hykf8msv-example
```

# Using the binary cache

You can configure [nixpkgs-python's binary cache][CACHIX_NIXPKGS_PYTHON]
to speed up your builds.

# Contributing

Anything you can think of will be appreciated!

---

[CACHIX]: https://www.cachix.org/
[CACHIX_NIXPKGS_PYTHON]: https://app.cachix.org/cache/nixpkgs-python
[NIX]: https://nixos.org/
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
[PYTHON_WHEELS]: https://pythonwheels.com/
