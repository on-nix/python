{ makeNodeJsEnvironment
, makeDerivation
}:
let
  name = "makes-generate-index";
  env = makeNodeJsEnvironment {
    inherit name;
    packageJson = ./npm/package.json;
    packageLockJson = ./npm/package-lock.json;
  };
in
makeDerivation {
  builder = ./builder.sh;
  inherit name;
}
