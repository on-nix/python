{
  buildExtra = ''
    patchelf \
      --set-interpreter $LOADER \
      $out/lib/python*/site-packages/ray/core/src/ray/gcs/gcs_server
    patchelf \
      --set-interpreter $LOADER \
      $out/lib/python*/site-packages/ray/core/src/ray/raylet/raylet
    patchelf \
      --set-interpreter $LOADER \
      $out/lib/python*/site-packages/ray/core/src/ray/thirdparty/redis/src/redis-server
  '';
  searchPathsBuild = { nixpkgs, ... }: {
    bin = [
      nixpkgs.glibc.bin
      nixpkgs.patchelf
    ];
    export = [
      [ "LOADER" nixpkgs.glibc.out "/lib/ld-linux-x86-64.so.2" ]
    ];
  };
}
