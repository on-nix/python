{
  searchPathsRuntime = { nixpkgs, nixpkgsPython, ... }: {
    rpath = [ nixpkgs.gcc.cc.lib ];
    source = [ nixpkgsPython.numpy ];
  };
}
