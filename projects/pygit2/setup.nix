{
  runtimeWants = [ "cached-property" ];
  searchPathsRuntime =
    {
      nixpkgs,
      ...
    }:
    {
      source = [
        (
          nixpkgs.writeText "setup" ''
            export SSL_CERT_FILE=${nixpkgs.cacert}/etc/ssl/certs/ca-bundle.crt
          ''
        )
      ];
    };
}
