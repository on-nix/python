# shellcheck shell=bash

echo "| Project | Version | Python Versions |"
echo "| ------- | :-----: | :-------------: |"

ls -1 projects | while read -r project; do
  ls -1 "projects/${project}" | while read -r version; do
    if test -d "projects/${project}/${version}"; then
      python_versions=()
      if test -e "projects/${project}/${version}/python36.json"; then
        python_versions+=(3.6)
      fi
      if test -e "projects/${project}/${version}/python37.json"; then
        python_versions+=(3.7)
      fi
      if test -e "projects/${project}/${version}/python38.json"; then
        python_versions+=(3.8)
      fi
      if test -e "projects/${project}/${version}/python39.json"; then
        python_versions+=(3.9)
      fi
      echo "| ${project} | ${version} | ${python_versions[*]} |"
    fi
  done
done
