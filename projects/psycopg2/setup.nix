{
  searchPathsBuild = { nixpkgs, ... }: {
    bin = [
      nixpkgs.gcc
      nixpkgs.postgresql
    ];
  };
}
