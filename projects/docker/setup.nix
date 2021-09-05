{
  patchClosure = closure: builtins.removeAttrs closure [ "pywin32" ] // {
    six = "1.16.0";
  };
}
