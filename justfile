# https://github.com/casey/just
set shell := ["bash", "-euo", "pipefail", "-c"]

_:
  @just --list

build ATTR:
  nix-instantiate --show-trace -A projects default.nix
  cachix use python-on-nix
  nix-build \
    --attr '{{ATTR}}' \
    --option cores 1 \
    --option max-jobs auto \
    --option sandbox true \
    default.nix
  if test -n "${CACHIX_PYTHON_ON_NIX_TOKEN:-}"; then \
    CACHIX_AUTH_TOKEN="${CACHIX_PYTHON_ON_NIX_TOKEN}" \
    cachix push -c 9 python-on-nix ./result*; \
  fi

ci:
  : \
  && just build projects.more-itertools.latest.latest.dev \
  && source ./result/setup \
  && just build projects.pyyaml.latest.latest.dev \
  && source ./result/setup \
  && python3 .github/workflows/generate.py

crawl-fetch:
  bash makes/crawl/fetch.sh

crawl-build:
  bash makes/crawl/build.sh

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
  just build projects.{{PROJECT}} \
    && git add projects/{{PROJECT}} \
    && git commit -m 'feat(conf): {{PROJECT}}' \
    && git push

release-all:
  git ls-files --others --exclude-standard \
    | grep -oP 'projects/.*?/' \
    | sort \
    | uniq \
    | xargs -n 1 basename \
    | xargs -n 1 just release
