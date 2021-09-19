{
  buildWheel = true;
  searchPathsBuild = { pythonOnNix, pythonVersion, ... }: {
    source = [
      pythonOnNix.projects.zope-proxy.latest.${pythonVersion}.dev
    ];
  };
}
