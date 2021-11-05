{
  patchClosure = closure: builtins.removeAttrs closure [
    "pywinpty"
  ];
}
