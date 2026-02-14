import { LevelManager } from "./level";
import { UI } from "./ui";
import { PuzzleLevel } from "./puzzleLevel";
import { system, world } from "@minecraft/server";
import { EscapeLevel } from "./new_escape";
import { computeBounds, isPointInsideAABB } from "./AABB";
import { setDialogue } from "./util";
const LEVEL_MANAGER = new LevelManager();
const HUB_BOUNDS = computeBounds({ x: 3199.29, y: 175.49, z: 161.20 }, { x: 3514.14, y: 17.09, z: -183.42 });
const HUB_CHARACTERS = [
    {
        type: "spark:ahsoka_tano",
        events: ["spark:enable_face_player", "spark:disable_lightsaber"],
        location: { x: 3366.50, y: 34.0, z: 55.50 }
    },
    {
        type: "spark:anakin_skywalker",
        events: ["spark:quest_npc", "spark:enable_quest_icon", "spark:disable_lightsaber"],
        dialogue: "spark:jedi_temple.anakin.1",
        location: { x: 3364.50, y: 34.0, z: 55.50 }
    }
];
function init() {
    system.afterEvents.scriptEventReceive.subscribe(onScriptEvent);
    UI.initSystem();
    // levels
    new EscapeLevel("escape_level");
    new PuzzleLevel("puzzle_level");
    // loading board
    const boardName = "active_state";
    if (world.scoreboard.getObjective(boardName) == undefined) {
        world.scoreboard.addObjective(boardName, "");
        for (const level of LEVEL_MANAGER.levels) {
            world.scoreboard.getObjective(boardName).setScore(level[1].levelName, 0);
        }
    }
    // handle loading again!
    recoverFromRestart();
}
function update() {
    updateDeath();
    // update the levels
    LEVEL_MANAGER.update();
    // ui stuff
    UI.updateValues();
}
const duellingArena = computeBounds({
    x: 9020.39,
    y: 45.08,
    z: 8942.21,
}, {
    x: 8931.23,
    y: 10.48,
    z: 8614.42,
});
const templeArea = computeBounds({
    x: 5274.09,
    y: -42.12,
    z: 7879.19,
}, {
    x: 6068.78,
    y: 97.38,
    z: 8601.21,
});
function updateDeath() {
    // if a player enters this for the first time, tag them
    for (const player of world.getPlayers()) {
        if (player.hasTag("fatal_damage_scripting")) {
            // MAKE THIS GLOBAL!
            // get player health
            let health = player.getComponent("minecraft:health");
            health.setCurrentValue(1);
            // player.applyDamage(health.currentValue - 1);
            if (isPointInsideAABB(player.location, duellingArena.min, duellingArena.max)) {
                handleDuellingDeath(player);
                return;
            }
            // temple duelling!
            if (isPointInsideAABB(player.location, templeArea.min, templeArea.max)) {
                handleTempleDuellingDeath(player);
                return;
            }
            // escape level is handling this on its own as its more complex
            // and requires a lot more actions
            // add tag during death
            // death_can_respawn
            player.removeTag("fatal_damage_scripting");
            LEVEL_MANAGER.addParallelAction(45, (tick) => {
                if (tick == 0) {
                    player.fadeOut();
                    player.disableInput();
                }
                if (tick == 25) {
                    player.addTag("death_can_respawn");
                    player.playSound("sound.spark.player_death_respawn");
                }
                if (tick == 30) {
                    if (!player.hasTag("no_script_fade")) {
                        player.fadeIn();
                        player.enableInput();
                    }
                    player.addEffect("instant_health", 10, { amplifier: 10, showParticles: false });
                    player.triggerEvent("spark:remove_fatal_damage");
                    player.removeTag("internal.death_health");
                    if (player.hasTag("no_script_fade")) {
                        player.removeTag("no_script_fade");
                    }
                }
            });
        }
    }
}
function handleDuellingDeath(p) {
    p.addTag("respawned");
    p.removeTag("fatal_damage_scripting");
    p.triggerEvent("spark:remove_fatal_damage");
    LEVEL_MANAGER.addParallelAction(31, (tick) => {
        if (tick == 30) {
            p.removeTag("internal.death_health");
        }
    });
}
function handleTempleDuellingDeath(p) {
    p.removeTag("fatal_damage_scripting");
    p.addTag("resetting");
    LEVEL_MANAGER.addParallelAction(31, (tick) => {
        if (tick == 0) {
            p.fadeOut();
            p.disableInput();
        }
        if (tick == 20) {
            p.fadeIn();
            p.addEffect("instant_health", 10, { amplifier: 10, showParticles: false });
            p.enableInput();
            p.triggerEvent("spark:remove_fatal_damage");
            p.playSound("sound.spark.player_death_respawn");
            p.removeTag("internal.death_health");
        }
    });
}
function recoverFromRestart() {
    // if a level has a value of 1, load that level and go!
    // the first level with a 1 is the one that will be loaded
    const boardName = "active_state";
    if (world.scoreboard.getObjective(boardName) != undefined) {
        let entries = world.scoreboard.getObjective(boardName).getScores();
        if (entries.length > 0) {
            for (const ent of entries) {
                // loop over and see what level was last active
                if (ent.score == 1) {
                    // get level name from scoreboard entry
                    let name = ent.participant.displayName;
                    if (LEVEL_MANAGER.levels.has(name)) {
                        let l = LEVEL_MANAGER.levels.get(name);
                        l.load();
                        l.start();
                    }
                    return;
                }
            }
        }
    }
}
function onScriptEvent(s) {
    if (s.id == "spark:engine") {
        let command = s.message.split(' ');
        if (command.length > 0) {
            // if the next command is level
            if (command[0] == "level") {
                // 1 = the level anme
                let name = command[1];
                if (LEVEL_MANAGER.hasLevel(name)) {
                    LEVEL_MANAGER.dispatchScriptMessage(name, command.splice(2));
                }
            }
            if (command[0] == "eim") {
                LEVEL_MANAGER.addParallelAction(100, (tick) => {
                    if (tick == 0) {
                        LEVEL_MANAGER.differSpawn("spark:torren_elevator", { x: 5454.5, y: 104.5, z: 8833.5 }, world.getDimension("overworld"));
                    }
                    // if we can get the elevator
                    let elevator = world.getDimension("overworld").getEntities({ type: "spark:torren_elevator" });
                    if (elevator.length > 0) {
                        let ent = elevator[0];
                        if (ent.hasTag("down"))
                            return;
                        // apply a time inpulse down, see what we can do!
                        // this might compound, so we will see!
                        // ent.applyImpulse({x:0,y:-0.10,z:0});
                        ent.applyImpulse({ x: 0, y: -0.08, z: 0 });
                        ent.addTag("down");
                    }
                });
            }
            if (command[0] == "print_names") {
                let test = world.getDimension("overworld").getEntities({ type: "spark:kelleran_beq" });
                if (test.length > 0) {
                    for (const kell of test) {
                        world.sendMessage(kell.nameTag);
                    }
                }
            }
            if (command[0] == "kell_test") {
                let spawnPos = { x: 94.5, y: -26, z: 3022 };
                LEVEL_MANAGER.differSpawn("spark:kelleran_beq", spawnPos, world.getDimension("overworld"), undefined, (e) => {
                    setDialogue(e, "spark:illum.kelleran_1");
                }, [], ["spark:quest_npc"]);
            }
        }
    }
    if (s.id == "spark:enforce") {
        enforceQuestGiversInHub();
    }
}
function enforceQuestGiversInHub() {
    for (const hub of HUB_CHARACTERS) {
        let entity = world.getDimension("overworld").getEntities({ type: hub.type });
        // if 0, assume non existant and spawn...
        if (entity.length == 0) {
            // queue up the summon
            LEVEL_MANAGER.differSpawn(hub.type, hub.location, world.getDimension("overworld"), undefined, (e) => {
                if (hub.dialogue != undefined) {
                    setDialogue(e, hub.dialogue, false);
                }
            }, hub.tags, hub.events);
        }
    }
}
export { LEVEL_MANAGER, init, update };
