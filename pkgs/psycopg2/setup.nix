{
  searchPaths = { nixpkgs, ... }: {
    bin = [
      nixpkgs.gcc
      nixpkgs.postgresql
    ];
  };
}
