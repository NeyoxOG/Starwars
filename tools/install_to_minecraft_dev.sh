#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORLD_DIR="$ROOT_DIR/STAR WARS Path of the Jedi by sneyp"
BP_SRC="$WORLD_DIR/behavior_packs/bp0"
RP_SRC="$WORLD_DIR/resource_packs/rp0"

MINECRAFT_DIR="${LOCALAPPDATA:-}/Packages/Microsoft.MinecraftUWP_8wekyb3d8bbwe/LocalState/games/com.mojang"
BP_DST="$MINECRAFT_DIR/development_behavior_packs/MyJediAddon_BP"
RP_DST="$MINECRAFT_DIR/development_resource_packs/MyJediAddon_RP"

if [[ -z "${LOCALAPPDATA:-}" ]]; then
  echo "LOCALAPPDATA is not set. This installer is for Windows Bedrock dev folders." >&2
  exit 1
fi

mkdir -p "$(dirname "$BP_DST")" "$(dirname "$RP_DST")"
rm -rf "$BP_DST" "$RP_DST"
cp -R "$BP_SRC" "$BP_DST"
cp -R "$RP_SRC" "$RP_DST"

echo "Installed dev packs:"
echo "  $BP_DST"
echo "  $RP_DST"
