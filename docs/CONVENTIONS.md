# Conventions

This file documents the conventions we follow in this project.

## Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <short summary in present tense>
```

Common types:

| Type | When to use |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `chore` | Maintenance, tooling, cleanup |
| `test` | Tests |
| `ci` | CI/CD changes |
| `refactor` | Code change that doesn't add a feature or fix a bug |

Example: `feat: add dark mode support`

## Branches

| Pattern | Purpose |
|---|---|
| `main` | Stable, always deployable |
| `feat/<slug>` | New features |
| `fix/<slug>` | Bug fixes |
| `docs/<slug>` | Documentation |
| `chore/<slug>` | Maintenance |

## Versioning

We follow [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`

| Change | Bump |
|---|---|
| Breaking change | Major (e.g. 1.0.0 → 2.0.0) |
| New feature | Minor (e.g. 1.0.0 → 1.1.0) |
| Bug fix | Patch (e.g. 1.0.0 → 1.0.1) |

## Code Style

<!-- Add your project-specific style rules here. Examples:
- We use Prettier with default settings for JavaScript/TypeScript
- We use Black for Python
- Line length: 100 characters
-->
Follow the existing code style. When in doubt, match the surrounding code.
