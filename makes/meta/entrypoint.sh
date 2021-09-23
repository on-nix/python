# shellcheck shell=bash

function fetch {
  local project="${1}"

  : && curl -L "https://pypi.org/pypi/${project}/json" \
    || curl -L "https://pypi.org/pypi/${project}/json" \
    || curl -L "https://pypi.org/pypi/${project}/json"
}

function main {
  local project="${1}"

  fetch "${project}" | jq -erS '{
    desc: .info.summary,
    home: .info.home_page,
    license: .info.license
  }' > "projects/${project}/meta.json"
}

main "${@}"
