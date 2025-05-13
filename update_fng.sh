#!/usr/bin/env bash
# update_fng.sh — télécharge le CSV et le met dans data/fng.csv

set -e

API_URL="https://api.alternative.me/fng/?limit=365&format=csv&date_format=us"
OUTPUT_DIR="data"
OUTPUT_FILE="$OUTPUT_DIR/fng.csv"

mkdir -p "$OUTPUT_DIR"
curl -s "$API_URL" -o "$OUTPUT_FILE"

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

git add "$OUTPUT_FILE"
# Si rien n’a changé, on sort sans erreur
if git diff --cached --quiet; then
  echo "Aucune mise à jour du CSV."
  exit 0
fi

git commit -m "chore(data): mise à jour F&G $(date +'%Y-%m-%d')"
git push origin HEAD:main
