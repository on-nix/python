{
  bootstrapped = [ "numpy" ];
  searchPaths = { nixpkgs, ... }: {
    rpath = [ nixpkgs.gcc.cc.lib ];
  };
}
