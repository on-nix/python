# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

build ATTR:
  nix-build \
    --attr {{ATTR}} \
    --option cores 1 \
    --option keep-going true \
    --option max-jobs auto \
    --option sandbox true \
    --show-trace \
    default.nix
  if test -n "${CACHIX_NIXPKGS_PYTHON_TOKEN:-}"; then \
    CACHIX_AUTH_TOKEN="${CACHIX_NIXPKGS_PYTHON_TOKEN}" \
    cachix push -c 9 nixpkgs-python; \
  fi

test:
  just build __tests__

test36:
  just build python36

test37:
  just build python37

test38:
  just build python38

test39:
  just build python39
