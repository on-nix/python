# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

test:
  nix-build \
    --attr __tests__ \
    --option cores 1 \
    --option max-jobs auto \
    --option sandbox true \
    --show-trace \
    default.nix
  if test -n "${CACHIX_NIXPKGS_PYTHON_TOKEN:-}"; then \
    CACHIX_AUTH_TOKEN="${CACHIX_NIXPKGS_PYTHON_TOKEN}" \
    cachix push -c 9 nixpkgs-python; \
  fi
