{
  runtimeLibstdcppRpath = true;
  searchPathsRuntime = { nixpkgs, pythonOnNix, pythonVersion, ... }: {
    source = [
      pythonOnNix.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
