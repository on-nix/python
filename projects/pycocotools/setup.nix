{
  buildGccBin = true;
  searchPathsBuild = { nixpkgs, pythonOnNix, pythonVersion }: {
    source = [
      pythonOnNix.projects.cython.latest.${pythonVersion}.dev
      pythonOnNix.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
