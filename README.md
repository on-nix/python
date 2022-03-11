# Python on Nix

Extensive collection
of [Python][python] projects
from the [Python Packaging Index][pypi].
That can be used with the [Nix][nix] package manager.

Check out the examples at [python.on-nix.com](https://python.on-nix.com/)!

- Scope:
  - :heavy_check_mark:
    All [active Python releases][python_releases]
    (`3.7`, `3.8`, `3.9`, `3.10`)
  - :heavy_check_mark: 1700+ [projects][projects] already packaged,
    prioritized by their popularity
    according to [libraries.io](https://libraries.io/PyPI)
- Quality:
  - :heavy_check_mark: It is 100% Nix, with love :heart:
  - :heavy_check_mark: Data integrity checksums are used everywhere
  - :heavy_check_mark: We test projects before you use them
- Platforms:
  - :heavy_check_mark: Linux x86-64
  - :construction: MacOS x86-64
- Performance:
  - :heavy_check_mark: Every project is built with a minimal closure and size
  - :heavy_check_mark: A highly granular cache

Why?

To make using [Nix][nix] on [Python][python] projects
as simple as possible!

Just:

1. Copy and paste the examples,
2. Select the [Python][python] projects of your choice,
3. Enjoy! :rocket:

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

# Contents

- [List of available projects](#list-of-available-projects)
- [Concepts](#concepts)
  - [Applications and Libraries](#applications-and-libraries)
- [Using with Nix stable](#using-with-nix-stable)
  - [Trying out single projects](#trying-out-single-projects)
  - [Installing applications in your system](#installing-applications-in-your-system)
  - [Creating Python environments with many applications and libraries](#creating-python-environments-with-many-applications-and-libraries)
    - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs)
- [Using with Nix unstable (Nix Flakes)](#using-with-nix-unstable-nix-flakes)
  - [Trying out single projects](#trying-out-single-projects-1)
  - [Installing applications in your system](#installing-applications-in-your-system-1)
  - [Creating Python environments with many applications and libraries](#creating-python-environments-with-many-applications-and-libraries-1)
    - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs-1)
- [Contributing](#contributing)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# List of available projects

Checkout [python.on-nix.com](https://python.on-nix.com)

# Concepts

## Applications and Libraries

On Python, projects can be used in two ways:

- As applications: Commands that you can run from the command line:

  - [AWS CLI](https://pypi.org/project/awscli/): `$ aws`
  - [Bandit](https://pypi.org/project/bandit/): `$ bandit`
  - [PyTest](https://pypi.org/project/pytest/): `$ pytest`
  - ...

- As libraries: Python modules that you can import in your project:

  - [Boto3](https://pypi.org/project/boto3/): `>>> import boto3`
  - [Django](https://pypi.org/project/django/): `>>> from django import *`
  - [PyTest](https://pypi.org/project/pytest/): `>>> import pytest`
  - ...

Some projects (like PyTest) can be used in both ways
while others can only be used as an application or as a library,
but not both

# Using with Nix stable

## Trying out single projects

You can launch an ephemeral environment where
the applications and libraries provided by a project are available.

For example:

```bash
$ nix-shell \
  -A 'projects."awscli"."1.20.31".python39.dev' \
  https://github.com/on-nix/python/tarball/main
```

In general the format is: `'projects."<project>"."<version>".<pythonVersion>.dev'`

Now enjoy!

```bash
[nix-shell] $ aws --version
              aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
[nix-shell] $ python -c 'import awscli; print(awscli)'
              # ...
[nix-shell] $ exit
```

## Installing applications in your system

You can permanently install the applications of a project in your system.

For example:

```bash
$ nix-env \
  -iA 'apps."awscli"."1.20.31"' \
  -f https://github.com/on-nix/python/tarball/main

$ nix-env \
  -iA 'apps."pytest"."latest"' \
  -f https://github.com/on-nix/python/tarball/main
```

In general the format is: `'apps."<project>"."<version>"'`

Now enjoy!

```bash
$ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31

$ pytest --version
  pytest 6.2.5
```

## Creating Python environments with many applications and libraries

For more complex use cases where you are using many projects it's
a good idea to describe a Python environment with Nix.

For example:

```nix
# /path/to/my/env.nix

let
  # Import Python on Nix
  pythonOnNix = import
    (builtins.fetchGit {
      # Use `main` branch or a commit from this list:
      # https://github.com/on-nix/python/commits/main
      # We recommend using a commit for maximum reproducibility
      ref = "main";
      url = "https://github.com/on-nix/python";
    })
    {
      # (optional) You can override `nixpkgs` here
      # nixpkgs = import <nixpkgs> { };
    };

  # Pick the Python version of your choice:
  # - `python37Env`: Python 3.7
  # - `python38Env`: Python 3.8
  # - `python39Env`: Python 3.9
  # - `python310Env`: Python 3.10
  env = pythonOnNix.python39Env {
    name = "example";
    projects = {
      awscli = "1.20.31";
      numpy = "latest";
      requests = "latest";
      torch = "1.9.0";
    };
  };

  # `env` has two attributes:
  # - `dev`: The activation script for the Python on Nix environment
  # - `out`: The raw contents fo the Python site-packages
in
# Let's use the activation script:
env.dev
```

You can now launch the environment!

```bash
$ nix-shell /path/to/my/env.nix
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

### Compatibility with Nixpkgs

You can use `Python On Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/expression.nix

let
  # Import Nixpkgs
  nixpkgs = import <nixpkgs> { };

  # Import Python on Nix
  pythonOnNix = import
    (builtins.fetchGit {
      # Use `main` branch or a commit from this list:
      # https://github.com/on-nix/python/commits/main
      # We recommend using a commit for maximum reproducibility
      ref = "main";
      url = "https://github.com/on-nix/python";
    })
    {
      # Make Python on Nix use the same version of `nixpkgs`
      # for maximum compatibility
      inherit nixpkgs;
    };

  # Pick the Python version of your choice:
  # - `python37Env`: Python 3.7
  # - `python38Env`: Python 3.8
  # - `python39Env`: Python 3.9
  # - `python310Env`: Python 3.10
  env = pythonOnNix.python39Env {
    name = "example";
    projects = {
      awscli = "1.20.31";
      numpy = "latest";
      requests = "latest";
      torch = "1.9.0";
    };
  };

  # `env` has two attributes:
  # - `dev`: The activation script for the Python on Nix environment
  # - `out`: The raw contents of the Python virtual environment
in
nixpkgs.stdenv.mkDerivation {
  # Let's use the activation script as build input:
  buildInputs = [ env.dev ];
  virtualEnvironment = env.out;

  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup

    set -x

    ls $virtualEnvironment
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
```

Now just `$ nix-build /path/to/my/expression.nix` ! :rocket:

```bash
these derivations will be built:
  /nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv

building '/nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv'...

+ ls /nix/store/...-example-out
  awscli              colorama  numpy            requests    torch
  botocore            docutils  pyasn1           rsa         typing-extensions
  certifi             idna      python-dateutil  s3transfer  urllib3
  charset-normalizer  jmespath  pyyaml           six
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

### Customization of and integration into existing development environments

Given an existing definition of a development environment using e.g. `mkShell` instead of `mkDerivation`:

```nix
let
  nixpkgs = builtins.fetchTarball {
    # nixpkgs-unstable (2021-10-28)
    url = "https://github.com/NixOS/nixpkgs/archive/22a500a3f87bbce73bd8d777ef920b43a636f018.tar.gz";
    sha256 = "1rqp9nf45m03mfh4x972whw2gsaz5x44l3dy6p639ib565g24rmh";
  };
in
{ pkgs ? import nixpkgs { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    gdb
    ninja
    qemu
  ] ++ (with llvmPackages_13; [
    clang
    clang-unwrapped
    lld
    llvm
  ]);

  hardeningDisable = [ "all" ];
}
```

you can integrate the `Python On Nix` development environment seamlessly via e.g.

```nix
let
  nixpkgs = builtins.fetchTarball {
    # nixpkgs-unstable (2021-10-28)
    url = "https://github.com/NixOS/nixpkgs/archive/22a500a3f87bbce73bd8d777ef920b43a636f018.tar.gz";
    sha256 = "1rqp9nf45m03mfh4x972whw2gsaz5x44l3dy6p639ib565g24rmh";
  };
in
{ pkgs ? import nixpkgs { } }:
let
  pythonOnNix = import (
    builtins.fetchGit {
      ref = "main";
      rev = "2e735762c73651cffc027ca850b2a58d87d54b49";
      url = "https://github.com/on-nix/python";
    }
  ) { nixpkgs = pkgs; };
  env = pythonOnNix.python39Env {
    name = "example";
    projects = {
      "awscli" = "latest";
      # You can add more projects here as you need
      # "a" = "1.0";
      # "b" = "2.0";
      # ...
    };
  };
in
pkgs.mkShell {
  nativeBuildInputs =
    [ env.dev ]
    ++ (with pkgs; [ cmake gdb ninja qemu ])
    ++ (with pkgs; with llvmPackages_13; [ clang clang-unwrapped lld llvm ]);
  hardeningDisable = [ "all" ];
}
```

# Using with Nix unstable (Nix Flakes)

This project is also offered as a Nix Flake.

:warning: This section is for advanced Nix users.
You can skip its content
as Nix Flakes is currently
an **unstable** release of Nix.

```bash
$ nix flake show github:on-nix/python
```

## Trying out single projects

- `$ nix develop 'github:on-nix/python#"awscli-1.20.31-python39"'`
- `$ nix develop 'github:on-nix/python#"pytest-latest-python37"'`

## Installing applications in your system

- `$ nix profile install 'github:on-nix/python#"awscli-1.20.31-python39-bin"'`
- `$ nix profile install 'github:on-nix/python#"pytest-latest-python37-bin"'`

## Creating Python environments with many applications and libraries

```nix
# /path/to/my/project/flake.nix

{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github:on-nix/python";
    pythonOnNix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, ... } @ inputs:
    inputs.flakeUtils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
        pythonOnNix = inputs.pythonOnNix.lib.${system};

        # Pick the Python version of your choice:
        # - `python37Env`: Python 3.7
        # - `python38Env`: Python 3.8
        # - `python39Env`: Python 3.9
        # - `python310Env`: Python 3.10
        env = pythonOnNix.python39Env {
          name = "example";
          projects = {
            awscli = "1.20.31";
            numpy = "latest";
            requests = "latest";
            torch = "1.9.0";
          };
        };
        # `env` has two attributes:
        # - `dev`: The activation script for the Python on Nix environment
        # - `out`: The raw contents fo the Python site-packages
      in
      {
        devShells = {

          # The activation script can be used as dev-shell
          example = env.dev;

        };
      }
    );
}
```

You can now launch the environment!

```bash
$ nix develop '.#example'
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

### Compatibility with Nixpkgs

You can use `Python on Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/project/flake.nix

{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github:on-nix/python";
    pythonOnNix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, ... } @ inputs:
    inputs.flakeUtils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
        pythonOnNix = inputs.pythonOnNix.lib.${system};

        # Pick the Python version of your choice:
        # - `python37Env`: Python 3.7
        # - `python38Env`: Python 3.8
        # - `python39Env`: Python 3.9
        # - `python310Env`: Python 3.10
        env = pythonOnNix.python39Env {
          name = "example";
          projects = {
            awscli = "1.20.31";
            numpy = "latest";
            requests = "latest";
            torch = "1.9.0";
          };
        };
        # `env` has two attributes:
        # - `dev`: The activation script for the Python on Nix environment
        # - `out`: The raw contents fo the Python site-packages
      in
      {
        packages = rec {

          something = nixpkgs.stdenv.mkDerivation {
            buildInputs = [ env.dev ];
            virtualEnvironment = env.out;

            builder = builtins.toFile "builder.sh" ''
              source $stdenv/setup

              set -x

              ls $virtualEnvironment
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
```

Now just `$ nix -L build .#something` ! :rocket:

```bash
+ ls /nix/store/...-example-out
  awscli              colorama  numpy            requests    torch
  botocore            docutils  pyasn1           rsa         typing-extensions
  certifi             idna      python-dateutil  s3transfer  urllib3
  charset-normalizer  jmespath  pyyaml           six
+ python --version
  Python 3.9.6
+ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
+ python -c 'import numpy; print(numpy.__version__)'
  1.21.2
+ python -c 'import requests; print(requests.__version__)'
  2.26.0
+ python -c 'import torch; print(torch.__version__)'
  1.9.0+cu102

+ touch /nix/store/dcccmxjllgwb9c9j6irp68f1qp4ssxyg-example
```

# Contributing

Anything you can think of will be appreciated!

# License

Code on this branch is dedicated to the public domain
via [The Unlicense](https://unlicense.org/) license.

In other words you can do anything you want with it.

Please enjoy! :rocket:

---

[nix]: https://nixos.org/
[projects]: #list-of-available-projects
[pypi]: https://pypi.org/
[python]: https://www.python.org/
[python_releases]: https://www.python.org/downloads/
[python_wheels]: https://pythonwheels.com/
