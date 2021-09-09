#! /usr/bin/env bash

function to_pep503 {
  local project="${1}"

  echo "${project}" | sed -E "s|[-_.]+|-|g" | tr '[:upper:]' '[:lower:]'
}

mapfile -t projects < projects.lst

for project in "${projects[@]}"; do
  project="$(to_pep503 "${project}")"

  if test -e "projects/${project}"; then continue; fi

  just add "${project}"

  if just build __all__; then
    git add projects
    git commit -m "feat(conf): ${project}"
    git push
  else
    git status -- projects >> errors.lst
    git add errors.lst
    git commit -m "refac(conf): ${project}"
    git push
    rm -rf projects
    git checkout -- projects
  fi
done
