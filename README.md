# STAR WARS: Path of the Jedi – Addon verstehen & modden

Dieses Repository enthält **eine Minecraft Bedrock Weltvorlage** mit einem Behavior Pack (`bp0`) und einem Resource Pack (`rp0`).

## 1) Wie das Addon technisch aufgebaut ist

- Die Welt selbst liegt in `STAR WARS Path of the Jedi by sneyp/`.
- Über `world_behavior_packs.json` und `world_resource_packs.json` wird jeweils genau ein Pack eingebunden.
- Das Behavior Pack (`behavior_packs/bp0`) enthält:
  - klassische `.mcfunction`-Logik (Scoreboards, Teleports, Quest-Fortschritt),
  - JavaScript-Logik über Bedrock Script API (`scripts/main.js` als Einstieg).

### Zentrale Steuerung

- Der Tick-Loop der Functions startet über `functions/tick.json` mit `spark/loop`.
- `spark/loop.mcfunction` ruft pro Tick diverse Systeme auf (Tutorial, Dueling, Force, Companion usw.).
- Parallel läuft Script-Logik aus `scripts/main.js`, die weitere Systeme pro Tick aktualisiert.

Kurz gesagt: **Funktionen + Skripte zusammen** bilden die komplette Spielmechanik.

---

## 2) Nützliche Commands für „freie Nutzung“ (Admin/Operator)

Wenn du die Karte freier erkunden oder testen willst, sind diese Befehle die wichtigsten:

### Setup / Reset

- `/function spark/setup`
  Setzt Gamerules, Scoreboards und zentrale Systeme.
- `/function spark/reset`
  Setzt Tutorial-Zustände zurück und teleportiert zum Start.

### Schnellreisen (Warp)

Du kannst direkt zu Bereichen springen:

- `/function warp/main_hall`
- `/function warp/dojo`
- `/function warp/council`
- `/function warp/ilum`
- `/function warp/kamino`
- `/function warp/archives`
- `/function warp/felucia`
- `/function warp/tatooine`
- `/function warp/naboo`
- `/function warp/torren`
- `/function warp/crucible`
- `/function warp/hangar`

(Tipp: Alle Warp-Funktionen liegen unter `functions/warp/*.mcfunction`.)

### Fortschritt manuell steuern (Tutorial)

Das Tutorial nutzt hauptsächlich den Scoreboard-Wert `.state` im Objective `tutorial`.

- Status anzeigen:
  `/scoreboard players get .state tutorial`
- Kapitel direkt setzen (Beispiel Kapitel 3):
  `/scoreboard players set .state tutorial 3`
- Nächstes Kapitel triggern:
  `/function spark/tutorial/next_chapter`

Wenn etwas „hängt“, hilft oft:

1. `/function spark/setup`
2. `/scoreboard players set .state tutorial <wert>`
3. passender Warp-Befehl in die Zone

---

## 3) So kannst du es später sauber ummodden

## Schritt A: Eigene Testwelt statt Original

- Kopiere die Welt/Pack-Struktur in eine separate Testkopie.
- Arbeite nie direkt auf der einzigen Originalversion.

## Schritt B: Kleine, kontrollierte Änderungen

Gute erste Änderungen:

1. In `functions/warp/*.mcfunction` Teleport-Koordinaten ändern.
2. In `spark/tutorial/next_chapter.mcfunction` oder `spark/tutorial/loop.mcfunction` Übergänge testen.
3. In `spark/setup.mcfunction` Gamerules für dein Sandbox-Setup anpassen.

## Schritt C: Story-Sperren lockern (ohne alles zu zerstören)

Statt große Dateien sofort umzubauen:

- erst mit Commands Zustand setzen (Scoreboards),
- dann minimale Function-Patches machen,
- danach Ingame testen, ob Cutscenes/NPCs noch korrekt laufen.

## Schritt D: Eigene „Admin-Utilities“ hinzufügen

Lege z. B. neue Dateien an wie:

- `functions/custom/admin_unlock.mcfunction`
- `functions/custom/admin_skip_to_end.mcfunction`

und rufe sie mit `/function custom/admin_unlock` auf.

So bleibt die Original-Logik weitgehend unberührt und Updates sind einfacher.

---

## 4) Praktischer Start-Workflow (empfohlen)

Wenn du die Welt startest und schnell frei testen willst:

