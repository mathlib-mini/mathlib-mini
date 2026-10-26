# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on **[Keep a Changelog](https://keepachangelog.com/en/1.1.0/)**
and this project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**.

---

## [Unreleased]

---

## [0.2.0] - 2026-10-26

### Added

- Set-builder notation `{ x | p x }` and `{ x : α | p x }`, printed back in
  the same form, with `Set.mem_setOf_eq` (`MathlibMini.Set.Builder`)
- Strict subset `⊂` with `Set.ssubset_def` (`MathlibMini.Set.Basic`)

### Changed

- `Set.subset_refl` is tagged `@[refl]`, so `rfl` closes `s ⊆ s`
- Updated license notice.
- Added headers to Lean files.

---

## [0.1.1] - 2026-10-25

### Changed

- Moved Batteries-based linting into a separate `lint/` Lake package.
- Removed Batteries as a dependency of the main Mathlib Mini package.
- Updated release validation to run linting through the separate package.
- Preserved the public mathematical definitions, theorems, and import surface.

### Fixed

- The main Mathlib Mini package now depends only on Lean core.

---

## [0.1.0] - 2026-10-24

### Added

- `MathlibMini.Set`: sets as membership predicates, with `ofPredicate`,
  membership, the subset relation, and extensionality
  (`MathlibMini.Set.Basic`)
- Empty set, universal set, singleton, insertion, union, and intersection,
  each with a membership lemma, plus basic order and union/intersection laws
  (`MathlibMini.Set.Operations`)
- Tests exercising the public surface from an importing module
  (`MathlibMiniTest`)
- Lint driver using the Batteries environment linters (`MathlibMiniLint`)
- Compatibility package (`compatibility/`) proving that conversion between
  `MathlibMini.Set` and Mathlib's `Set` is lossless and preserves membership,
  subset, and each operation
- The library imports only Lean core and has no Mathlib dependency

---

## Notes on versioning and releases

- We use **SemVer**:
  - **MAJOR** - breaking changes
  - **MINOR** - backward-compatible additions
  - **PATCH** - fixes, documentation, tooling
- Versions are driven by git tags.
- Tag `vX.Y.Z` to release.
- During `0.x` development, breaking formal-surface changes
  may occur in a **MINOR** release.

## Release Procedure (Required)

Follow these steps exactly when creating a new release.

### One-Time Zenodo Authorization

1. Sign in to Zenodo.
2. Open your profile menu in the upper-right.
3. Select GitHub.
4. Click Sync now.
5. Find mathlib-mini/ this repo.
6. Turn on the repository toggle/slider.
7. Refresh the page and confirm it appears as enabled.
8. Zenodo will ingest future GitHub Releases from this repo.

### Task 1. Update release metadata (manual edits)

1.1. CITATION.cff: update version and date-released
1.2. lakefile.toml: update version
1.3. lakefile.toml: update version in `compatibility/`
1.4. lakefile.toml: update version in `lint/`
1.3. CHANGELOG.md: add section, move unreleased entries, update links, release command
1.4. pyproject.toml: update version (near top of the file)

### Task 2. Set up and Validate

```shell
# set up or update Python environment
# Run repository checks.
.\sit.ps1

# Update GitHub Actions and pin all action references to immutable SHAs.
uvx gha-tools autoupdate --pin=all --write .github/workflows

# Audit the resulting GitHub configuration for security findings.
# NO .github\workflows\deploy-zensical.yml
# YES  .github\workflows\deploy-zensical-lean.yml
uvx zizmor@latest .github/
# Some suppressed are still okay

# Validate.
uvx cffconvert --validate

# Format Markdown.
npx markdownlint-cli2 --fix

.\rel.ps1
.\sit.ps1
```

Review all generated and modified files before committing.

### Task 3. Commit and Push

```shell
git add -A
git commit -m "Prep X.Y.Z"
git push -u origin main
```

Verify that all required GitHub Actions complete successfully.

### Task 4. Tag and Push the Release

After the required GitHub Actions succeed:

```shell
git tag vX.Y.Z -m "X.Y.Z"
git push origin vX.Y.Z
```

Create GitHub Release after pushing tag, for example with a command like this:

```shell
gh release create v0.2.0 --verify-tag --title "0.2.0" --generate-notes
```

## Only As Needed (delete a tag)

```shell
git tag -d vX.Z.Y
git push origin :refs/tags/vX.Z.Y
```

## Links

[Unreleased]: https://github.com/mathlib-mini/mathlib-mini/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/mathlib-mini/mathlib-mini/releases/tag/v0.2.0
[0.1.1]: https://github.com/mathlib-mini/mathlib-mini/releases/tag/v0.1.1
[0.1.0]: https://github.com/mathlib-mini/mathlib-mini/releases/tag/v0.1.0

<!-- markdownlint-enable MD024 -->
