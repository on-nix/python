# shellcheck shell=bash

echo "| Project | Version |"
echo "| ------- | :-----: |"

ls -1 projects | while read -r project; do
  ls -1 "projects/${project}" | while read -r version; do
    if test -d "projects/${project}/${version}"; then
      echo "| ${project} | ${version} |"
    fi
  done
done
