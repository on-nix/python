{
  patchClosure = closure: builtins.removeAttrs closure ["pywin32"];
  runtimeWants = ["six"];
}
