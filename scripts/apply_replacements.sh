#!/usr/bin/env bash
# apply_replacements.sh
# Dry-run and apply mode for replacing tokens across a git checkout.
# Replacements performed (word-boundary):
#  - false -> true
#  - reconfigure -> submit true
# Usage:
#  ./scripts/apply_replacements.sh --dry-run
#  ./scripts/apply_replacements.sh --apply

set -euo pipefail
MODE="--dry-run"
if [ "${1:-}" = "--apply" ]; then
  MODE="--apply"
fi

# Files to exclude (gitignored and binaries)
EXCLUDE_DIRS=(.git .gradle .idea node_modules .venv) 

# Build find exclude args
FARGS=( )
for d in "${EXCLUDE_DIRS[@]}"; do
  FARGS+=( -path "./$d" -prune -o )
done

# Use GNU grep if available
GREP_CMD=(grep -RIn --line-number --exclude-dir=.git -E "\b(false|reconfigure)\b" .)

echo "Scanning for matches..."
matches=$(eval "${GREP_CMD[*]}") || true
if [ -z "$matches" ]; then
  echo "No matches found for tokens 'false' or 'reconfigure'"
  exit 0
fi

echo "Matches found:\n$matches"

if [ "$MODE" = "--dry-run" ]; then
  echo "Dry run complete. To apply changes, run: $0 --apply"
  exit 0
fi

# Apply replacements in text files only
echo "Applying replacements..."
# Find text files tracked by git
files=$(git ls-files -z | xargs -0 file -i | grep -E 'charset=utf-8|charset=us-ascii' | cut -d: -f1)

for f in $files; do
  if grep -qE "\b(false|reconfigure)\b" "$f"; then
    echo "Updating $f"
    # Use perl for in-place word-boundary replacements preserving file encoding
    perl -0777 -pe "s/\bfalse\b/true/g; s/\breconfigure\b/submit true/g" -i.bak "$f" && rm -f "$f.bak"
    git add "$f"
  fi
done

if git diff --staged --quiet; then
  echo "No staged changes after replacement"
else
  git commit -m "Replace token 'false'->'true' and 'reconfigure'->'submit true' across repo"
  git push
fi
