{
  runtimeLibstdcppRpath = true;
  searchPathsRuntime = {nixpkgs, ...}: {
    rpath = [
      nixpkgs.glib.out
      nixpkgs.libGL
    ];
  };
}
