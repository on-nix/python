{ __nixpkgs__
, makeDerivation
, pythonOnNix
, toFileJson
, ...
}:
let
  name = "makes-generate-index";

  data = pythonOnNix.projectsMeta;
in
makeDerivation {
  builder = ./builder.sh;
  env.envX = toFileJson "asdf" data;
  inherit name;
  searchPaths.bin = [ __nixpkgs__.jq ];
}
