# Mathlib Mini

[![Docs Site](https://img.shields.io/badge/docs-site-blue?logo=github)](https://mathlib-mini.github.io/mathlib-mini/)
[![Repo](https://img.shields.io/badge/repo-GitHub-black?logo=github)](https://github.com/mathlib-mini/mathlib-mini)
[![Tooling](https://img.shields.io/badge/python-3.15%2B-blue?logo=python)](./pyproject.toml)
[![License](https://img.shields.io/badge/license-Apache--2.0-yellow.svg)](./LICENSE)

[![CI-Lean](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/ci-lean.yml/badge.svg?branch=main)](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/ci-lean.yml)
[![CI](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/ci-python-zensical.yml/badge.svg?branch=main)](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/ci-python-zensical.yml)
[![Docs](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/deploy-zensical-lean.yml/badge.svg?branch=main)](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/deploy-zensical-lean.yml)
[![Links](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/links.yml/badge.svg?branch=main)](https://github.com/mathlib-mini/mathlib-mini/actions/workflows/links.yml)
[![Dependabot](https://img.shields.io/badge/Dependabot-enabled-brightgreen.svg)](https://github.com/mathlib-mini/mathlib-mini/security)

> A small, Mathlib-inspired foundation for Lean 4 that depends only on
> Lean core. Unofficial.

## Import

Import the public surface:

```lean
import MathlibMini
```

## Developer

Maintain:

- `lakefile.toml`
- `lean-toolchain`
- `compatibility/` - separate package that checks agreement with Mathlib

### Clone and Open Project in VS Code

Open a machine terminal where you want the project
and open in VS Code:

```shell
git clone https://github.com/mathlib-mini/mathlib-mini

cd mathlib-mini
code .
```

### Setup and Run

Use VS Code Menu:
View / Command Palette / `Developer: Reload Window` to refresh.

```shell
.\sit.ps1
.\rel.ps1

# save progress
git add -A
git commit -m "update"
git push -u origin main
```

## Changelog

[CHANGELOG.md](./CHANGELOG.md)

## Citation

[CITATION.cff](./CITATION.cff)

## Documentation

[Documentation](https://mathlib-mini.github.io/mathlib-mini/) -
descriptive orientation

## Module

[Lean](./MathlibMini.lean)

## License

[Apache 2.0](./LICENSE)
