{
  makesSrc = builtins.fetchGit {
    url = "https://github.com/fluidattacks/makes";
    rev = "275cf112de3611f000f5e1e41d08060b605e77de";
  };
}
