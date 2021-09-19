{ makeScript
, ...
}:
makeScript {
  entrypoint = ./entrypoint.sh;
  name = "makes-generate-index";
}
