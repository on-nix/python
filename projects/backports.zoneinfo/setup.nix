{
  patchClosure = closure: closure // {
    setuptools = "57.4.0";
    wheel = "0.37.0";
  };
  searchPaths = { nixpkgs, ... }: {
    bin = [ nixpkgs.gcc ];
  };
}