1. `/function spark/setup`
2. `/function spark/reset`
3. `/function warp/main_hall`
4. Bei Bedarf Kapitel setzen: `/scoreboard players set .state tutorial 4`
5. Falls nötig: `/function spark/tutorial/next_chapter`

---

## 5) Nächster Schritt

Wenn du willst, kann ich dir als Nächstes ein **konkretes Modding-Paket** bauen mit:

- einer fertigen `functions/custom/`-Struktur,
- fertigen Admin-Commands (unlock, skip, teleport hub, debug clean),
- einer kleinen „Cheat-Konsole per Function“-Routine,
- und einer sicheren Reihenfolge, damit die Story-Trigger nicht kaputtgehen.


## 6) Bereits umgesetzt: `functions/custom/*`

Folgende Dateien sind jetzt im Pack vorhanden:

- `behavior_packs/bp0/functions/custom/help.mcfunction`
- `behavior_packs/bp0/functions/custom/free_mode_on.mcfunction`
- `behavior_packs/bp0/functions/custom/free_mode_off.mcfunction`
- `behavior_packs/bp0/functions/custom/give_starter.mcfunction`
- `behavior_packs/bp0/functions/custom/warp_hub.mcfunction`
- `behavior_packs/bp0/functions/custom/skip_to_chapter4.mcfunction`

### Direkt nutzbare Befehle im Spiel

- `/function custom/help`
- `/function custom/free_mode_on`
- `/function custom/free_mode_off`
- `/function custom/give_starter`
- `/function custom/warp_hub`
- `/function custom/skip_to_chapter4`

## 7) Nächster Umsetzungsschritt erledigt: Eigene Manifest-Identität

Damit das Paket als **eigenes normales Addon** unabhängig vom Original geladen werden kann, wurden die beiden Manifest-Dateien bereits angepasst:

- `behavior_packs/bp0/manifest.json`
  - Name: `My Jedi Addon BP`
  - neue Header-UUID
  - neue Module-UUIDs (Data + Script)
  - Version auf `1.1.0` angehoben
- `resource_packs/rp0/manifest.json`
  - Name: `My Jedi Addon RP`
  - neue Header-UUID
  - neue Module-UUID
  - Version auf `1.1.0` angehoben

### Warum das wichtig ist

Ohne eigene UUIDs kollidiert dein modifiziertes Paket oft mit der Originalvorlage. Mit eigener Identität kannst du beide Varianten sauber getrennt testen.

## 8) Mehrere Schritte automatisiert (Packaging + UUID-Tool)

Damit du mehrere Aufgaben auf einmal erledigen kannst, gibt es jetzt zwei Tools im Repo:

- `tools/package_addon.sh`
  - erstellt aus BP + RP direkt:
    - `dist/My_Jedi_Addon_BP.mcpack`
    - `dist/My_Jedi_Addon_RP.mcpack`
    - `dist/MyJediAddon.mcaddon`
- `tools/regen_manifest_uuids.py`
  - erzeugt neue UUIDs in beiden Manifesten (Header + Module)

### Nutzung

1. Nur prüfen, was gepackt würde:
   - `./tools/package_addon.sh --dry-run`
2. Pakete wirklich erzeugen:
   - `./tools/package_addon.sh`
3. Neue UUIDs generieren (falls nötig):
   - `./tools/regen_manifest_uuids.py`

### Empfohlener Schnellablauf

1. Modding-Änderungen machen
2. optional UUIDs erneuern (`regen_manifest_uuids.py`)
3. packen (`package_addon.sh`)
4. `dist/*.mcpack` oder `dist/*.mcaddon` in Minecraft importieren

## 9) „ICH WILL ALLES“ Schnellmodus

Wenn du direkt alles willst, nutze diese Reihenfolge im Spiel:

1. `/function custom/all_in_one`
2. `/function custom/help`

Zusätzliche neue Befehle:

- `/function custom/unlock_all`
- `/function custom/warp_all_hubs`

### Mehrere Aufgaben auf einmal außerhalb vom Spiel

- In den Bedrock-Dev-Ordner kopieren (Windows):
  - `./tools/install_to_minecraft_dev.sh`
- Addon-Pakete bauen:
  - `./tools/package_addon.sh`

Danach kannst du entweder direkt über Dev-Packs testen oder `dist/*.mcpack` / `dist/*.mcaddon` importieren.
