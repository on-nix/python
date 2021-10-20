# Python on Nix

Extensive collection
of [Python][PYTHON] projects
from the [Python Packaging Index][PYPI].
That can be used with the [Nix][NIX] package manager.

Check out the examples at [python.on-nix.com](https://python.on-nix.com/)!

- Scope:
  - :heavy_check_mark:
    All [active Python releases][PYTHON_RELEASES]
    (`3.6`, `3.7`, `3.8`, `3.9`, `3.10`)
  - :heavy_check_mark: 1700+ [projects][PROJECTS] already packaged,
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

To make using [Nix][NIX] on [Python][PYTHON] projects
as simple as possible!

Just:
1. Copy and paste the examples,
2. Select the [Python][PYTHON] projects of your choice,
3. Enjoy! :rocket:

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Contents

- [List of available projects](#list-of-available-projects)
- [Applications vs Libraries](#applications-vs-libraries)
- [Using with Nix stable](#using-with-nix-stable)
    - [Installing Applications](#installing-applications)
    - [Creating Python environments with Applications and Libraries](#creating-python-environments-with-applications-and-libraries)
        - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs)
- [Using with Nix unstable (Nix Flakes)](#using-with-nix-unstable-nix-flakes)
    - [List of available projects](#list-of-available-projects-1)
    - [Trying out Applications without installing them](#trying-out-applications-without-installing-them)
    - [Installing Applications](#installing-applications-1)
    - [Creating Python environments with Applications and Libraries](#creating-python-environments-with-applications-and-libraries-1)
    - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs-1)
- [Contributing](#contributing)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# List of available projects

Checkout [python.on-nix.com](https://python.on-nix.com)

# Applications vs Libraries

On Python, projects can offer two types of components:

- **Applications**: Binaries that you can run from the command line:

  - [AWS CLI](https://pypi.org/project/awscli/): `$ aws`
  - [Bandit](https://pypi.org/project/bandit/): `$ bandit`
  - ...

- **Libraries**: Packages and modules that you can import in your Python projects:

  - [Boto3](https://pypi.org/project/boto3/): `>>> import boto3`
  - [Django](https://pypi.org/project/django/): `>>> from django import *`
  - ...

- **Both**: They work either as an Application and/or as a Library:

  - [PyTest](https://pypi.org/project/pytest/): `$ pytest`, or `>>> import pytest`
  - ...

# Using with Nix stable

## Installing Applications

Simply run the following magic from a terminal.

```bash
$ nix-env -iA 'apps."<project>"."<version>"' -f https://github.com/on-nix/python/tarball/main
```

For example:

- ```bash
  $ nix-env -iA 'apps."awscli"."1.20.31"' -f https://github.com/on-nix/python/tarball/main
  ```
- ```bash
  $ nix-env -iA 'apps."pytest"."latest"' -f https://github.com/on-nix/python/tarball/main
  ```

After the process have completed,
you will be able to use the project's binaries:

```bash

$ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
$ pytest --version
  pytest 6.2.5
```

## Creating Python environments with Applications and Libraries

First,
you need to import `Python on Nix`
into your project.

For example:

```nix
# /path/to/my/env.nix

let
  pythonOnNix = import
    (builtins.fetchGit {
      # Use `main` branch or a commit from this list:
      # https://github.com/on-nix/python/commits/main
      ref = "main";
      url = "https://github.com/on-nix/python";
    })
    {
      # You can override `nixpkgs` here,
      # or set to `null` to use one bundled with Python on Nix
      # nixpkgs = import <nixpkgs> { };
    };
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
- `python310Env`: Python 3.10

For example:

```nix
# /path/to/my/env.nix (continuation)

pythonOnNix.python39Env {
  name = "example";
  projects = {
    awscli = "1.20.31";
    numpy = "latest";
    requests = "latest";
    torch = "1.9.0";
  };
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

### Compatibility with Nixpkgs

You can use `Python On Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/expression.nix

let
  # import projects
  nixpkgs = import <nixpkgs> { };
  pythonOnNix = import
    (builtins.fetchGit {
      # Use `main` branch or a commit from this list:
      # https://github.com/on-nix/python/commits/main
      ref = "main";
      url = "https://github.com/on-nix/python";
    })
    {
      inherit nixpkgs;
    };

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
# Using with Nix unstable (Nix Flakes)

This project is also offered as a Nix Flake.

:warning: This section is for advanced Nix users.
You can skip its content
as Nix Flakes are currently
an **unstable** release of Nix.

## List of available projects

```bash
$ nix flake show github:on-nix/python
```

## Trying out Applications without installing them

- `$ nix shell 'github:on-nix/python#"awscli-1.20.31-python39-bin"'`
- `$ nix shell 'github:on-nix/python#"pytest-latest-python37-bin"'`

## Installing Applications

- `$ nix profile install 'github:on-nix/python#"awscli-1.20.31-python39-bin"'`
- `$ nix profile install 'github:on-nix/python#"pytest-latest-python37-bin"'`

## Creating Python environments with Applications and Libraries

```nix
# /path/to/my/project/flake.nix

{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github:on-nix/python";
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

        };
      }
    );
}
```

The output of this function
contains a setup script
that you can `source`:

```bash
# Build your environment
$ nix build '.#example'

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

You can use `Python on Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/project/flake.nix

{
  inputs = {
    flakeUtils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github/on-nix/python";
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
```

Now just `$ nix -L build .#something` ! :rocket:

```bash
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

[NIX]: https://nixos.org/
[PROJECTS]: #list-of-available-projects
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
[PYTHON_WHEELS]: https://pythonwheels.com/
