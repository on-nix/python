{
  patchClosure = closure: builtins.removeAttrs closure [ "pywin32" ];
}
