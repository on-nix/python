# shellcheck shell=bash

function main {
  local cwd="${PWD}"
  local project="${1}"
  local project_endpoint="https://pypi.org/pypi/${project}/json"

  cd "$(mktemp -d)" \
    && info Fetching "${project}" @ "${project_endpoint}" \
    && curl -sL "${project_endpoint}" | jq -er > data.json \
    && project="$(jq -er .info.name < data.json)" \
    && version_latest="$(jq -er .info.version < data.json)" \
    && jq -er .releases < data.json > releases.json \
    && jq -er 'to_entries[] | .key' < releases.json > versions.lst \
    && mapfile -t versions < versions.lst \
    && for version in "${versions[@]}"; do
      info "${project}-${version}" \
        && jq -r ".\"${version}\"[].filename" > names.lst < releases.json \
        && jq -r ".\"${version}\"[].digests.sha256" > sha256s.lst < releases.json && jq -r ".\"${version}\"[].url" > urls.lst < releases.json \
        && mapfile -t names < names.lst \
        && mapfile -t sha256s < sha256s.lst \
        && mapfile -t urls < urls.lst \
        && echo [] > sources.json \
        && for ((index = 0; index < "${#urls[@]}"; index++)); do
          : \
            && name="${names[$index]}" \
            && sha256="${sha256s[$index]}" \
            && url="${urls[$index]}" \
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
        && mkdir -p "${cwd}/pkgs/${project}/files" \
        && cp sources.json "${cwd}/pkgs/${project}/files/${version}.json" \
        && if test "${version}" = "${version_latest}"; then
          cp sources.json "${cwd}/pkgs/${project}/files/__latest__.json"
        fi \
        || return 1
    done
}

main "${@}"
