{
  __nixpkgs__,
  makePythonPypiEnvironment,
  makeScript,
  outputs,
  ...
}:
makeScript {
  entrypoint = ./entrypoint.sh;
  name = "fetch";
  replace = {
    __argPy37__ = __nixpkgs__.python37;
    __argPy38__ = __nixpkgs__.python38;
    __argPy39__ = __nixpkgs__.python39;
    __argPy310__ = __nixpkgs__.python310;
  };
  searchPaths.bin = [
    __nixpkgs__.curl
    __nixpkgs__.gnused
    __nixpkgs__.jq
    __nixpkgs__.poetry
    __nixpkgs__.yj
    outputs."/fetch"
  ];
}
