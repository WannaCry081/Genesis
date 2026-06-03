# Base Repository Template — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a comprehensive, fully language-agnostic GitHub template repository that provides every file a project needs regardless of framework.

**Architecture:** A tree of universal static files grouped into root meta, governance, GitHub community health, Actions workflows, docs, task runner, dev-environment, and a setup helper script. Nothing language-specific is ever active — stack-specific slots are commented-out placeholders. All placeholder tokens use `<UPPER_SNAKE>` so a single `sed` sweep replaces them all.

**Tech Stack:** POSIX shell (setup script), GitHub Actions, Release Drafter, markdownlint-cli2, yamllint, editorconfig-checker, lychee (link check), actionlint (local verification only).

---

## File Map

```
/
├── .editorconfig
├── .gitattributes
├── .gitignore
├── .markdownlint.yaml
├── .yamllint.yaml
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── Makefile
├── README.md
├── SECURITY.md
├── SUPPORT.md
├── .devcontainer/
│   └── devcontainer.json
├── .github/
│   ├── CODEOWNERS
│   ├── FUNDING.yml
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yml
│   ├── labeler.yml
│   ├── release-drafter.yml          ← Release Drafter config
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   ├── config.yml
│   │   └── feature_request.yml
│   └── workflows/
│       ├── ci.yml                   ← skeleton only
│       ├── greetings.yml
│       ├── hygiene.yml
│       ├── pr-validation.yml
│       ├── release-drafter.yml      ← workflow that runs the action
│       ├── release.yml
│       └── stale.yml
├── .vscode/
│   └── extensions.json
├── docs/
│   ├── README.md
│   ├── CONVENTIONS.md
│   └── architecture/
│       └── decisions/
│           └── 0001-record-architecture-decisions.md
└── scripts/
    └── init-template.sh
```

---

## Task 1: Initialize git and core dotfiles

**Files:**
- Create: `.gitignore`
- Create: `.gitattributes`
- Create: `.editorconfig`

- [ ] **Step 1: Initialize git repository**

```bash
git init
git branch -M main
```

Expected: `Initialized empty Git repository in …/.git/`

- [ ] **Step 2: Create `.gitignore`**

```
# ── OS ────────────────────────────────────────────────────────────────────────
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# ── Editors / IDEs ────────────────────────────────────────────────────────────
.vscode/*
!.vscode/extensions.json
.idea/
*.swp
*.swo
*~

# ── Environment ───────────────────────────────────────────────────────────────
.env
.env.*
!.env.example

# ── Logs ──────────────────────────────────────────────────────────────────────
*.log
logs/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# ── Build / dist / tmp ────────────────────────────────────────────────────────
dist/
build/
out/
tmp/
temp/
.tmp/
.cache/
coverage/

# ── Project-specific dependencies (append per project) ────────────────────────
# node_modules/
# __pycache__/
# *.pyc
# .venv/
# vendor/
```

- [ ] **Step 3: Create `.gitattributes`**

```
# Normalize line endings to LF on commit
* text=auto eol=lf

# Explicit text files
*.md        text
*.yaml      text
*.yml       text
*.json      text
*.toml      text
*.sh        text eol=lf
*.bash      text eol=lf
Makefile    text

# Binary files – do not mangle
*.png       binary
*.jpg       binary
*.jpeg      binary
*.gif       binary
*.ico       binary
*.svg       binary
*.pdf       binary
*.zip       binary
*.tar.gz    binary
*.woff      binary
*.woff2     binary
*.ttf       binary
*.eot       binary
```

- [ ] **Step 4: Create `.editorconfig`**

```ini
root = true

[*]
charset               = utf-8
end_of_line           = lf
insert_final_newline  = true
trim_trailing_whitespace = true
indent_style          = space
indent_size           = 2

[Makefile]
# Make requires real tabs
indent_style = tab

[*.md]
# Allow trailing spaces (two spaces = intentional line break in Markdown)
trim_trailing_whitespace = false

[*.{yaml,yml}]
indent_size = 2

[*.sh]
indent_size = 2
```

- [ ] **Step 5: Commit**

```bash
git add .gitignore .gitattributes .editorconfig
git commit -m "chore: initialize repo with core dotfiles"
```

---

## Task 2: README and LICENSE

**Files:**
- Create: `README.md`
- Create: `LICENSE`

- [ ] **Step 1: Create `README.md`**

```markdown
# <PROJECT_NAME>

> <DESCRIPTION>

<!--
  This file was generated from the base repository template.
  Replace all <PLACEHOLDER> tokens before making this repo public.
  Run: scripts/init-template.sh
-->

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

<A short paragraph describing what this project does and why it exists.>

## Getting Started

### Prerequisites

<List any tools or accounts the user needs before they can run this project.>

### Installation

```sh
# TODO: add installation steps
```

## Usage

```sh
# TODO: add usage examples
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for details.

---

<!-- Template checklist (delete before going public) -->
<details>
<summary>📋 Template setup checklist</summary>

Run `scripts/init-template.sh` to automate steps 1-3, or do them manually:

1. Replace every `<PLACEHOLDER>` token:
   - `<PROJECT_NAME>` → your project name
   - `<DESCRIPTION>` → one-line project description
   - `<OWNER>` → your GitHub username or org
   - `<YEAR>` → current year
   - `<COPYRIGHT_HOLDER>` → your name or organization
   - `<CONTACT_EMAIL>` → email for Code of Conduct reports
   - `<SECURITY_CONTACT>` → security contact (email or URL)
2. Pick a license: keep MIT or swap `LICENSE` for another.
3. Enable **GitHub → Settings → Template repository**.
4. Enable **Dependabot** in GitHub → Settings → Code security.
5. Create the PR labels used by Release Drafter:
   `major`, `minor`, `patch`, `feature`, `enhancement`, `fix`, `bug`,
   `bugfix`, `chore`, `maintenance`, `docs`, `documentation`.
6. Delete this checklist block from `README.md`.
7. Delete `scripts/init-template.sh` and `template-setup.md` (if present).

</details>
```

- [ ] **Step 2: Create `LICENSE`**

```
MIT License

