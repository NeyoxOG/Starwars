#!/usr/bin/env python3
import json
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FILES = [
    ROOT / "STAR WARS Path of the Jedi by sneyp/behavior_packs/bp0/manifest.json",
    ROOT / "STAR WARS Path of the Jedi by sneyp/resource_packs/rp0/manifest.json",
]

for file_path in FILES:
    data = json.loads(file_path.read_text(encoding="utf-8"))
    data["header"]["uuid"] = str(uuid.uuid4())
    for module in data.get("modules", []):
        module["uuid"] = str(uuid.uuid4())
    file_path.write_text(json.dumps(data, separators=(",", ":")), encoding="utf-8")
    print(f"Updated UUIDs in {file_path}")
