{
  buildSetuptools_57_5_0 = true;
  patchClosure = closure:
    builtins.removeAttrs closure [
      "pywin32"
      "pywinpty"
    ];
}
