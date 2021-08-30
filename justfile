# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

test:
  nix-build --option sandbox true -A __all__
