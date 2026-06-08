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

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.
