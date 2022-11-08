{
  patchClosure = closure:
    builtins.removeAttrs closure [
      "pywin32"
      "pywinpty"
    ];
}
