{
  runtimeLibstdcppRpath = true;
  searchPathsRuntime = { nixpkgs, nixpkgsPython, pythonVersion, ... }: {
    source = [
      nixpkgsPython.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
