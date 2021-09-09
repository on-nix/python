{
  searchPathsBuild = { nixpkgs, nixpkgsPython, pythonVersion }: {
    bin = [ nixpkgs.gcc ];
    source = [
      nixpkgsPython.cython.latest.${pythonVersion}.dev
      nixpkgsPython.numpy.latest.${pythonVersion}.dev
    ];
  };
}
