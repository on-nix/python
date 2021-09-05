{
  searchPathsRuntime = { nixpkgs, ... }: {
    rpath = [ nixpkgs.gcc.cc.lib ];
  };
}
