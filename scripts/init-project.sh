#!/bin/sh
# Usage: sh scripts/init-project.sh
set -e

echo ""
echo "Initialize project from template"
echo "---------------------------------"
echo "Fills in your project details across all template files."
echo "Press Ctrl+C to cancel."
echo ""

ask() {
  if [ -n "$2" ]; then
    printf "%s [%s]: " "$1" "$2" >&2
  else
    printf "%s: " "$1" >&2
  fi
  read -r val
  printf '%s' "${val:-$2}"
}

_github_username() {
  git remote get-url origin 2>/dev/null \
    | sed 's|.*github\.com[:/]\([^/]*\).*|\1|' \
    | grep -v "github\.com" \
    || echo "your-username"
}

PROJECT_NAME=$(ask    "Project name"                    "my-project")
DESCRIPTION=$(ask     "Short description"               "")
OWNER=$(ask           "GitHub username or organization" "$(_github_username)")
COPYRIGHT=$(ask       "Copyright holder"                "your-name")
YEAR=$(date +%Y)
CONTACT_EMAIL=$(ask   "Code of Conduct email"           "conduct@example.com")
SECURITY_CONTACT=$(ask "Security contact email"         "security@example.com")

echo ""
printf "  %-20s : %s\n" "Project name"     "$PROJECT_NAME"
printf "  %-20s : %s\n" "Description"      "$DESCRIPTION"
printf "  %-20s : %s\n" "GitHub owner"     "$OWNER"
printf "  %-20s : %s\n" "Copyright holder" "$COPYRIGHT"
printf "  %-20s : %s\n" "Year"             "$YEAR"
printf "  %-20s : %s\n" "CoC email"        "$CONTACT_EMAIL"
printf "  %-20s : %s\n" "Security email"   "$SECURITY_CONTACT"
echo ""
printf "Apply these changes? [y/N]: "
read -r confirm
[ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || { echo "Cancelled."; exit 0; }

echo ""
find . -type f \( -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" -o -name "*.sh" -o -name "LICENSE" \) \
  | grep -v ".git/" | grep -v "node_modules/" \
  | while read -r file; do
      if grep -q "<PROJECT_NAME>\|<DESCRIPTION>\|<OWNER>\|<COPYRIGHT_HOLDER>\|<YEAR>\|<CONTACT_EMAIL>\|<SECURITY_CONTACT>" "$file" 2>/dev/null; then
        echo "  updated $file"
        sed -i.bak \
          -e "s|<PROJECT_NAME>|$PROJECT_NAME|g" \
          -e "s|<DESCRIPTION>|$DESCRIPTION|g" \
          -e "s|<OWNER>|$OWNER|g" \
          -e "s|<COPYRIGHT_HOLDER>|$COPYRIGHT|g" \
          -e "s|<YEAR>|$YEAR|g" \
          -e "s|<CONTACT_EMAIL>|$CONTACT_EMAIL|g" \
          -e "s|<SECURITY_CONTACT>|$SECURITY_CONTACT|g" \
          "$file"
        rm -f "$file.bak"
      fi
    done

# Reset release-please files so the new project starts from a clean slate,
# not from whatever version/changelog the template repo has accumulated.
printf '{\n  ".": "0.0.0"\n}\n' > .release-please-manifest.json
echo "  reset .release-please-manifest.json → 0.0.0"

cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Fixed

### Removed
EOF
echo "  reset CHANGELOG.md"

rm -f scripts/init-project.sh
rmdir scripts 2>/dev/null || true
rm -f Makefile
rm -f README.md
rm -f .gitignore
rm -f index.html
rm -f favicon.svg

# Detach from template history
rm -rf .git

# Rename the project directory to the project name
CURRENT_DIR="$(pwd)"
PARENT_DIR="$(dirname "$CURRENT_DIR")"
NEW_DIR="$PARENT_DIR/$PROJECT_NAME"
if [ "$CURRENT_DIR" != "$NEW_DIR" ]; then
  mv "$CURRENT_DIR" "$NEW_DIR"
  echo "  renamed directory → $PROJECT_NAME"
fi

echo ""
echo "Done. Add your own README.md and .gitignore, then:"
echo ""
echo "  cd ../$PROJECT_NAME"
echo "  git init && git add -A && git commit -m 'chore: initialize project'"
echo ""