Copyright (c) <YEAR> <COPYRIGHT_HOLDER>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

- [ ] **Step 3: Commit**

```bash
git add README.md LICENSE
git commit -m "docs: add README and MIT LICENSE"
```

---

## Task 3: CHANGELOG

**Files:**
- Create: `CHANGELOG.md`

- [ ] **Step 1: Create `CHANGELOG.md`**

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- Release Drafter auto-updates the GitHub Releases page with categorised notes.
     This file tracks the same history in a human-readable, repo-native format.
     When you publish a release, copy the generated notes here under the new version. -->

## [Unreleased]

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

[Unreleased]: https://github.com/<OWNER>/<PROJECT_NAME>/compare/HEAD
```

- [ ] **Step 2: Commit**

```bash
git add CHANGELOG.md
git commit -m "docs: add CHANGELOG following Keep a Changelog format"
```

---

## Task 4: Governance files

**Files:**
- Create: `CONTRIBUTING.md`
- Create: `CODE_OF_CONDUCT.md`
- Create: `SECURITY.md`
- Create: `SUPPORT.md`

- [ ] **Step 1: Create `CONTRIBUTING.md`**

```markdown
# Contributing to <PROJECT_NAME>

Thank you for taking the time to contribute! The following guidelines help keep
the project consistent and make reviews faster for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Branch Strategy](#branch-strategy)
- [Commit Messages](#commit-messages)
- [Pull Requests](#pull-requests)
- [Versioning](#versioning)

## Code of Conduct

This project follows the [Contributor Covenant](CODE_OF_CONDUCT.md).
By participating, you agree to uphold it.

## How to Contribute

1. Fork the repository and create a branch from `main`.
2. Make your changes (see [Branch Strategy](#branch-strategy)).
3. Push the branch and open a Pull Request.
4. A maintainer will review and merge it.

For substantial changes, open an issue first to discuss the approach.

## Branch Strategy

| Branch pattern | Purpose |
|---|---|
| `main` | Stable, always deployable |
| `feat/<short-description>` | New features |
| `fix/<short-description>` | Bug fixes |
| `chore/<short-description>` | Maintenance, refactoring |
| `docs/<short-description>` | Documentation only |

## Commit Messages

We follow the **[Conventional Commits](https://www.conventionalcommits.org/)**
specification (not enforced automatically, but strongly encouraged):

```
<type>(<optional scope>): <short summary>

[optional body]

[optional footer]
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `build`.

Examples:
```
feat(auth): add OAuth2 login flow
fix: handle null response from upstream API
docs: update README installation steps
chore: bump actions/checkout to v4
```

## Pull Requests

- Keep PRs focused — one logical change per PR.
- Fill in the PR template completely.
- **Apply a label** from the list below — Release Drafter uses these to build
  release notes and compute the next SemVer bump:

| Label | Release Drafter category | Version bump |
|---|---|---|
| `feature` / `enhancement` | 🚀 Features | minor |
| `fix` / `bug` / `bugfix` | 🐛 Bug Fixes | patch |
| `chore` / `maintenance` | 🧰 Maintenance | patch |
| `docs` / `documentation` | 📚 Documentation | patch |
| `major` / `breaking-change` | — | **major** |

## Versioning

This project follows **[Semantic Versioning](https://semver.org/)** (`MAJOR.MINOR.PATCH`):

- **MAJOR** — incompatible API/breaking change
- **MINOR** — new backward-compatible functionality
- **PATCH** — backward-compatible bug fix

Releases are drafted automatically by
[Release Drafter](https://github.com/release-drafter/release-drafter)
based on PR labels (see table above).
To ship a release, push a tag:

```bash
git tag v1.2.3
git push origin v1.2.3
```

The GitHub Release is published automatically from the existing draft.
```

- [ ] **Step 2: Create `CODE_OF_CONDUCT.md`**

```markdown
# Contributor Covenant Code of Conduct

## Our Pledge

We as members, contributors, and leaders pledge to make participation in our
community a harassment-free experience for everyone, regardless of age, body
size, visible or invisible disability, ethnicity, sex characteristics, gender
identity and expression, level of experience, education, socio-economic status,
nationality, personal appearance, race, caste, color, religion, or sexual
identity and orientation.

We pledge to act and interact in ways that contribute to an open, welcoming,
diverse, inclusive, and healthy community.

## Our Standards

Examples of behavior that contributes to a positive environment:

- Demonstrating empathy and kindness toward other people
- Being respectful of differing opinions, viewpoints, and experiences
- Giving and gracefully accepting constructive feedback
- Accepting responsibility and apologizing to those affected by our mistakes
- Focusing on what is best for the overall community

Examples of unacceptable behavior:

- The use of sexualized language or imagery, and sexual attention or advances
- Trolling, insulting or derogatory comments, and personal or political attacks
- Public or private harassment
- Publishing others' private information without explicit permission
- Other conduct which could reasonably be considered inappropriate

## Enforcement Responsibilities

Community leaders are responsible for clarifying and enforcing our standards
and will take appropriate and fair corrective action in response to any
behavior they deem inappropriate, threatening, offensive, or harmful.

## Scope

This Code of Conduct applies within all community spaces, and also applies when
an individual is officially representing the community in public spaces.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported to the community leaders responsible for enforcement at
**<CONTACT_EMAIL>**.

All complaints will be reviewed and investigated promptly and fairly.

## Enforcement Guidelines

Community leaders will follow these Community Impact Guidelines:

### 1. Correction
**Impact:** Minor, unprofessional behavior.
**Consequence:** Private written warning, request for public apology.

### 2. Warning
**Impact:** Violation through a single incident or series of actions.
**Consequence:** Warning with consequences for continued behavior.

### 3. Temporary Ban
**Impact:** Serious violation of community standards.
**Consequence:** Temporary ban from community interaction.

### 4. Permanent Ban
**Impact:** Pattern of violations or egregious behavior.
**Consequence:** Permanent ban from community interaction.

## Attribution

This Code of Conduct is adapted from the
[Contributor Covenant](https://www.contributor-covenant.org/), version 2.1,
available at
<https://www.contributor-covenant.org/version/2/1/code_of_conduct.html>.
```

- [ ] **Step 3: Create `SECURITY.md`**

```markdown
# Security Policy

## Supported Versions

| Version | Supported |
|---|---|
| latest | ✅ |
| older  | ❌ |

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub Issues.**

To report a security vulnerability, please contact us at:

- **Email / URL:** <SECURITY_CONTACT>

You should receive an acknowledgement within 48 hours.
We aim to release a fix within 90 days of disclosure.

Once a fix is released we will publish a security advisory crediting you
(unless you prefer to remain anonymous).
```

- [ ] **Step 4: Create `SUPPORT.md`**

```markdown
# Support

## Where to Get Help

- **Documentation:** [`docs/`](docs/)
- **Bugs & feature requests:** [Open an issue](../../issues)
- **Discussions / Q&A:** [GitHub Discussions](../../discussions)
- **Security issues:** See [SECURITY.md](SECURITY.md)

## Before Opening an Issue

1. Search [existing issues](../../issues) — your question may already be answered.
2. Check the [docs](docs/).
3. Provide a minimal reproducible example if reporting a bug.
```

- [ ] **Step 5: Commit**

```bash
git add CONTRIBUTING.md CODE_OF_CONDUCT.md SECURITY.md SUPPORT.md
git commit -m "docs: add governance files (CONTRIBUTING, CoC, SECURITY, SUPPORT)"
```

---

## Task 5: `.github` base files

**Files:**
- Create: `.github/CODEOWNERS`
- Create: `.github/FUNDING.yml`
- Create: `.github/PULL_REQUEST_TEMPLATE.md`

- [ ] **Step 1: Create `.github/CODEOWNERS`**

```
# Global owner — receives review requests for every file.
# Replace @<OWNER> with your GitHub username or team (e.g. @acme/maintainers).
* @<OWNER>

# Examples for scoped ownership:
# docs/     @<OWNER>
# .github/  @<OWNER>
```

- [ ] **Step 2: Create `.github/FUNDING.yml`**

```yaml
# Funding links shown in the Sponsor button on GitHub.
# Uncomment and fill in the relevant platforms.
# See: https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/displaying-a-sponsor-button-in-your-repository

# github:          # GitHub Sponsors username(s)
# patreon:         # Patreon username
# open_collective: # Open Collective username
# ko_fi:           # Ko-fi username
# tidelift:        # Tidelift package name (e.g. npm/package-name)
# community_bridge: # LFX Mentorship project slug
# liberapay:       # Liberapay username
# issuehunt:       # IssueHunt username
# polar:           # Polar username
# buy_me_a_coffee: # Buy Me a Coffee username
# custom:          # Custom URL(s)
```

- [ ] **Step 3: Create `.github/PULL_REQUEST_TEMPLATE.md`**

```markdown
## Summary

<!-- What does this PR do? Why? -->

## Type of Change

<!-- Add the matching label to this PR — Release Drafter uses it to categorise
     release notes and compute the next SemVer version bump. -->

- [ ] `feature` / `enhancement` — new backward-compatible feature (minor bump)
- [ ] `fix` / `bug` — bug fix (patch bump)
- [ ] `chore` / `maintenance` — refactor, tooling, deps (patch bump)
- [ ] `docs` — documentation only (patch bump)
- [ ] `major` / `breaking-change` — breaking change (major bump)

## Testing

<!-- How was this tested? Screenshots, commands, logs — anything that helps the
     reviewer confirm it works. -->

## Checklist

- [ ] My changes follow the [contribution guidelines](../CONTRIBUTING.md)
- [ ] I have applied a label matching my change type (table in CONTRIBUTING.md)
- [ ] I updated the docs if the change affects usage
- [ ] I ran the Makefile lint target (`make lint`) and it passes locally
```

- [ ] **Step 4: Commit**

```bash
git add .github/CODEOWNERS .github/FUNDING.yml .github/PULL_REQUEST_TEMPLATE.md
git commit -m "chore: add CODEOWNERS, FUNDING, and PR template"
```

---

## Task 6: Issue templates

**Files:**
- Create: `.github/ISSUE_TEMPLATE/config.yml`
- Create: `.github/ISSUE_TEMPLATE/bug_report.yml`
- Create: `.github/ISSUE_TEMPLATE/feature_request.yml`

- [ ] **Step 1: Create `.github/ISSUE_TEMPLATE/config.yml`**

```yaml
blank_issues_enabled: false
contact_links:
  - name: 💬 Ask a Question
    url: https://github.com/<OWNER>/<PROJECT_NAME>/discussions
    about: Questions and discussions live here, not issues.
  - name: 🔒 Report a Security Vulnerability
    url: https://github.com/<OWNER>/<PROJECT_NAME>/security/advisories/new
    about: Please report security issues privately.
```

- [ ] **Step 2: Create `.github/ISSUE_TEMPLATE/bug_report.yml`**

```yaml
name: Bug Report
description: File a bug report
title: "bug: <short description>"
labels:
  - bug
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!
        Search existing issues before submitting.

  - type: textarea
    id: description
    attributes:
      label: Describe the Bug
      description: A clear and concise description of what the bug is.
    validations:
      required: true

  - type: textarea
    id: steps
    attributes:
      label: Steps to Reproduce
      description: Minimal steps to reproduce the behavior.
      placeholder: |
        1. Go to '...'
        2. Click on '...'
        3. See error
    validations:
      required: true

  - type: textarea
    id: expected
    attributes:
      label: Expected Behavior
      description: What did you expect to happen?
    validations:
      required: true

  - type: textarea
    id: actual
    attributes:
      label: Actual Behavior
      description: What actually happened? Include logs or screenshots if relevant.
    validations:
      required: true

  - type: textarea
    id: environment
    attributes:
      label: Environment
      description: OS, relevant tool versions, etc.
      placeholder: |
        - OS: macOS 15.2
        - Version: 1.0.0
    validations:
      required: false

  - type: checkboxes
    id: terms
    attributes:
      label: Pre-submission checklist
      options:
        - label: I searched existing issues and this is not a duplicate.
          required: true
        - label: I have provided a minimal reproducible example.
          required: false
```

- [ ] **Step 3: Create `.github/ISSUE_TEMPLATE/feature_request.yml`**

```yaml
name: Feature Request
description: Suggest an idea or improvement
title: "feat: <short description>"
labels:
  - enhancement
body:
  - type: markdown
    attributes:
      value: |
        Thanks for suggesting a feature! Please check existing issues and
        discussions before submitting.

  - type: textarea
    id: problem
    attributes:
      label: Problem Statement
      description: What problem does this feature solve? What is the current limitation?
    validations:
      required: true

  - type: textarea
    id: solution
    attributes:
      label: Proposed Solution
      description: Describe the solution you'd like.
    validations:
      required: true

  - type: textarea
    id: alternatives
    attributes:
      label: Alternatives Considered
      description: Any alternative solutions or features you've considered?
    validations:
      required: false

  - type: textarea
    id: context
    attributes:
      label: Additional Context
      description: Screenshots, mockups, links, or any other context.
    validations:
      required: false

  - type: checkboxes
    id: terms
    attributes:
      label: Pre-submission checklist
      options:
        - label: I searched existing issues and discussions — this has not been suggested before.
          required: true
```

- [ ] **Step 4: Commit**

```bash
git add .github/ISSUE_TEMPLATE/
git commit -m "chore: add GitHub issue templates (bug, feature, config)"
```

---

## Task 7: Lint configs and Makefile

**Files:**
- Create: `.markdownlint.yaml`
- Create: `.yamllint.yaml`
- Create: `Makefile`

- [ ] **Step 1: Create `.markdownlint.yaml`**

```yaml
# markdownlint-cli2 configuration
# Docs: https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md
default: true

MD013:
  # Line length — disabled; long lines are fine in prose
  enabled: false

MD033:
  # Inline HTML — allow <details>, <summary>, placeholders like <PROJECT_NAME>
  enabled: false

MD041:
  # First line should be H1 — relax for files like CHANGELOG that start differently
  enabled: false
```

- [ ] **Step 2: Create `.yamllint.yaml`**

```yaml
# yamllint configuration
# Docs: https://yamllint.readthedocs.io/en/stable/rules.html
extends: default

rules:
  line-length:
    max: 120
    level: warning
  truthy:
    allowed-values: ["true", "false", "on", "off"]
    check-keys: false
  comments:
    min-spaces-from-content: 1
  braces:
    min-spaces-inside: 0
    max-spaces-inside: 1
```

- [ ] **Step 3: Create `Makefile`**

```makefile
# =============================================================================
# Makefile — Universal task runner
# Every project gets the same entry-point vocabulary regardless of stack.
# Add project-specific commands in the ## Project section below.
# =============================================================================

.DEFAULT_GOAL := help
.PHONY: help setup lint fmt test clean

# ── Meta ─────────────────────────────────────────────────────────────────────

## help: Show this help message
help:
	@echo "Usage: make <target>"
	@echo ""
	@grep -E '^## ' $(MAKEFILE_LIST) \
		| sed 's/^## /  /' \
		| column -t -s ':'

# ── Bootstrap ─────────────────────────────────────────────────────────────────

## setup: Install project dependencies / bootstrap the dev environment
setup:
	@echo "ℹ  No setup configured yet."
	@echo "   TODO: add your install / bootstrap commands here."
	@echo "   Examples:"
	@echo "     npm install"
	@echo "     pip install -e '.[dev]'"
	@echo "     bundle install"

# ── Quality ───────────────────────────────────────────────────────────────────

## lint: Run all linters
lint:
	@echo "── Markdown ──────────────────────────────────────────────────────────"
	@command -v markdownlint-cli2 >/dev/null 2>&1 \
		&& markdownlint-cli2 "**/*.md" \
		|| echo "  markdownlint-cli2 not installed — skipping (npm i -g markdownlint-cli2)"
	@echo "── YAML ──────────────────────────────────────────────────────────────"
	@command -v yamllint >/dev/null 2>&1 \
		&& yamllint . \
		|| echo "  yamllint not installed — skipping (pip install yamllint)"
	@echo "── EditorConfig ──────────────────────────────────────────────────────"
	@command -v editorconfig-checker >/dev/null 2>&1 \
		&& editorconfig-checker \
		|| echo "  editorconfig-checker not installed — skipping (brew install editorconfig-checker)"
	@echo ""
	@echo "TODO: add project-specific linters here (eslint, ruff, rubocop, etc.)"

## fmt: Auto-format code
fmt:
	@echo "ℹ  No formatters configured yet."
	@echo "   TODO: add your formatter commands here."
	@echo "   Examples:"
	@echo "     prettier --write ."
	@echo "     black ."
	@echo "     gofmt -w ."

# ── Test ──────────────────────────────────────────────────────────────────────

## test: Run the test suite
test:
	@echo "ℹ  No test runner configured yet."
	@echo "   TODO: add your test commands here."
	@echo "   Examples:"
	@echo "     npm test"
	@echo "     pytest"
	@echo "     go test ./..."

# ── Clean ─────────────────────────────────────────────────────────────────────

## clean: Remove build artifacts and temporary files
clean:
	@echo "ℹ  No clean targets configured yet."
	@echo "   TODO: add directories/files to remove here."
	@echo "   Examples:"
	@echo "     rm -rf dist/ build/ .cache/ coverage/"

# ── Project ───────────────────────────────────────────────────────────────────
# Add project-specific targets below this line.
```

- [ ] **Step 4: Commit**

```bash
git add .markdownlint.yaml .yamllint.yaml Makefile
git commit -m "chore: add lint configs and universal Makefile"
```

---

## Task 8: GitHub Actions — hygiene and PR validation

**Files:**
- Create: `.github/workflows/hygiene.yml`
- Create: `.github/workflows/pr-validation.yml`

- [ ] **Step 1: Create `.github/workflows/hygiene.yml`**

```yaml
name: Repo Hygiene

on:
  push:
    branches: [main]
  pull_request:

concurrency:
  group: hygiene-${{ github.ref }}
  cancel-in-progress: true

jobs:
  markdown:
    name: Markdown Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DavidAnson/markdownlint-cli2-action@v17
        with:
          globs: "**/*.md"

  links:
    name: Link Check
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: lycheeverse/lychee-action@v2
        with:
          args: >
            --verbose
            --no-progress
            --exclude-loopback
            --exclude "^https://github.com/<OWNER>/<PROJECT_NAME>"
            '**/*.md'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  yaml:
    name: YAML Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ibiqlik/action-yamllint@v3
        with:
          config_file: .yamllint.yaml

  editorconfig:
    name: EditorConfig
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: editorconfig-checker/action-editorconfig-checker@v2
```

- [ ] **Step 2: Create `.github/workflows/pr-validation.yml`**

```yaml
name: PR Validation

on:
  pull_request:
    types:
      - opened
      - edited
      - synchronize
      - reopened

permissions:
  contents: read
  pull-requests: write

jobs:
  title:
    name: Validate PR Title (Conventional Commits)
    runs-on: ubuntu-latest
    steps:
      - uses: amannn/action-semantic-pull-request@v5
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          # Allowed types mirror CONTRIBUTING.md
          types: |
            feat
            fix
            docs
            chore
            refactor
            test
            ci
            build
            perf
            revert
          requireScope: false

  label:
    name: Auto-label by Path
    runs-on: ubuntu-latest
    steps:
      - uses: actions/labeler@v5
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
          configuration-path: .github/labeler.yml
          sync-labels: true
```

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/hygiene.yml .github/workflows/pr-validation.yml
git commit -m "ci: add hygiene and PR-validation workflows"
```

---

## Task 9: GitHub Actions — release, stale, greetings, and CI skeleton

**Files:**
- Create: `.github/workflows/release-drafter.yml`
- Create: `.github/workflows/release.yml`
- Create: `.github/workflows/stale.yml`
- Create: `.github/workflows/greetings.yml`
- Create: `.github/workflows/ci.yml`

- [ ] **Step 1: Create `.github/workflows/release-drafter.yml`**

```yaml
name: Release Drafter

on:
  push:
    branches: [main]
  pull_request:
    types: [opened, reopened, synchronize]

permissions:
  contents: write
  pull-requests: write

jobs:
  draft:
    name: Update Draft Release
    runs-on: ubuntu-latest
    steps:
      - uses: release-drafter/release-drafter@v6
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

- [ ] **Step 2: Create `.github/workflows/release.yml`**

```yaml
name: Release

on:
  push:
    tags:
      - "v*.*.*"

permissions:
  contents: write

jobs:
  publish:
    name: Publish GitHub Release
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Publish the GitHub Release (uses existing Release Drafter draft if present)
      - name: Create / Publish Release
        uses: softprops/action-gh-release@v2
        with:
          generate_release_notes: true
          # draft: false   # set to true to keep it a draft after tagging

      # ── Project-specific publish steps ────────────────────────────────────
      # Uncomment and adapt the block that matches your stack.
      #
      # Node / npm:
      # - uses: actions/setup-node@v4
      #   with: { node-version: "lts/*", registry-url: "https://registry.npmjs.org" }
      # - run: npm ci && npm publish --access public
      #   env: { NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }} }
      #
      # Python / PyPI:
      # - uses: actions/setup-python@v5
      #   with: { python-version: "3.x" }
      # - run: pip install build twine && python -m build
      # - uses: pypa/gh-action-pypi-publish@release/v1
      #   with: { password: ${{ secrets.PYPI_API_TOKEN }} }
      #
      # Docker:
      # - uses: docker/setup-buildx-action@v3
      # - uses: docker/login-action@v3
      #   with: { registry: ghcr.io, username: ${{ github.actor }}, password: ${{ secrets.GITHUB_TOKEN }} }
      # - uses: docker/build-push-action@v6
      #   with: { push: true, tags: ghcr.io/<OWNER>/<PROJECT_NAME>:${{ github.ref_name }} }
```

- [ ] **Step 3: Create `.github/workflows/stale.yml`**

```yaml
name: Stale Issues and PRs

on:
  schedule:
    # Run daily at 01:00 UTC
    - cron: "0 1 * * *"

permissions:
  issues: write
  pull-requests: write

jobs:
  stale:
    name: Mark and Close Stale Items
    runs-on: ubuntu-latest
    steps:
      - uses: actions/stale@v9
        with:
          stale-issue-message: >
            This issue has been automatically marked as stale because it has had
            no activity for 60 days. It will be closed in 14 days if no further
            activity occurs.
          stale-pr-message: >
            This pull request has been automatically marked as stale because it
            has had no activity for 30 days. It will be closed in 14 days if no
            further activity occurs.
          close-issue-message: >
            This issue was closed automatically after 74 days of inactivity.
            Please reopen if this is still relevant.
          close-pr-message: >
            This pull request was closed automatically after 44 days of inactivity.
            Please reopen if you'd like to continue.
          days-before-issue-stale: 60
          days-before-pr-stale: 30
          days-before-close: 14
          stale-issue-label: stale
          stale-pr-label: stale
          exempt-issue-labels: "pinned,security,blocked"
          exempt-pr-labels: "pinned,security,blocked"
```

- [ ] **Step 4: Create `.github/workflows/greetings.yml`**

```yaml
name: Greetings

on:
  pull_request_target:
    types: [opened]
  issues:
    types: [opened]

permissions:
  issues: write
  pull-requests: write

jobs:
  greet:
    name: Welcome First-Time Contributors
    runs-on: ubuntu-latest
    steps:
      - uses: actions/first-interaction@v1
        with:
          repo-token: ${{ secrets.GITHUB_TOKEN }}
          issue-message: >
            👋 Thanks for opening your first issue! A maintainer will take a look soon.
            In the meantime, please make sure you've filled out the issue template completely.
          pr-message: >
            🎉 Thanks for your first pull request! A maintainer will review it shortly.
            Please make sure you've applied a label matching your change type (see CONTRIBUTING.md).
```

- [ ] **Step 5: Create `.github/workflows/ci.yml`**

```yaml
# ── CI Skeleton ───────────────────────────────────────────────────────────────
# This is a PLACEHOLDER workflow. Fill in the TODOs for your project's stack.
# Rename this file to something descriptive once you've filled it in.
# ─────────────────────────────────────────────────────────────────────────────

name: CI

on:
  push:
    branches: [main]
  pull_request:

concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true

jobs:
  build-and-test:
    name: Build & Test
    runs-on: ubuntu-latest

    # TODO: Add a matrix if you support multiple versions/platforms, e.g.:
    # strategy:
    #   matrix:
    #     node-version: [18, 20, 22]

    steps:
      - uses: actions/checkout@v4

      # TODO: Set up your language runtime, e.g.:
      # - uses: actions/setup-node@v4
      #   with: { node-version: "lts/*" }
      #
      # - uses: actions/setup-python@v5
      #   with: { python-version: "3.x" }
      #
      # - uses: actions/setup-go@v5
      #   with: { go-version: "stable" }

      # TODO: Install dependencies, e.g.:
      # - run: npm ci
      # - run: pip install -e '.[dev]'
      # - run: go mod download

      # TODO: Lint, e.g.:
      # - run: npm run lint
      # - run: ruff check .
      # - run: golangci-lint run

      # TODO: Build (if applicable), e.g.:
      # - run: npm run build
      # - run: go build ./...

      # TODO: Test, e.g.:
      # - run: npm test
      # - run: pytest --cov
      # - run: go test ./...

      - name: Placeholder — remove once TODOs above are filled
        run: echo "CI skeleton — no build or test steps configured yet."
```

- [ ] **Step 6: Commit**

```bash
git add .github/workflows/
git commit -m "ci: add release-drafter, release, stale, greetings, and CI skeleton workflows"
```

---

## Task 10: Workflow configuration files

**Files:**
- Create: `.github/release-drafter.yml`
- Create: `.github/labeler.yml`
- Create: `.github/dependabot.yml`

- [ ] **Step 1: Create `.github/release-drafter.yml`**

```yaml
# Release Drafter Configuration
# Docs: https://github.com/release-drafter/release-drafter

name-template: "v$RESOLVED_VERSION"
tag-template: "v$RESOLVED_VERSION"

# ── Categories shown in the draft release notes ───────────────────────────────
categories:
  - title: "🚀 Features"
    labels:
      - "feature"
      - "enhancement"
  - title: "🐛 Bug Fixes"
    labels:
      - "fix"
      - "bugfix"
      - "bug"
  - title: "🧰 Maintenance"
    labels:
      - "chore"
      - "maintenance"
      - "refactor"
  - title: "📚 Documentation"
    labels:
      - "docs"
      - "documentation"
  - title: "⬆️ Dependencies"
    labels:
      - "dependencies"

# ── SemVer bump rules (highest matching label wins) ───────────────────────────
version-resolver:
  major:
    labels:
      - "major"
      - "breaking-change"
  minor:
    labels:
      - "minor"
      - "feature"
      - "enhancement"
  patch:
    labels:
      - "patch"
      - "fix"
      - "bugfix"
      - "bug"
      - "chore"
      - "maintenance"
      - "refactor"
      - "docs"
      - "documentation"
      - "dependencies"
  default: patch

# ── Auto-label PRs by changed paths ───────────────────────────────────────────
autolabeler:
  - label: "docs"
    files:
      - "*.md"
      - "docs/**"
  - label: "ci"
    files:
      - ".github/**"
  - label: "chore"
    files:
      - ".editorconfig"
      - ".gitignore"
      - ".gitattributes"
      - ".markdownlint.yaml"
      - ".yamllint.yaml"
      - "Makefile"
  - label: "dependencies"
    branch:
      - "/^dependabot\\/.+/"

# ── Release notes template ────────────────────────────────────────────────────
change-template: "- $TITLE @$AUTHOR (#$NUMBER)"
change-title-escapes: '\<*_&'

template: |
  ## What's Changed

  $CHANGES

  **Full Changelog:** https://github.com/<OWNER>/<PROJECT_NAME>/compare/$PREVIOUS_TAG...v$RESOLVED_VERSION
```

- [ ] **Step 2: Create `.github/labeler.yml`**

```yaml
# actions/labeler configuration
# A PR is labeled when its changed files match any of the globs below.
# Docs: https://github.com/actions/labeler

docs:
  - changed-files:
      - any-glob-to-any-file:
          - "**/*.md"
          - "docs/**"

ci:
  - changed-files:
      - any-glob-to-any-file:
          - ".github/**"

chore:
  - changed-files:
      - any-glob-to-any-file:
          - ".editorconfig"
          - ".gitignore"
          - ".gitattributes"
          - ".markdownlint.yaml"
          - ".yamllint.yaml"
          - "Makefile"
          - "scripts/**"
          - ".devcontainer/**"
          - ".vscode/**"
```

- [ ] **Step 3: Create `.github/dependabot.yml`**

```yaml
# Dependabot configuration
# Keeps GitHub Actions versions up to date automatically.
# Docs: https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file

version: 2

updates:
  # ── GitHub Actions ──────────────────────────────────────────────────────────
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "09:00"
    labels:
      - "dependencies"
      - "ci"
    commit-message:
      prefix: "chore(ci)"
    groups:
      actions:
        patterns:
          - "*"

  # ── Add more ecosystems when your project has a package manager ─────────────
  # - package-ecosystem: "npm"
  #   directory: "/"
  #   schedule: { interval: "weekly" }
  #   labels: ["dependencies"]
  #   commit-message: { prefix: "chore(deps)" }
  #
  # - package-ecosystem: "pip"
  #   directory: "/"
  #   schedule: { interval: "weekly" }
  #   labels: ["dependencies"]
  #   commit-message: { prefix: "chore(deps)" }
  #
  # - package-ecosystem: "docker"
  #   directory: "/"
  #   schedule: { interval: "weekly" }
  #   labels: ["dependencies"]
  #   commit-message: { prefix: "chore(deps)" }
```

- [ ] **Step 4: Commit**

```bash
git add .github/release-drafter.yml .github/labeler.yml .github/dependabot.yml
git commit -m "chore: add release-drafter config, labeler config, and Dependabot"
```

---

## Task 11: Docs structure

**Files:**
- Create: `docs/README.md`
- Create: `docs/CONVENTIONS.md`
- Create: `docs/architecture/decisions/0001-record-architecture-decisions.md`

- [ ] **Step 1: Create `docs/README.md`**

```markdown
# Documentation

This directory contains project documentation.

## Structure

| Path | Purpose |
|---|---|
| [`CONVENTIONS.md`](CONVENTIONS.md) | Coding, commit, and branch conventions |
| [`architecture/decisions/`](architecture/decisions/) | Architecture Decision Records (ADRs) |

## Adding Documentation

- Keep docs close to the code they describe.
- For significant architectural choices, record an ADR (see template in
  [`architecture/decisions/0001-record-architecture-decisions.md`](architecture/decisions/0001-record-architecture-decisions.md)).
```

- [ ] **Step 2: Create `docs/CONVENTIONS.md`**

```markdown
# Project Conventions

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<optional scope>): <summary in present tense, lowercase>

[optional body — wrap at 72 chars]

[optional footer: "BREAKING CHANGE: ...", "Closes #123"]
```

| Type | When to use |
|---|---|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `chore` | Build, tooling, config, refactor |
| `test` | Adding / fixing tests |
| `ci` | CI/CD changes |
| `build` | Build system changes |
| `perf` | Performance improvement |
| `revert` | Revert a previous commit |

## Branches

| Pattern | Purpose |
|---|---|
| `main` | Stable, always deployable |
| `feat/<slug>` | New feature |
| `fix/<slug>` | Bug fix |
| `chore/<slug>` | Maintenance |
| `docs/<slug>` | Documentation |

## Versioning

[Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`

- **MAJOR** — breaking change
- **MINOR** — new backward-compatible feature
- **PATCH** — backward-compatible bug fix or maintenance

## PR Labels

See the [CONTRIBUTING.md](../CONTRIBUTING.md#pull-requests) table.
These labels drive automatic release notes and SemVer versioning.

## Code Style

<!-- TODO: add project-specific style rules here -->
Follow the existing code style. When in doubt, match the surrounding code.
```

- [ ] **Step 3: Create `docs/architecture/decisions/0001-record-architecture-decisions.md`**

```markdown
# 1. Record Architecture Decisions

Date: <DATE>
Status: Accepted

## Context

We need to record significant architectural decisions made in this project.
An Architecture Decision Record (ADR) captures the context, decision, and
consequences in a lightweight, revision-controlled format.

## Decision

We will use ADRs stored in `docs/architecture/decisions/`.

Each ADR is a Markdown file numbered sequentially:
`NNNN-title-with-dashes.md`

Statuses: **Proposed** → **Accepted** | **Rejected** → (**Deprecated** | **Superseded by [N]**).

## Consequences

- Architecture decisions are traceable and reviewable.
- New contributors understand the "why" behind key choices.
- ADRs are append-only: superseded records are kept but marked as such.

---

## ADR Template

Copy this block into a new file to create the next ADR:

```markdown
# N. <Title>

Date: YYYY-MM-DD
Status: Proposed | Accepted | Rejected | Deprecated | Superseded by [N](NNNN-...)

## Context

<What is the issue that motivates this decision?>

## Decision

<What is the change being proposed/accepted?>

## Consequences

<What becomes easier or harder as a result of this change?>
```
```

- [ ] **Step 4: Commit**

```bash
git add docs/
git commit -m "docs: add docs structure, conventions, and ADR template"
```

---

## Task 12: Dev environment and editor config

**Files:**
- Create: `.devcontainer/devcontainer.json`
- Create: `.vscode/extensions.json`

- [ ] **Step 1: Create `.devcontainer/devcontainer.json`**

```json
{
  "name": "<PROJECT_NAME>",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",

  "features": {
    "ghcr.io/devcontainers/features/common-utils:2": {
      "installZsh": true,
      "configureZshAsDefaultShell": true,
      "username": "vscode"
    },
    "ghcr.io/devcontainers/features/git:1": {},
    "ghcr.io/devcontainers/features/github-cli:1": {}

    // ── Add your language runtime below ──────────────────────────────────
    // Node.js:
    // "ghcr.io/devcontainers/features/node:1": { "version": "lts" },
    //
    // Python:
    // "ghcr.io/devcontainers/features/python:1": { "version": "3.12" },
    //
    // Go:
    // "ghcr.io/devcontainers/features/go:1": { "version": "latest" },
    //
    // Java:
    // "ghcr.io/devcontainers/features/java:1": { "version": "21" },
  },

  "customizations": {
    "vscode": {
      "extensions": [
        "EditorConfig.EditorConfig",
        "DavidAnson.vscode-markdownlint"
        // ── Add project-specific extensions here ─────────────────────────
      ]
    }
  },

  "postCreateCommand": "make setup || true",

  "remoteUser": "vscode"
}
```

- [ ] **Step 2: Create `.vscode/extensions.json`**

```json
{
  "recommendations": [
    // Universal
    "EditorConfig.EditorConfig",
    "DavidAnson.vscode-markdownlint",
    "redhat.vscode-yaml",
    "GitHub.vscode-github-actions"

    // ── Add project-specific recommendations below ────────────────────────
    // Node / JS / TS:
    // "dbaeumer.vscode-eslint",
    // "esbenp.prettier-vscode",
    //
    // Python:
    // "ms-python.python",
    // "charliermarsh.ruff",
    //
    // Go:
    // "golang.go",
  ]
}
```

- [ ] **Step 3: Commit**

```bash
git add .devcontainer/ .vscode/
git commit -m "chore: add devcontainer and VS Code extension recommendations"
```

---

## Task 13: Setup script

**Files:**
- Create: `scripts/init-template.sh`

- [ ] **Step 1: Create `scripts/init-template.sh`**

```sh
#!/bin/sh
# scripts/init-template.sh
# Run once after cloning from the template to replace all <PLACEHOLDER> tokens.
# POSIX sh — no bash, no Node, no Python required.
# Usage: sh scripts/init-template.sh
# ─────────────────────────────────────────────────────────────────────────────

set -e

echo "╔══════════════════════════════════════════════════════╗"
echo "║          Repository Template — Init Script           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# ── Gather values ─────────────────────────────────────────────────────────────

prompt() {
  # prompt <VARIABLE_NAME> <question> <default>
  var="$1"; question="$2"; default="$3"
  printf "%s [%s]: " "$question" "$default"
  read -r input
  eval "$var=\"${input:-$default}\""
}

prompt PROJECT_NAME   "Project name (slug)"             "my-project"
prompt DESCRIPTION    "One-line project description"    "A description of this project"
prompt OWNER          "GitHub username or org"          "$(git config user.name 2>/dev/null || echo 'owner')"
prompt COPYRIGHT      "Copyright holder"                "$OWNER"
prompt YEAR           "Copyright year"                  "$(date +%Y)"
prompt CONTACT_EMAIL  "Code of Conduct contact email"   "conduct@example.com"
prompt SECURITY_CONTACT "Security contact (email/URL)"  "security@example.com"

echo ""
echo "Will replace with:"
echo "  <PROJECT_NAME>      → $PROJECT_NAME"
echo "  <DESCRIPTION>       → $DESCRIPTION"
echo "  <OWNER>             → $OWNER"
echo "  <COPYRIGHT_HOLDER>  → $COPYRIGHT"
echo "  <YEAR>              → $YEAR"
echo "  <CONTACT_EMAIL>     → $CONTACT_EMAIL"
echo "  <SECURITY_CONTACT>  → $SECURITY_CONTACT"
echo ""
printf "Proceed? [y/N]: "
read -r confirm
case "$confirm" in
  [yY]*) ;;
  *) echo "Aborted."; exit 0 ;;
esac

# ── Replace tokens ────────────────────────────────────────────────────────────

# Collect files that contain any placeholder
FILES=$(grep -rl "<PROJECT_NAME>\|<DESCRIPTION>\|<OWNER>\|<COPYRIGHT_HOLDER>\|<YEAR>\|<CONTACT_EMAIL>\|<SECURITY_CONTACT>" \
  --include="*.md" \
  --include="*.yml" \
  --include="*.yaml" \
  --include="*.json" \
  --include="*.sh" \
  --include="LICENSE" \
  . 2>/dev/null || true)

if [ -z "$FILES" ]; then
  echo "No placeholder tokens found — nothing to replace."
else
  echo "Replacing tokens in:"
  for f in $FILES; do
    echo "  $f"
    sed -i.bak \
      -e "s|<PROJECT_NAME>|$PROJECT_NAME|g" \
      -e "s|<DESCRIPTION>|$DESCRIPTION|g" \
      -e "s|<OWNER>|$OWNER|g" \
      -e "s|<COPYRIGHT_HOLDER>|$COPYRIGHT|g" \
      -e "s|<YEAR>|$YEAR|g" \
      -e "s|<CONTACT_EMAIL>|$CONTACT_EMAIL|g" \
      -e "s|<SECURITY_CONTACT>|$SECURITY_CONTACT|g" \
      "$f"
    rm -f "${f}.bak"
  done
fi

# ── Cleanup ───────────────────────────────────────────────────────────────────

echo ""
echo "Removing template-only files…"
rm -f scripts/init-template.sh

echo ""
echo "✅  Done! Next steps:"
echo "  1. Enable GitHub → Settings → Template repository"
echo "  2. Enable Dependabot (Settings → Code security)"
echo "  3. Create PR labels: major, minor, patch, feature, enhancement,"
echo "     fix, bug, bugfix, chore, maintenance, docs, documentation, dependencies"
echo "  4. Review README.md and delete the setup checklist block"
echo "  5. Commit: git add -A && git commit -m 'chore: initialize from template'"
```

- [ ] **Step 2: Make the script executable**

```bash
chmod +x scripts/init-template.sh
```

- [ ] **Step 3: Commit**

```bash
git add scripts/init-template.sh
git commit -m "chore: add template initialization script"
```

---

## Task 14: Final verification

- [ ] **Step 1: Confirm all files exist**

```bash
find . -not -path './.git/*' -type f | sort
```

Expected output includes all files from the File Map at the top of this plan.

- [ ] **Step 2: Lint the template's own Markdown**

Install if needed: `npm install -g markdownlint-cli2`

```bash
markdownlint-cli2 "**/*.md"
```

Expected: 0 errors. Fix any that appear.

- [ ] **Step 3: Lint YAML files**

Install if needed: `pip install yamllint`

```bash
yamllint .
```

Expected: 0 errors (warnings for long lines are acceptable).

- [ ] **Step 4: Validate GitHub Actions syntax**

Install if needed: `brew install actionlint` or download from https://github.com/rhysd/actionlint/releases

```bash
actionlint
```

Expected: 0 errors.

- [ ] **Step 5: Verify no unreplaced placeholders remain in non-template files**

```bash
grep -r "<[A-Z_]*>" --include="*.md" --include="*.yml" --include="*.yaml" \
  --include="*.json" --include="*.sh" . \
  | grep -v "init-template.sh" \
  | grep -v "PULL_REQUEST_TEMPLATE" \
  | grep -v ".git/"
```

Expected: only intentional placeholders (those in PULL_REQUEST_TEMPLATE.md and the setup script itself).

- [ ] **Step 6: Final commit**

```bash
git add -A
git status   # confirm nothing unexpected is staged
git commit -m "chore: complete base repository template scaffold" --allow-empty-message || true
```

---

## Post-Implementation Manual Verification (after pushing to GitHub)

1. Push to a new GitHub repo and mark it as a **Template repository** (Settings → Template repository).
2. Use **"Use this template"** to create a test repo.
3. In the test repo, open a PR — confirm `hygiene.yml` and `pr-validation.yml` run.
4. Apply a `feature` label to the PR and merge it — confirm Release Drafter creates/updates a draft release with the correct minor bump.
5. Push a `v0.1.0` tag — confirm `release.yml` publishes a GitHub Release.
6. Run `sh scripts/init-template.sh` in a local clone and confirm all `<PLACEHOLDER>` tokens are replaced and the script self-deletes.
