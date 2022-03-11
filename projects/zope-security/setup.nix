{
  buildSetuptools_57_5_0 = true;
  buildWheel = true;
  searchPathsBuild = {
    pythonOnNix,
    pythonVersion,
    ...
  }: {
    source = [
      pythonOnNix.projects.zope-proxy.latest.${pythonVersion}.dev
    ];
  };
}
