#!/bin/sh
# scripts/init-template.sh
#
# Run this script once after cloning from the template to fill in all placeholders.
# Usage: sh scripts/init-template.sh
#
# This script works on any system with /bin/sh — no Node, Python, or Bash required.

set -e  # Stop immediately if any command fails

echo ""
echo "Repository Template — Setup"
echo "==========================="
echo ""
echo "This script will replace all <PLACEHOLDER> tokens in this repo."
echo "Press Ctrl+C at any time to cancel."
echo ""

# ── Ask for values ────────────────────────────────────────────────────────────

# Helper: ask a question and use a default if the user just presses Enter
ask() {
  variable_name="$1"
  question="$2"
  default="$3"

  printf "%s (default: %s): " "$question" "$default"
  read -r answer

  # Use the default if the user pressed Enter without typing anything
  if [ -z "$answer" ]; then
    answer="$default"
  fi

  # Store the answer in the variable
  eval "$variable_name=\"\$answer\""
}

ask PROJECT_NAME    "Project name (e.g. my-awesome-app)"  "my-project"
ask DESCRIPTION     "One-line description"                 "A short description of this project"
ask OWNER           "GitHub username or org"               "$(git config user.name 2>/dev/null || echo 'your-username')"
ask COPYRIGHT       "Copyright holder (name or org)"       "$OWNER"
ask YEAR            "Copyright year"                       "$(date +%Y)"
ask CONTACT_EMAIL   "Code of Conduct contact email"        "conduct@example.com"
ask SECURITY_CONTACT "Security contact (email or URL)"     "security@example.com"

echo ""
echo "About to replace:"
echo "  <PROJECT_NAME>      → $PROJECT_NAME"
echo "  <DESCRIPTION>       → $DESCRIPTION"
echo "  <OWNER>             → $OWNER"
echo "  <COPYRIGHT_HOLDER>  → $COPYRIGHT"
echo "  <YEAR>              → $YEAR"
echo "  <CONTACT_EMAIL>     → $CONTACT_EMAIL"
echo "  <SECURITY_CONTACT>  → $SECURITY_CONTACT"
echo ""
printf "Looks good? (y/N): "
read -r confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
  echo "Cancelled. No changes made."
  exit 0
fi

# ── Replace placeholders in files ─────────────────────────────────────────────

echo ""
echo "Replacing placeholders..."

# Find all relevant text files that contain at least one placeholder
files=$(find . -type f \( \
  -name "*.md" \
  -o -name "*.yml" \
  -o -name "*.yaml" \
  -o -name "*.json" \
  -o -name "*.sh" \
  -o -name "LICENSE" \
\) | grep -v ".git/" | grep -v "node_modules/")

for file in $files; do
  # Check if this file has any placeholder before running sed
  if grep -q "<PROJECT_NAME>\|<DESCRIPTION>\|<OWNER>\|<COPYRIGHT_HOLDER>\|<YEAR>\|<CONTACT_EMAIL>\|<SECURITY_CONTACT>" "$file" 2>/dev/null; then
    echo "  Updating: $file"
    sed -i.bak \
      -e "s|<PROJECT_NAME>|$PROJECT_NAME|g" \
      -e "s|<DESCRIPTION>|$DESCRIPTION|g" \
      -e "s|<OWNER>|$OWNER|g" \
      -e "s|<COPYRIGHT_HOLDER>|$COPYRIGHT|g" \
      -e "s|<YEAR>|$YEAR|g" \
      -e "s|<CONTACT_EMAIL>|$CONTACT_EMAIL|g" \
      -e "s|<SECURITY_CONTACT>|$SECURITY_CONTACT|g" \
      "$file"
    # Remove the backup file that sed creates
    rm -f "$file.bak"
  fi
done

# ── Clean up template-only files ──────────────────────────────────────────────

echo ""
echo "Removing template setup files..."
rm -f scripts/init-template.sh

# Remove the scripts directory if it's now empty
rmdir scripts 2>/dev/null || true

echo ""
echo "Done! Next steps:"
echo ""
echo "  1. Review the changes: git diff"
echo "  2. Commit everything:  git add -A && git commit -m 'chore: initialize from template'"
echo "  3. Push to GitHub:     git push"
echo ""
echo "  Then on GitHub:"
echo "  4. Go to Settings → check 'Template repository'"
echo "  5. Go to Settings → Code security → enable Dependabot"
echo "  6. Go to Issues → Labels → create these labels:"
echo "     feature, enhancement, fix, bug, bugfix, chore, maintenance,"
echo "     docs, documentation, major, minor, patch, dependencies"
echo ""
