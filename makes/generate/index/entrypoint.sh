# shellcheck shell=bash

ls -1 projects | while read -r project; do
  ls -1 "projects/${project}" | while read -r version; do
    if test -d "${version}"; then
      echo "${project}-${version}"
    fi
  done
done
