# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

instantiate:
  nix-instantiate \
    --attr projects \
    --show-trace \

build ATTR:
  nix-build \
    --attr '{{ATTR}}' \
    --option cores 1 \
    --option max-jobs auto \
    --option sandbox true \
    --quiet \
    --show-trace \
    default.nix

build-all:
  ls -1 projects | while read -r project; do just build projects.$project; done

crawl:
  bash makes/crawl/entrypoint.sh

examples:
  nix-build examples/stable/shell.nix
  nix-build examples/stable/nixpkgs.nix
  rm -rf ./examples/unstable/flake.lock
  nix-shell -p nixUnstable --run 'nix --experimental-features "flakes nix-command" -L build ./examples/unstable#something'
  rm -rf ./examples/unstable/flake.lock

new PROJECT:
  set +e; \
  m . /create 3.7 {{PROJECT}}; just optimize; \
  m . /create 3.8 {{PROJECT}}; just optimize; \
  m . /create 3.9 {{PROJECT}}; just optimize; \

new-version PROJECT VERSION:
  set +e; \
  m . /create 3.7 {{PROJECT}} {{VERSION}}; just optimize; \
  m . /create 3.8 {{PROJECT}} {{VERSION}}; just optimize; \
  m . /create 3.9 {{PROJECT}} {{VERSION}}; just optimize; \
  m . /create 3.10 {{PROJECT}} {{VERSION}}; just optimize; \

meta:
  bash makes/meta/entrypoint.sh

optimize:
  python3 makes/optimize/entrypoint.py

release PROJECT:
  bash makes/release/entrypoint.sh {{PROJECT}}

release-dependencies PROJECT:
  bash makes/release/dependencies/entrypoint.sh {{PROJECT}}

release-referrers PROJECT:
  grep -lPr {{PROJECT}} projects \
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
