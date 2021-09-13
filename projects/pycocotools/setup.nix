{
  buildGccBin = true;
  searchPathsBuild = { nixpkgs, nixpkgsPython, pythonVersion }: {
    source = [
      nixpkgsPython.projects.cython.latest.${pythonVersion}.dev
      nixpkgsPython.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
