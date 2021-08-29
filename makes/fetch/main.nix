{ __nixpkgs__
, makePythonPypiEnvironment
, makeScript
, ...
}:
makeScript {
  entrypoint = ./entrypoint.sh;
  name = "pypi-fetch";
  searchPaths.bin = [
    __nixpkgs__.curl
    __nixpkgs__.jq
  ];
}
