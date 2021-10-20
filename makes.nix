{
  formatMarkdown = {
    enable = true;
    doctocArgs = [ "--title" "# Contents" ];
    targets = [ "/README.md" ];
  };
  inputs = {
    pythonOnNix = import ./default.nix { };
  };
}
