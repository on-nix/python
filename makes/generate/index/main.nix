{ makeEntrypoint
, ...
}:
makeEntrypoint {
  entrypoint = ./entrypoint.sh;
  name = "makes-generate-index";
}
