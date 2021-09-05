{
  searchPathsRuntime = { nixpkgs, ... }: {
    bin = [ nixpkgs.git ];
  };
}
