{
  buildGccBin = true;
  searchPathsBuild = { pythonOnNix, pythonVersion, ... }: {
    source = [
      pythonOnNix.projects.persistent.latest.${pythonVersion}.dev
      pythonOnNix.projects.zope-proxy.latest.${pythonVersion}.dev
    ];
  };
}
