#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORLD_DIR="$ROOT_DIR/STAR WARS Path of the Jedi by sneyp"
BP_DIR="$WORLD_DIR/behavior_packs/bp0"
RP_DIR="$WORLD_DIR/resource_packs/rp0"
OUT_DIR="$ROOT_DIR/dist"
TMP_DIR="$ROOT_DIR/.tmp_addon_pack"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

for required in "$BP_DIR/manifest.json" "$RP_DIR/manifest.json"; do
  if [[ ! -f "$required" ]]; then
    echo "Missing required file: $required" >&2
    exit 1
  fi
done

mkdir -p "$OUT_DIR"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

read_json_name() {
  python - "$1" <<'PY'
import json,sys
with open(sys.argv[1], 'r', encoding='utf-8') as f:
    data=json.load(f)
print(data['header']['name'])
PY
}

BP_NAME="$(read_json_name "$BP_DIR/manifest.json")"
RP_NAME="$(read_json_name "$RP_DIR/manifest.json")"

BP_PACK="$OUT_DIR/${BP_NAME// /_}.mcpack"
RP_PACK="$OUT_DIR/${RP_NAME// /_}.mcpack"
ADDON_PACK="$OUT_DIR/MyJediAddon.mcaddon"

if [[ "$DRY_RUN" == true ]]; then
  echo "[DRY-RUN] Would package:"
  echo "  BP source: $BP_DIR -> $BP_PACK"
  echo "  RP source: $RP_DIR -> $RP_PACK"
  echo "  Combined addon -> $ADDON_PACK"
  exit 0
fi

(
  cd "$BP_DIR"
  zip -qr "$BP_PACK" .
)
(
  cd "$RP_DIR"
  zip -qr "$RP_PACK" .
)

cp "$BP_PACK" "$TMP_DIR/"
cp "$RP_PACK" "$TMP_DIR/"
(
  cd "$TMP_DIR"
  zip -qr "$ADDON_PACK" ./*.mcpack
)

rm -rf "$TMP_DIR"

echo "Created:"
echo "  $BP_PACK"
echo "  $RP_PACK"
echo "  $ADDON_PACK"
