# shellcheck shell=bash

function main {
  local project="${1}"
  local version="${2}"

  local cwd="${PWD}"
  local out="projects/${project}/${version}"
  local name
  local project_endpoint="https://pypi.org/pypi/${project}/${version}/json"
  local sha256
  local tmp
  local url

  : \
    && info Project: "${project}" \
    && info Version: "${version}" \
    && tmp="$(mktemp -d)" \
    && pushd "${tmp}" \
    && curl -sL "${project_endpoint}" | jq -er > data.json \
    && project="$(jq -er .info.name < data.json)" \
    && jq -er .urls[] < data.json > urls.json \
    && jq -r .filename > names.lst < urls.json \
    && jq -r .digests.sha256 > sha256s.lst < urls.json \
    && mapfile -t names < names.lst \
    && mapfile -t sha256s < sha256s.lst \
    && echo {} > sources.json \
    && for ((index = 0; index < "${#names[@]}"; index++)); do
      : \
        && name="${names[$index]}" \
        && sha256="${sha256s[$index]}" \
        && info Found: "${name}" \
        && jq -ersS \
          --arg name "${name}" \
          --arg sha256 "${sha256}" \
          '.[0] * { "\($name)": $sha256 }' \
          sources.json \
          > sources2.json \
        && mv sources2.json sources.json \
        || return 1
    done \
    && popd \
    && mkdir -p "${out}" \
    && copy "${tmp}/sources.json" "${out}/installers.json"
}

main "${@}"
