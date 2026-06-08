#!/bin/sh
# Usage: sh scripts/init-project.sh
set -e

echo "Repository Template — Init"
echo "==========================="
echo "Replaces all <PLACEHOLDER> tokens. Press Ctrl+C to cancel."
echo ""

prompt() {
  printf "%s [%s]: " "$1" "$2"
  read -r val
  printf '%s' "${val:-$2}"
}

PROJECT_NAME=$(prompt "Project name"        "my-project")
DESCRIPTION=$(prompt  "One-line description" "A short description of this project")
OWNER=$(prompt        "GitHub username/org"  "$(git config user.name 2>/dev/null || echo 'your-username')")
COPYRIGHT=$(prompt    "Copyright holder"     "$OWNER")
YEAR=$(date +%Y)
CONTACT_EMAIL=$(prompt   "Code of Conduct email" "conduct@example.com")
SECURITY_CONTACT=$(prompt "Security contact"      "security@example.com")

echo ""
echo "  <PROJECT_NAME>     → $PROJECT_NAME"
echo "  <DESCRIPTION>      → $DESCRIPTION"
echo "  <OWNER>            → $OWNER"
echo "  <COPYRIGHT_HOLDER> → $COPYRIGHT"
echo "  <YEAR>             → $YEAR"
echo "  <CONTACT_EMAIL>    → $CONTACT_EMAIL"
echo "  <SECURITY_CONTACT> → $SECURITY_CONTACT"
echo ""
printf "Proceed? (y/N): "
read -r confirm
[ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || { echo "Cancelled."; exit 0; }

echo ""
find . -type f \( -name "*.md" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" -o -name "*.sh" -o -name "LICENSE" \) \
  | grep -v ".git/" | grep -v "node_modules/" \
  | while read -r file; do
      if grep -q "<PROJECT_NAME>\|<DESCRIPTION>\|<OWNER>\|<COPYRIGHT_HOLDER>\|<YEAR>\|<CONTACT_EMAIL>\|<SECURITY_CONTACT>" "$file" 2>/dev/null; then
        echo "  updating $file"
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

rm -f scripts/init-project.sh
rmdir scripts 2>/dev/null || true

echo ""
echo "Done. Next steps:"
echo "  git add -A && git commit -m 'chore: initialize from template'"
echo "  git push"
