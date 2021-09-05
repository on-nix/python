{
  bootstrapped = [ "cython" "numpy" ];
  searchPaths = { nixpkgs, ... }: {
    bin = [ nixpkgs.gcc ];
  };
}
