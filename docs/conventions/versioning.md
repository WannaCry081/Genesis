# Versioning

We follow [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`

| Change                            | Bump  | Example         |
| --------------------------------- | ----- | --------------- |
| Breaking change                   | Major | `1.0.0 → 2.0.0` |
| New feature (backward compatible) | Minor | `1.0.0 → 1.1.0` |
| Bug fix or small improvement      | Patch | `1.0.0 → 1.0.1` |

## Releasing

Releases are fully automated via [release-please](https://github.com/googleapis/release-please-action) — do not push tags manually.

1. Merge commits to `main` with conventional commit prefixes.
2. release-please opens (or updates) a Release PR with the bumped version and changelog.
3. When ready to ship, merge the Release PR — CI creates the tag and GitHub Release automatically.

## Pre-releases

Use suffixes for pre-release identifiers: `1.0.0-alpha.1`, `1.0.0-rc.2`.
