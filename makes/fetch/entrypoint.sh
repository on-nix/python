# shellcheck shell=bash

function main {
  local project="${1}"
  local version="${2}"

  local cwd="${PWD}"
  local out="pkgs/${project}/${version}"
  local project_endpoint="https://pypi.org/pypi/${project}/${version}/json"

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
    && jq -r .url > urls.lst < urls.json \
    && mapfile -t names < names.lst \
    && mapfile -t sha256s < sha256s.lst \
    && mapfile -t urls < urls.lst \
    && echo [] > sources.json \
    && for ((index = 0; index < "${#urls[@]}"; index++)); do
      : \
        && name="${names[$index]}" \
        && sha256="${sha256s[$index]}" \
        && url="${urls[$index]}" \
        && info Found: "${name}" \
        && case "${name}" in
          *.egg) continue ;;
          *.exe) continue ;;
          *-win32.whl) continue ;;
          *-win_amd64.whl) continue ;;
          *) ;;
        esac \
        && jq -ersS \
          --arg name "${name}" \
          --arg sha256 "${sha256}" \
          --arg url "${url}" \
          '.[0] | . += [{
            name: $name,
            sha256: $sha256,
            url: $url
          }]' \
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
