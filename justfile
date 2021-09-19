# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

instantiate:
  nix-instantiate \
    --attr projects \
    --show-trace \

build ATTR:
  # cachix use python-on-nix
  nix-build \
    --attr '{{ATTR}}' \
    --option cores 1 \
    --option max-jobs 1 \
    --option sandbox true \
    --show-trace \
    default.nix
  # if test -n "${CACHIX_PYTHON_ON_NIX_TOKEN:-}"; then \
  #   CACHIX_AUTH_TOKEN="${CACHIX_PYTHON_ON_NIX_TOKEN}" \
  #   cachix push -c 9 python-on-nix ./result*; \
  # fi

build-all:
  ls -1 projects | while read -r project; do just build projects.$project; done

crawl-fetch:
  bash makes/crawl/fetch.sh

crawl-build:
  bash makes/crawl/build.sh

examples:
  nix-build --option sandbox true examples/use-with-nixpkgs.nix
  rm -rf ./examples/use-with-flakes-and-nixpkgs/flake.lock
  nix-shell -p nixUnstable --run 'nix --experimental-features "flakes nix-command" build ./examples/use-with-flakes-and-nixpkgs#something'
  rm -rf ./examples/use-with-flakes-and-nixpkgs/flake.lock

new PROJECT:
  set +e; \
  m . /create 3.6 {{PROJECT}}; \
  m . /create 3.7 {{PROJECT}}; \
  m . /create 3.8 {{PROJECT}}; \
  m . /create 3.9 {{PROJECT}};
  just optimize

optimize:
  python3 makes/optimize/entrypoint.py

release PROJECT:
  bash makes/release/entrypoint.sh {{PROJECT}}

release-dependencies PROJECT:
  bash makes/release/dependencies/entrypoint.sh {{PROJECT}}

release-referrers PROJECT:
  grep -lPr chameleon projects \
    | grep -oP 'projects/.*?/' \
    | sort \
    | uniq \
    | xargs -n 1 basename \
    | xargs -n 1 just release

release-all:
  git ls-files --others --exclude-standard \
    | grep -oP 'projects/.*?/' \
    | sort \
    | uniq \
    | xargs -n 1 basename \
    | xargs -n 1 just release
