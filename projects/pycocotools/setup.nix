{
  searchPaths = { nixpkgs, ... }: {
    bin = [ nixpkgs.gcc ];
  };
}
