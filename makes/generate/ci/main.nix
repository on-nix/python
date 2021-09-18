{ inputs
, makeScript
, projectPath
, ...
}:
let
  env = inputs.pythonOnNix.python39Env {
    name = "makes-generate-ci";
    projects = {
      "more-itertools" = "latest";
      "pyyaml" = "latest";
    };
  };
in
makeScript {
  name = "makes-generate-ci";
  replace = {
    __argGenerate__ = projectPath "/makes/generate/ci/generate.py";
  };
  entrypoint = "python __argGenerate__";
  searchPaths.source = [ env ];
}
