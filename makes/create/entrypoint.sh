# shellcheck shell=bash

function main {
  local python_version="${1}"
  local project="${2}"
  local version="${3:-}"

  local out
  local project_endpoint
  local projects
  local pyproject_toml='{
    "build-system": {
      "build-backend": "poetry.core.masonry.api",
      "requires": [ "poetry-core>=1.0.0" ]
    },
    "tool": {
      "poetry": {
        "authors": [ ],
        "dependencies": { python: $python_version },
        "description": "",
        "name": "nixpkgs-python-\($project)-\($version)",
        "version": "1"
      }
    }
  }'
  local python
  local tmp
  local versions

  : \
    && case "${python_version}" in
      3.6) python=__argPy36__/bin/python ;;
      3.7) python=__argPy37__/bin/python ;;
      3.8) python=__argPy38__/bin/python ;;
      3.9) python=__argPy39__/bin/python ;;
      *) critical Python version not supported: "${python_version}" ;;
    esac \
    && info Using CPython "${python_version}" "${python}" \
    && info Project: "${project}" \
    && tmp="$(mktemp -d)" \
    && pushd "${tmp}" \
    && if test -z "${version}"; then
      project_endpoint="https://pypi.org/pypi/${project}/json" \
        && curl -sL "${project_endpoint}" | jq -er > data.json \
        && version="$(jq -er .info.version < data.json)"
    fi \
    && info Version: "${version}" \
    && project_endpoint="https://pypi.org/pypi/${project}/${version}/json" \
    && curl -sL "${project_endpoint}" | jq -er > data.json \
    && jq -enrS \
      --arg project "${project}" \
      --arg python_version "${python_version}.*" \
      --arg version "${version}" \
      "${pyproject_toml}" \
    | yj -jt | tee pyproject.toml \
    && poetry env use "${python}" \
    && poetry add --lock -vv "${project}==${version}" \
    && yj -tj < poetry.lock > poetry.lock.json \
    && jq -erS '[.package[] | {key: .name, value: .version}] | from_entries' \
      < poetry.lock.json > closure.json \
    && popd \
    && out="${PWD}/pkgs/${project}/${version}" \
    && mkdir -p "${out}" \
    && copy "${tmp}/closure.json" "${out}/python${python_version}.json" \
    && pushd "${tmp}" \
    && jq -er 'to_entries[].key' \
      < "${out}/python${python_version}.json" > projects.lst \
    && jq -er 'to_entries[].value' \
      < "${out}/python${python_version}.json" > versions.lst \
    && mapfile -t projects < projects.lst \
    && mapfile -t versions < versions.lst \
    && popd \
    && for ((index = 0; index < "${#projects[@]}"; index++)); do
      : \
        && project="${projects[$index]}" \
        && version="${versions[$index]}" \
        && if ! test -e "pkgs/${project}/${version}/installers.json"; then
          fetch "${project}" "${version}"
        fi \
        && if ! test -e "pkgs/${project}/${version}/python${python_version}.json"; then
          main "${python_version}" "${project}" "${version}"
        fi
    done
}

main "${@}"
