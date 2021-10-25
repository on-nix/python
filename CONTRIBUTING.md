# Notes

Some projects are only meant to be used on windows.
Do not try to package them:

```nix
{
  patchClosure = closure: builtins.removeAttrs closure [
    "pywin32"
    "pywinpty"
    "twisted-iocpsupport"
  ];
}
```

---
