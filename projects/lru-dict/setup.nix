{
  searchPathsBuild = { nixpkgs, ... }: {
    bin = [ nixpkgs.gcc ];
  };
}
