{ __nixpkgs__
, makePythonPypiEnvironment
, makeScript
, ...
}:
makeScript {
  entrypoint = ./entrypoint.sh;
  name = "pypi-fetch";
  replace = {
    __argPy36__ = __nixpkgs__.python36;
    __argPy37__ = __nixpkgs__.python37;
    __argPy38__ = __nixpkgs__.python38;
    __argPy39__ = __nixpkgs__.python39;
  };
  searchPaths.bin = [
    __nixpkgs__.curl
    __nixpkgs__.jq
    __nixpkgs__.poetry
    __nixpkgs__.yj
  ];
}
