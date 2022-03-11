{
  buildGccBin = true;
  buildSetuptools_57_5_0 = true;
  searchPathsBuild = {
    pythonOnNix,
    pythonVersion,
    ...
  }: {
    source = [
      pythonOnNix.projects.persistent.latest.${pythonVersion}.dev
      pythonOnNix.projects.zope-proxy.latest.${pythonVersion}.dev
    ];
  };
}
