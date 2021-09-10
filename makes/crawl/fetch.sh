#! /usr/bin/env bash

function to_pep503 {
  local project="${1}"

  echo "${project}" | sed -E "s|[-_.]+|-|g" | tr '[:upper:]' '[:lower:]'
}

mapfile -t projects < makes/crawl/projects.lst

for project in "${projects[@]}"; do
  project="$(to_pep503 "${project}")"

  if test -e "projects/${project}"; then continue; fi

  just new "${project}"
done
