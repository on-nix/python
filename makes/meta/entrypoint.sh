# shellcheck shell=bash

function fetch {
  local project="${1}"

  : && curl -L "https://pypi.org/pypi/${project}/json" \
    || curl -L "https://pypi.org/pypi/${project}/json" \
    || curl -L "https://pypi.org/pypi/${project}/json"
}

function generate {
  local project="${1}"

  fetch "${project}" | jq -erS '{
    desc: .info.summary,
    home: .info.home_page,
    license: .info.license
  }' > "projects/${project}/meta.json"
}

function main {
  for project in projects/*; do
    echo Generating meta for: "${project}" \
      && project="$(basename "${project}")" \
      && if ! test -e "projects/${project}/meta.json"; then
        generate "${project}"
      fi
  done
}

main "${@}"
