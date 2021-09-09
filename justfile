# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

build ATTR:
  cachix use nixpkgs-python
  nix-build \
    --attr '{{ATTR}}' \
    --option cores 1 \
    --option keep-going true \
    --option max-jobs auto \
    --option sandbox true \
    --show-trace \
    default.nix
  if test -n "${CACHIX_NIXPKGS_PYTHON_TOKEN:-}"; then \
    CACHIX_AUTH_TOKEN="${CACHIX_NIXPKGS_PYTHON_TOKEN}" \
    cachix push -c 9 nixpkgs-python result; \
  fi

ci:
  just build projects.pyyaml.latest.python39.dev
  source ./result/setup \
    && python3 .github/workflows/generate.py

new PROJECT:
  set +e; \
  m . /create 3.6 {{PROJECT}}; \
  m . /create 3.7 {{PROJECT}}; \
  m . /create 3.8 {{PROJECT}}; \
  m . /create 3.9 {{PROJECT}}; \

optimize:
  python3 makes/optimize/entrypoint.py
