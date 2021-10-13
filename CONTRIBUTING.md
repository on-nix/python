# Notes

Some projects are only meant to be used on windows:
These projects are windows only. Do not try to package them:

```nix
{
  patchClosure = closure: builtins.removeAttrs closure [
    "pywin32"
    "twisted-iocpsupport"
  ];
}
```

---
