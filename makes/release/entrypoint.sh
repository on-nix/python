# shellcheck shell=bash

function main {
  local project="${1}"
  local pwd="${PWD}"

  : \
    && if ! test -e "projects/${project}/test.py"; then
      echo -n > "projects/${project}/test.py" \
        && just build "projects.${project}.latest.pythonLatest" \
        && base="$(echo "result-3/lib/python"*"/site-packages")" \
        && pushd "${base}" \
        && find . -maxdepth 2 -name __init__.py \
        | while read -r path; do
          path="$(dirname "${path}")" \
            && path="${path//\//.}" \
            && echo "import "${path:2}"" >> "${pwd}/projects/${project}/test.py"
        done \
        && popd
    fi \
    && just build "projects.${project}" \
    && git add "projects/${project}" \
    && git commit -m "feat(conf): ${project}"
}

main "${@}"
