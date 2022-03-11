{
  buildExtra = ''
    patchelf \
      --set-interpreter $LOADER \
      $out/lib/python*/site-packages/kaleido/executable/bin/kaleido
    patch_shebangs \
      $out/lib/python*/site-packages/kaleido/executable/kaleido
  '';
  searchPathsBuild = {
    makes,
    nixpkgs,
    ...
  }: {
    bin = [
      nixpkgs.bash
      nixpkgs.glibc.bin
      nixpkgs.patchelf
    ];
    rpath = [
      nixpkgs.expat.out
      nixpkgs.nspr.out
      nixpkgs.nss.out
    ];
    export = [
      ["LOADER" nixpkgs.glibc.out "/lib/ld-linux-x86-64.so.2"]
    ];
    source = [makes.patchShebangs];
  };
}
