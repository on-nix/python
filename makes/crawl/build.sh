#! /usr/bin/env bash

git ls-files --others --exclude-standard \
  | grep -oP 'projects/.*?/' \
  | sort \
  | uniq \
  | xargs -n 1 basename \
  | while read -r project; do
    just optimize
    if just build "projects.${project}"; then
      git add "projects/${project}"
      git commit -m "feat(conf): ${project}"
      git push
    fi
  done
