{
  searchPathsRuntime = { nixpkgs, ... }: {
    rpath = [ nixpkgs.file ];
  };
}
