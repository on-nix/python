{
  searchPathsRuntime = { nixpkgs, nixpkgsPython, pythonVersion, ... }: {
    rpath = [ nixpkgs.gcc.cc.lib ];
    source = [
      nixpkgsPython.projects.numpy.latest.${pythonVersion}.dev
    ];
  };
}
