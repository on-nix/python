{
  searchPathsBuild = { nixpkgs, nixpkgsPython }: {
    bin = [ nixpkgs.gcc ];
    source = [ nixpkgsPython.cython nixpkgsPython.numpy ];
  };
}
