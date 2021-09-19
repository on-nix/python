# shellcheck shell=bash

function main {
  local project="${1}"
  local tmp

  tmp="$(mktemp)" \
    && for closure in "projects/${project}/"*'/python3'*'.json'; do
      jq -r to_entries[].key < "${closure}" > "${tmp}" \
        && mapfile -t dependencies < "${tmp}" \
        && for dependency in "${dependencies[@]}"; do
          just release "${dependency}"
        done
    done
}

main "${@}"
