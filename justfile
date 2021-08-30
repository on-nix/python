# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

test:
  nix-build \
    --attr __all__ \
    --option cores 0 \
    --option sandbox true \
    --option max-jobs auto \
    default.nix
