{
  patchClosure = closure: closure // {
    cached-property = "1.5.2";
  };
  searchPathsRuntime = { nixpkgs, ... }: {
    source = [
      (nixpkgs.writeText "setup" ''
        export SSL_CERT_FILE=${nixpkgs.cacert}/etc/ssl/certs/ca-bundle.crt
      '')
    ];
  };
}
