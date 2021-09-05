{
  searchPathsRuntime = { nixpkgs, ... }: {
    rpath = [
      nixpkgs.gcc.cc.lib
      nixpkgs.glib.out
      nixpkgs.libGL
    ];
  };
}
