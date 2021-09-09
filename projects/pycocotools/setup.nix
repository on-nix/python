{
  searchPathsBuild = { nixpkgs, nixpkgsPython, pythonVersion }: {
    bin = [ nixpkgs.gcc ];
    source = [
      nixpkgsPython.projects.cython.latest.${pythonVersion}.dev
      nixpkgsPython.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
