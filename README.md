# Genesis

A batteries-included GitHub repository template — community files, CI/CD workflows, and a one-command setup script.

## What's Included

| Path                               | Purpose                                                       |
| ---------------------------------- | ------------------------------------------------------------- |
| `.github/workflows/`               | CI, hygiene checks, and automated releases via Release Please |
| `.github/ISSUE_TEMPLATE/`          | Bug report and feature request forms                          |
| `.github/PULL_REQUEST_TEMPLATE.md` | Consistent PR descriptions                                    |
| `.github/CODEOWNERS`               | Code ownership configuration                                  |
| `.github/dependabot.yml`           | Automated dependency updates                                  |
| `docs/conventions/`                | Branching, commit, and versioning standards                   |
| `CODE_OF_CONDUCT.md`               | Contributor Covenant                                          |
| `CONTRIBUTING.md`                  | How to contribute                                             |
| `SECURITY.md`                      | Vulnerability reporting policy                                |
| `SUPPORT.md`                       | Where to get help                                             |
| `.devcontainer/`                   | Dev Container for GitHub Codespaces and VS Code               |
| `.editorconfig`                    | Consistent editor settings                                    |
| `.gitattributes`                   | Line ending normalization                                     |
| `scripts/init-project.sh`          | One-command setup to fill in all placeholders                 |

## Installation

1. Clone the repository:

```sh
git clone https://github.com/wannacry081/genesis
```

2. Run the setup script:

```sh
sh scripts/init-project.sh
```

Or, if `make` is installed:

```sh
make init
```

3. Follow the prompts to fill in your project details. The script will replace all placeholders, then remove itself, `README.md`, and `.gitignore` so you can start fresh with your own.

## Placeholders

| Placeholder          | What to put there               |
| -------------------- | ------------------------------- |
| `<PROJECT_NAME>`     | Your project name               |
| `<DESCRIPTION>`      | One-line description            |
| `<OWNER>`            | GitHub username or organization |
| `<COPYRIGHT_HOLDER>` | Your name or organization       |
| `<YEAR>`             | Current year                    |
| `<CONTACT_EMAIL>`    | Code of Conduct contact email   |
| `<SECURITY_CONTACT>` | Security vulnerability contact  |

## Customization

### Package Manager

CI defaults to `pnpm`. To switch, update [`.github/workflows/ci.yml`](.github/workflows/ci.yml):

1. Replace the `pnpm/action-setup` step with the setup action for your package manager (or remove it for `npm`).
2. Change `cache: "pnpm"` on the `setup-node` step to match (e.g. `"npm"` or `"yarn"`).
3. Replace the `pnpm` commands in the `Install dependencies`, `Lint`, `Build`, and `Test` steps.

### Release & Publishing

[`.github/workflows/release.yml`](.github/workflows/release.yml) uses [Release Please](https://github.com/googleapis/release-please-action) to automate changelogs and GitHub releases. Two things to configure:

- **Release type** — change `release-type: node` in the workflow (and in [`release-please-config.json`](release-please-config.json)) to match your project (`python`, `go`, `simple`, etc.).
- **Publish step** — the `publish` job contains commented-out blocks for npm, PyPI, and Docker. Uncomment the one that matches your project and add the required secret (`NPM_TOKEN`, `PYPI_API_TOKEN`, etc.) to your repository.

### Dependency Updates

[`.github/dependabot.yml`](.github/dependabot.yml) only tracks GitHub Actions by default. Uncomment the block matching your package manager (`npm`, `pip`, `docker`, etc.) to enable automated dependency PRs for your project's ecosystem.

### Code Owners

[`.github/CODEOWNERS`](.github/CODEOWNERS) assigns `@<OWNER>` as the default reviewer for all pull requests. Replace it with your GitHub username or a team handle (e.g. `@my-org/maintainers`).

### Sponsor Button

[`.github/FUNDING.yml`](.github/FUNDING.yml) controls the **Sponsor** button on your repo page. The `github:` field is pre-filled with `<OWNER>`. Uncomment any additional platforms (Patreon, Ko-fi, Buy Me a Coffee, etc.) you want to show.

### Dev Container

[`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) defines the environment for GitHub Codespaces and the VS Code Dev Containers extension. It ships with a minimal Ubuntu base — uncomment the language runtime feature that matches your project (Node.js, Python, Go, etc.) and add any project-specific VS Code extensions to the `customizations.vscode.extensions` array.

### VS Code Extensions

[`.vscode/extensions.json`](.vscode/extensions.json) lists recommended extensions that VS Code suggests when someone opens the repo. The base set covers EditorConfig, Markdown, YAML, and GitHub Actions. Add your project-specific extensions (e.g. ESLint, Prettier, Pylance, Go) to the `recommendations` array.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
