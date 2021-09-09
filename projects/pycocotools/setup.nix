{
  searchPathsBuild = { nixpkgs, nixpkgsPython, pythonVersion }: {
    bin = [ nixpkgs.gcc ];
    source = [
      nixpkgsPython.cython.__latest__.${pythonVersion}
      nixpkgsPython.numpy.__latest__.${pythonVersion}
    ];
  };
}
