{
  extraInstallers = {
    setuptools = "57.4.0";
    wheel = "0.37.0";
  };
  searchPathsBuild = { nixpkgs, ... }: {
    bin = [ nixpkgs.gcc ];
  };
}
