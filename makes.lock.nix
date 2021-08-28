{
  makesSrc = builtins.fetchGit {
    url = "https://github.com/fluidattacks/makes";
    rev = "ea62331f5fe2028feb395ca8d9caceb5107e2759";
  };
}
