# Mathlib Mini

> A small, Mathlib-inspired foundation for Lean 4 that depends only on
> Lean core. Unofficial.

Mathlib Mini provides recognizable, Mathlib-style foundational definitions
with proved properties, for projects that want those building blocks
without depending on Mathlib.

## Import

```lean
import MathlibMini
```

## Scope

- Everything in `MathlibMini` imports only Lean core.
- Names live under the `MathlibMini` namespace, so the library can be
  imported alongside Mathlib without name clashes.
- This is an independent library inspired by Mathlib. It is not part of
  Mathlib and is not endorsed by the Mathlib community.

## Compatibility with Mathlib

The `compatibility/` package depends on both Mathlib and Mathlib Mini.
It proves that converting between `MathlibMini.Set` and Mathlib's `Set`
is lossless and preserves membership, subset, and each operation.
If a Mathlib change breaks one of those theorems, that package fails to
build.

## API reference

[Lean API reference](lean/index.html) - generated from the source.
