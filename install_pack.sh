#!/usr/bin/env bash
set -euo pipefail

GAME_DIR=""
OUTPUT="mods"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --game-dir) GAME_DIR="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

command -v curl >/dev/null || { echo "curl is required" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

API="https://api.modrinth.com/v2"
MC_VERSION=$(jq -r '.minecraft' pack.json)
LOADER=$(jq -r '.loader' pack.json)
TARGET="$OUTPUT"
[[ -n "$GAME_DIR" ]] && TARGET="$GAME_DIR/mods"
mkdir -p "$TARGET"
failed=0

while IFS= read -r project; do
  encoded_version=$(jq -rn --arg value "$MC_VERSION" '[$value] | @uri')
  encoded_loader=$(jq -rn --arg value "$LOADER" '[$value] | @uri')
  url="$API/project/$project/version?game_versions=$encoded_version&loaders=$encoded_loader&limit=1"
  version=$(curl -fsSL -A "reinos-desempenho-pack/1.0" "$url") || { echo "$project: request failed" >&2; failed=1; continue; }
  file=$(jq -c '.[0].files | (map(select(.primary == true)) + .) | .[0] // empty' <<< "$version")
  if [[ -z "$file" || "$file" == "null" ]]; then echo "$project: no compatible release" >&2; failed=1; continue; fi
  filename=$(jq -r '.filename' <<< "$file")
  download_url=$(jq -r '.url' <<< "$file")
  version_number=$(jq -r '.[0].version_number' <<< "$version")
  echo "Downloading $project $version_number -> $filename"
  curl -fL -A "reinos-desempenho-pack/1.0" "$download_url" -o "$TARGET/$filename" || failed=1
done < <(jq -r '.projects[]' pack.json)

if [[ "$failed" -ne 0 ]]; then
  echo "Some projects could not be installed." >&2
  exit 1
fi
echo "Installed mods into $TARGET"
