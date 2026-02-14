import { world, } from "@minecraft/server";
import { Vector } from "./Vector";
import { getOrCreateObjective, getScoreSafe } from "./archive";
// progression system
// - need to make the hotbar, stamina, and health bars hideable via persistent elements
// - - hud:draw:health_size:x;stamina_size:x 
// hud:draw: = disabled
// hud:draw:a = enabled
// hud:stamina:max12 = max of 12 size
// hud:stamina:val6 = size of bar
// loading values from the host on new player join!
export var UI;
(function (UI) {
    // board -> value
    const persistentUIStates = new Map();
    const persistentElements = new Map();
    const forceUpdateMod = 20;
    var forceTime = 0;
    const forceUpdateElements = [];
    // every tick we will poll these, and if they have changed we will flag that category as dirty
    UI.initSystem = () => {
        if (!persistentElements.has("hotbar")) {
            let grt = new GameplayHotbarRenderer("", "hud:draw_hud:");
            grt.defaultValue = -1;
            persistentElements.set("hotbar", grt);
            forceUpdateElements.push(grt);
            if (world.scoreboard.getObjective("stamina") == undefined) {
                world.scoreboard.addObjective("stamina", "");
            }
            if (world.scoreboard.getObjective("hotbar_health_size") == undefined) {
                world.scoreboard.addObjective("hotbar_health_size", "");
            }
            let health = world.scoreboard.getObjective("hotbar_health_size");
            let hasMax = false;
            for (const part of health.getParticipants()) {
                if (part.displayName === ".max") {
                    hasMax = true;
                }
            }
            if (!hasMax) {
                health.setScore(".max", 7);
            }
        }
        if (!persistentElements.has("task_renderer")) {
            let tkr = new PersistentUiRenderer("SS_ui_task", "hud:task:");
            tkr.defaultValue = 0;
            persistentElements.set("task_renderer", tkr);
            tkr.hasSubValues = true;
            // add all of the task here :D
            tkr.set(0, { text: "hud:task:" }, { text: "hud:task:" });
            tkr.set(1, { "rawtext": [{ "text": "hud:task:" }, { "translate": "spark.task.1", "with": ["\n"] }] });
            tkr.set(2, { "rawtext": [{ "text": "hud:task:" }, { "translate": "spark.task.2", "with": ["\n"] }] });
            tkr.set(3, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.craft_lightsaber.task.craft.task1", "with": ["\n"] }] });
            tkr.set(4, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.craft_lightsaber.task.lightsaber_test.task1", "with": ["\n"] }] });
            // multi input task for bot kills
            tkr.set(5, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.training_room.task.destroy_3_remotes.task1", "with": ["\n"] }] }, undefined, { trigger: "hud:task:§x", objective: "tut_i_bots", text: "§f/3" });
            // multi input task for bot deflects
            tkr.set(6, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.training_room.task.deflect_5_shots.task1", "with": ["\n"] }] }, undefined, { trigger: "hud:task:§x", objective: "tut_i_deflect", text: "§f/5" });
            // multi input task for bot force powers
            tkr.set(7, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.training_room.task.use_force_powers.task1", "with": ["\n"] }] }, undefined, { trigger: "hud:task:§x", objective: "tut_i_bots", text: "§f/3" });
            tkr.set(8, { "rawtext": [{ "text": "hud:task:" }, { "translate": "intro.droid_crafting.task.build_astromech.task1", "with": ["\n"] }] });
            tkr.set(9, { "rawtext": [{ "text": "hud:task:" }, { "translate": "droid_survival.kamino_exterior.announcement.defeat_droids", "with": ["\n"] }] });
            tkr.set(10, { "rawtext": [{ "text": "hud:task:" }, { "translate": "droid_survival.task.defeat_droids.task1", "with": ["\n"] }] });
            // dueling
            tkr.set(20, { "rawtext": [{ "text": "hud:task:" }, { "translate": "lightsaber_dueling.task.defeat_enemies.task1", "with": ["\n"] }] });
            // monster battle
            tkr.set(30, { "rawtext": [{ "text": "hud:task:" }, { "translate": "arena.task.take_care_of_monster.task1", "with": ["\n"] }] });
            // tasks for escape level (5000)
            tkr.set(5001, { "rawtext": [{ "text": "hud:task:" }, { "translate": "battleship.dreadnought.task.escape.task1", "with": ["\n"] }] });
            tkr.set(5002, { "rawtext": [{ "text": "hud:task:" }, { "translate": "battleship.dreadnaught.take.hold_off.task1", "with": ["\n", "\n"] }] }, undefined, undefined, { trigger: "hud:task:§x", scoreName: ".bsecond", objective: "lv_escape_level", text: ":" }
            // { "rawtext": [{ "text": "hud:task:§x" }, { "score": { "name": ".bminute", "objective": "lv_escape_level" } }, { "text": ":" }, { "score": { "name": ".bsecond", "objective": "lv_escape_level" } }] }
            );
            tkr.set(5003, { "rawtext": [{ "text": "hud:task:" }, { "translate": "battleship.dreadnought.task.get_to_ship.task1", "with": ["\n"] }] }, { text: "hud:task:" });
            // puzzle level
            tkr.set(6001, { "rawtext": [{ "text": "hud:task:" }, { "translate": "puzzle.planet_2.task.help_yoda.task1", "with": ["\n"] }] });
            // temple missions completed ui
            tkr.set(9999, { "rawtext": [{ "text": "hud:task:" }, { "translate": "coruscant.main_hall.task.quests", "with": ["\n"] }] }, { "rawtext": [{ text: "hud:task:§x" }, { score: { name: ".completed", objective: "SS_achievements" } }, { text: "§f/5" }] }
            // ,
            // { trigger: "hud:task:§x", scoreName: ".completed" , objective: "tut_i_bots", text: "§f/5" }
            );
        }
        if (!persistentElements.has("tutorial_renderer")) {
            let tr = new PersistentUiRenderer("SS_ui_tutorial", "hud:tutorial:");
            tr.defaultValue = 0;
            persistentElements.set("tutorial_renderer", tr);
            tr.set(0, { text: "hud:tutorial:" });
            tr.set(1, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.1", "with": ["\n"] }] });
            tr.set(2, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.ilum.tutorial_message.follow_kelleran.message1", "with": ["\n"] }] });
            tr.set(3, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.ilum_caves.tutorial_message.pull.message1", "with": ["\n"] }] });
            tr.set(4, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.ilum.tutorial_message.the_calling.message1", "with": ["\n"] }] });
            tr.set(1005, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.task.2", "with": ["\n"] }] }); // tutorial message for yoda return
            // crucible sequence
            tr.set(5, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.crucible.tutorial_message.talk_to_kelleran.message1", "with": ["\n"] }] });
            tr.set(6, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.craft_lightsaber.tutorial_message.use_craft_table.message1", "with": ["\n"] }] });
            tr.set(7, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.craft_lightsaber.tutorial_message.ignite.message1", "with": ["\n"] }] });
            tr.set(8, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.craft_lightsaber.tutorial_message.go_to_training_room.message1", "with": ["\n"] }] });
            tr.set(9, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.training_room.tutorial_message.stand_in_center.message1", "with": ["\n"] }] });
            tr.set(10, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.training_room.tutorial_message.press_to_attack.message1", "with": ["\n"] }] });
            tr.set(11, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.training_room.tutorial_message.press_to_guard.message1", "with": ["\n"] }] });
            tr.set(12, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.training_room.tutorial_message.select_ability.message1", "with": ["\n"] }] });
            tr.set(13, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.ui.waiting", "with": ["\n"] }] });
            tr.set(14, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.droid_crafting.tutorial_message.find_room.message1", "with": ["\n"] }] });
            tr.set(15, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.droid_crafting.tutorial_message.collect_tools.message1", "with": ["\n"] }] });
            tr.set(16, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.droid_crafting.tutorial_message.use_powercell.message1", "with": ["\n"] }] });
            tr.set(17, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "intro.craft_lightsaber.tutorial_message.ignite.message1", "with": ["\n"] }] });
            tr.set(20, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "lightsaber_dueling.tutorial_message.follow_kelleran.message1", "with": ["\n"] }] });
            tr.set(21, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "lightsaber_dueling.tutorial_message.stand_in_circle.message1", "with": ["\n"] }] });
            tr.set(30, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "arena.tutorial_message.follow.message1", "with": ["\n"] }] });
            tr.set(31, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "arena.tutorial_message.soothe_monster.message1", "with": ["\n"] }] });
            tr.set(40, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "coruscant.main_hall.tutorial.quests", "with": ["\n"] }] });
            tr.set(41, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "coruscant.main_hall.tutorial.quest_yoda", "with": ["\n"] }] });
            tr.set(42, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.42", "with": ["\n"] }] });
            tr.set(43, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.43", "with": ["\n"] }] });
            tr.set(44, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.44", "with": ["\n"] }] });
            tr.set(45, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.45", "with": ["\n"] }] });
            tr.set(46, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.46", "with": ["\n"] }] });
            tr.set(47, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.47", "with": ["\n"] }] });
            tr.set(48, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.48", "with": ["\n"] }] });
            tr.set(49, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.49", "with": ["\n"] }] });
            tr.set(50, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "droid_survival.task.defeat_droids.task1", "with": ["\n"] }] });
            tr.set(51, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.51", "with": ["\n"] }] });
            tr.set(52, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.52", "with": ["\n"] }] });
            tr.set(53, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.53", "with": ["\n"] }] });
            tr.set(54, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.54", "with": ["\n"] }] });
            tr.set(55, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.55", "with": ["\n"] }] });
            tr.set(56, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.56", "with": ["\n"] }] });
            tr.set(57, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.57", "with": ["\n"] }] });
            tr.set(58, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.58", "with": ["\n"] }] });
            tr.set(59, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "spark.tutorial.59", "with": ["\n"] }] });
            // escape level
            tr.set(5001, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "battleship.dreadnaught.tutorial_message.escape_cell.message1", "with": ["\n"] }] });
            tr.set(5002, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "battleship.dreadnought.task.get_to_ship.task1", "with": ["\n"] }] });
            // puzzle level
            tr.set(6001, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "puzzle.planet_2.tutorial_message.follow_path.message1", "with": ["\n"] }] });
            tr.set(6002, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "puzzle.temples.tutorial_messages.enter_temple1", "with": ["\n"] }] });
            tr.set(6003, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "puzzle.temples.tutorial_messages.enter_temple2", "with": ["\n"] }] });
            tr.set(6004, { "rawtext": [{ "text": "hud:tutorial:" }, { "translate": "puzzle.temples.tutorial_messages.enter_temple3", "with": ["\n"] }] });
        }
        if (!persistentElements.has("loading_renderer")) {
            let lr = new PersistentUiRenderer("SS_ui_loading", "hud:loading:");
            lr.defaultValue = 0;
            persistentElements.set("loading_renderer", lr);
            lr.set(0, { text: "hud:loading:" });
            lr.set(1, { text: "hud:loading:ilum" });
            lr.set(2, { text: "hud:loading:coruscant" });
            lr.set(3, { text: "hud:loading:tattooine" });
            lr.set(4, { text: "hud:loading:felucia" });
            lr.set(5, { text: "hud:loading:naboo" });
            lr.set(6, { text: "hud:loading:dreadnaught" });
            lr.set(7, { text: "hud:loading:kamino" });
            lr.set(8, { text: "hud:loading:custom_1" });
            lr.set(9, { text: "hud:loading:custom_2" });
            lr.set(10, { text: "hud:loading:blackbars" });
            lr.set(11, { text: "hud:loading:full_black" });
        }
        if (!persistentElements.has("robe_hover_renderer")) {
            let rhr = new PersistentUiRenderer("SS_ui_robe_hover", "hud:robe:");
            rhr.defaultValue = 0;
            persistentElements.set("robe_hover_renderer", rhr);
            rhr.set(0, { text: "hud:robe:" }, { text: "hud:robe:" });
            rhr.set(1, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.default_robe.name", with: ["\n"] },
                ],
            });
            rhr.set(2, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.dueling_robe.name", with: ["\n"] },
                    { text: "\n" },
                    {
                        rawtext: [
                            {
                                text: "§8"
                            },
                            {
                                translate: "archives.hover.dueling_robe.description",
                                with: ["#"],
                            }
                        ]
                    },
                ],
            }, {
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.dueling_robe.status",
                        with: {
                            rawtext: [
                                {
                                    score: {
                                        name: "dueling",
                                        objective: "achievement_display",
                                    },
                                },
                            ],
                        },
                    },
                ],
            });
            rhr.set(3, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.escape_robe.name", with: ["\n"] },
                    { text: "\n" },
                    {
                        rawtext: [
                            {
                                text: "§8"
                            },
                            {
                                translate: "archives.hover.escape_robe.description",
                                with: ["\n"]
                            }
                        ]
                    },
                ],
            }, () => {
                const time = getScoreSafe(getOrCreateObjective("lv_escape_level_achievements"), "fastest_time", -1);
                return {
                    rawtext: [
                        { text: "hud:robe:" },
                        {
                            translate: "archives.hover.escape_robe.status",
                            with: {
                                rawtext: [
                                    time == -1
                                        ? {
                                            translate: "archives.hover.escape_robe.status.na",
                                        }
                                        : {
                                            translate: "archives.hover.escape_robe.status.time",
                                            with: {
                                                rawtext: [
                                                    {
                                                        score: {
                                                            name: "escape_m",
                                                            objective: "achievement_display",
                                                        },
                                                    },
                                                    {
                                                        score: {
                                                            name: "escape_s0",
                                                            objective: "achievement_display",
                                                        },
                                                    },
                                                    {
                                                        score: {
                                                            name: "escape_s1",
                                                            objective: "achievement_display",
                                                        },
                                                    },
                                                ],
                                            },
                                        },
                                ],
                            },
                        },
                    ],
                };
            });
            rhr.set(4, {
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.monster_robe.name",
                        with: ["\n"],
                    },
                    { text: "\n" },
                    {
                        rawtext: [
                            {
                                text: "§8"
                            },
                            {
                                translate: "archives.hover.monster_robe.description",
                                with: ["\n"]
                            }
                        ]
                    },
                ],
            }, {
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.monster_robe.status",
                        with: {
                            rawtext: [
                                {
                                    score: {
                                        name: "monster",
                                        objective: "achievement_display",
                                    },
                                },
                            ],
                        },
                    },
                ],
            });
            rhr.set(5, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.droid_robe.name", with: ["\n"] },
                    { text: "\n" },
                    {
                        rawtext: [
                            {
                                text: "§8"
                            },
                            {
                                translate: "archives.hover.droid_robe.description",
                                with: ["\n"],
                            }
                        ]
                    },
                ],
            }, {
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.droid_robe.status",
                        with: {
                            rawtext: [
                                {
                                    score: {
                                        name: "droid",
                                        objective: "achievement_display",
                                    },
                                },
                            ],
                        },
                    },
                ],
            });
            rhr.set(6, {
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.ancient_robe.name",
                        with: ["\n"],
                    },
                    { text: "\n" },
                    {
                        rawtext: [
                            {
                                text: "§8"
                            },
                            {
                                translate: "archives.hover.ancient_robe.description",
                                with: ["\n"],
                            }
                        ]
                    },
                ],
            }, () => ({
                rawtext: [
                    { text: "hud:robe:" },
                    {
                        translate: "archives.hover.ancient_robe.status",
                        with: {
                            rawtext: [
                                getScoreSafe(getOrCreateObjective("achievement_display"), "min_puzzle_deaths", 2147483647) === 2147483647 ? {
                                    translate: "archives.hover.ancient_robe.status.na"
                                } :
                                    {
                                        score: {
                                            name: "min_puzzle_deaths",
                                            objective: "achievement_display",
                                        },
                                    },
                            ],
                        },
                    },
                ],
            }));
        }
        if (!persistentElements.has("display_hover_renderer")) {
            let dhr = new PersistentUiRenderer("SS_ui_display_hover", "hud:display");
            dhr.defaultValue = 0;
            persistentElements.set("display_hover_renderer", dhr);
            dhr.set(0, { text: "hud:robe:" }, { text: "hud:robe:" });
            // 1 = Lightsaber_Duelling
            // 2 = Escape_the_Battleship
            // 3 = Monster_Battle_Arena
            // 4 = Droid_Survival
            // 5 = Ancient_Puzzle
            dhr.set(1, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.dueling_mission.name", with: ["\n§8"] }
                ]
            });
            dhr.set(2, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.escape_mission.name", with: ["\n§8"] }
                ]
            });
            dhr.set(3, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.monster_mission.name", with: ["\n§8"] }
                ]
            });
            dhr.set(4, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.droid_mission.name", with: ["\n§8"] }
                ]
            });
            dhr.set(5, {
                rawtext: [
                    { text: "hud:robe:" },
                    { translate: "archives.hover.ancient_mission.name", with: ["\n§8"] }
                ]
            });
        }
        // stamina renderer
        persistentElements.set("stamina_renderer", new StaminaExperienceRenderer("", ""));
        for (const b of persistentElements) {
            b[1].createBoard();
        }
    };
    UI.getPlayers = () => {
        return persistentUIStates.values();
    };
    UI.forceUpdateOfElement = (name, player) => {
        if (!persistentElements.has(name)) {
            throw new Error(`Unknown ui element ${name}, cannot force an update!`);
        }
        let element = persistentElements.get(name);
        player.queueUpdate(element);
    };
    UI.updateValues = () => {
        // loop over the persistent systems
        // update those and allow them to get all of the players!
        for (const sys of persistentElements) {
            sys[1].update();
        }
        for (const ply of persistentUIStates) {
            ply[1].update();
        }
        if (forceTime == 0) {
            let players = world.getPlayers();
            for (const ply of persistentUIStates) {
                ply[1].reindex(players);
            }
            for (const sys of forceUpdateElements) {
                sys.update(true);
            }
        }
        forceTime = forceTime + 1;
        forceTime = forceTime % forceUpdateMod;
    };
    // join and leave
    UI.onPlayerSpawn = (player) => {
        let id = player.player.id;
        if (!persistentUIStates.has(id)) {
            let state = new PlayerUIState(player.player);
            persistentUIStates.set(id, state);
            return;
        }
        // if it exists, do nothing for now
    };
    UI.onPlayerLeave = (player) => {
        if (persistentUIStates.has(player.playerId)) {
            persistentUIStates.delete(player.playerId);
        }
    };
})(UI || (UI = {}));
world.afterEvents.playerSpawn.subscribe(UI.onPlayerSpawn);
world.afterEvents.playerLeave.subscribe(UI.onPlayerLeave);
class PlayerUIState {
    constructor(player) {
        this.toUpdate = [];
        this.player = player;
        this.initialSpawnPosition = player.location;
        this.wasHidingHud = false;
    }
    queueUpdate(system) {
        this.toUpdate.push(system);
    }
    reindex(players) {
        let id = this.player.id;
        for (const player of players) {
            if (player.id == id) {
                this.player = player;
                return;
            }
        }
    }
    update() {
        if (!this.player.isValid())
            return;
        // if we have hide_ui, send hide and return
        if (this.player.hasTag("hide_ui")) {
            // send update and return
            this.player.onScreenDisplay.setTitle({
                text: "hud:hide_ui"
            });
            this.wasHidingHud = true;
            return;
        }
        if (this.wasHidingHud && !this.player.hasTag("hide_ui")) {
            // if we have the hide_hotbar tag, send that update?
            if (this.player.hasTag("hide_hotbar")) {
                UI.forceUpdateOfElement("hotbar", this);
            }
            // send a clear
            this.player.onScreenDisplay.setTitle({
                text: "hud:clear"
            });
            this.wasHidingHud = false;
        }
        if (this.toUpdate.length > 0) {
            let s = this.toUpdate[0];
            // if the player has hide_ui, do not process
            if (!this.player.hasTag("hide_ui")) {
                s.draw(this);
                // if the player hasnt moved, we arnt able to confirm the update
                // so requeue the update!
                if (Vector.equals(this.initialSpawnPosition, this.player.location)) {
                    this.queueUpdate(s);
                }
                this.toUpdate.splice(0, 1);
            }
        }
    }
}
class PersistentSystem {
    constructor(boardName, triggerText) {
        this.defaultValue = 0;
        this.triggerText = triggerText;
        this.boardName = boardName;
        this.boardVales = new Map();
    }
    createBoard() {
        if (this.boardName == "")
            return;
        if (world.scoreboard.getObjective(this.boardName) == undefined) {
            world.scoreboard.addObjective(this.boardName, "");
        }
    }
}
class GameplayHotbarRenderer extends PersistentSystem {
    constructor(boardName, triggerText) {
        super("", triggerText);
        this.defaultStaminaSize = 6;
        this.playerStaminaSize = new Map();
        this.playerHealthSize = new Map();
        this.playerHotbarVisible = new Map();
        this.playerHealth = new Map;
    }
    draw(state) {
        let player = state.player;
        // first off, check for having the bar hidden
        // if hidden, hide and return
        if (this.playerHotbarVisible.get(player.id) == false) {
            // hidden
            player.onScreenDisplay.setTitle({
                rawtext: [
                    {
                        text: this.triggerText
                    }
                ]
            });
            if (player.hasTag("ui_debug")) {
                player.sendMessage(`Updated hotbar with hide_hotbar`);
            }
            return;
        }
        // now we start to build out the system
        let command = this.triggerText;
        // stamina size
        let staminaSize = this.playerStaminaSize.get(player.id);
        command += `smax:${staminaSize};`;
        // health size
        let healthSize = this.playerHealthSize.get(player.id);
        command += `hmax:${healthSize};`;
        if (!player.hasTag("internal.death_health")) {
            // health amount or something...
            let component = player.getComponent("minecraft:health");
            let pHealth = component.currentValue;
            let fullHearts = Math.floor(pHealth / 2);
            let hasHalf = pHealth % 2 == 1;
            for (let i = 1; i < fullHearts + 1; i++) {
                command += `h${i}:f;`;
            }
            if (hasHalf) {
                let pos = Math.ceil(pHealth / 2);
                command += `h${pos}:h;`;
            }
        }
        if (player.hasTag("internal.death_health")) {
            command += "h1:e;";
        }
        // trigger title
        player.onScreenDisplay.setTitle({
            rawtext: [
                {
                    text: command
                }
            ]
        });
        if (player.hasTag("ui_debug")) {
            player.sendMessage(`Updated hotbar with command ${command}`);
        }
    }
    createBoard() {
        // need to keep track of the toggle (from tag!)
        // stamina_bar
        if (world.scoreboard.getObjective("hotbar_stamina_size") == undefined) {
            world.scoreboard.addObjective("hotbar_stamina_size", "");
        }
        // make sure max is set to any value .max
        if (!world.scoreboard.getObjective("hotbar_stamina_size").hasParticipant(".max")) {
            world.scoreboard.getObjective("hotbar_stamina_size").setScore(".max", this.defaultStaminaSize);
        }
        // health_bar
        if (world.scoreboard.getObjective("hotbar_health_size") == undefined) {
            world.scoreboard.addObjective("hotbar_health_size", "");
        }
    }
    update(forceUpdate) {
        let staminaBoard = world.scoreboard.getObjective("hotbar_stamina_size");
        let healthBoard = world.scoreboard.getObjective("hotbar_health_size");
        // we are checking for tags here!
        for (const s of UI.getPlayers()) {
            if (!s.player.isValid())
                return;
            let id = s.player.id;
            let player = s.player;
            let identity = player.scoreboardIdentity;
            let markForUpdate = false;
            if (player.hasTag("internal.death_health")) {
                markForUpdate = true;
            }
            // still not drawing on first join...
            if (player.hasTag("blackbox_spawned")) {
                this.playerHotbarVisible.set(id, false);
                markForUpdate = true;
                return;
            }
            if (player.hasTag("hide_hotbar")) {
                // if we do not have the tag cached, add it for processing
                if (!this.playerHotbarVisible.has(id)) {
                    this.playerHotbarVisible.set(id, false);
                    markForUpdate = true;
                }
                if (this.playerHotbarVisible.get(id) == true) {
                    markForUpdate = true;
                }
                this.playerHotbarVisible.set(id, false);
            }
            // no tag
            if (!player.hasTag("hide_hotbar")) {
                if (!this.playerHotbarVisible.has(id)) {
                    this.playerHotbarVisible.set(id, true);
                    markForUpdate = true;
                }
                if (this.playerHotbarVisible.get(id) == false) {
                    markForUpdate = true;
                }
                this.playerHotbarVisible.set(id, true);
            }
            // stamina size
            // if we donot exist
            if (!this.playerStaminaSize.has(id)) {
                // get .max
                let value = staminaBoard.getScore(".max");
                this.playerStaminaSize.set(id, value);
                markForUpdate = true;
            }
            // if we exist
            if (this.playerStaminaSize.has(id)) {
                let remoteValue = staminaBoard.getScore(".max");
                let ourValue = this.playerStaminaSize.get(id);
                if (remoteValue != ourValue) {
                    this.playerStaminaSize.set(id, remoteValue);
                    markForUpdate = true;
                }
            }
            // health bar size
            // TODO: convert to .max
            if (!this.playerHealthSize.has(id)) {
                let value = healthBoard.getScore(".max");
                this.playerHealthSize.set(id, value);
                markForUpdate = true;
            }
            // if we exist
            if (this.playerHealthSize.has(id)) {
                let remoteValue = healthBoard.getScore(".max");
                let ourValue = this.playerHealthSize.get(id);
                if (remoteValue != ourValue) {
                    this.playerHealthSize.set(id, remoteValue);
                    // set player health to removeValue
                    let component = player.getComponent("minecraft:health");
                    component.setCurrentValue(remoteValue * 2);
                    markForUpdate = true;
                }
            }
            // health hearts!
            // will be done from the health component
            // also need to limit the players health somehow...
            // setting the players health is simple
            // if it goes above their allocated value, just set it down one, no updates required
            // limit max health.
            let maxHealthSlots = this.playerHealthSize.get(id) * 2;
            let component = player.getComponent("minecraft:health");
            let currentHealth = component.currentValue;
            if (currentHealth > maxHealthSlots) {
                component.setCurrentValue(maxHealthSlots);
                currentHealth = maxHealthSlots;
            }
            // check for update!
            if (!this.playerHealth.has(id)) {
                this.playerHealth.set(id, currentHealth);
                markForUpdate = true;
            }
            if (this.playerHealth.has(id)) {
                if (this.playerHealth.get(id) != currentHealth) {
                    this.playerHealth.set(id, currentHealth);
                    markForUpdate = true;
                }
            }
            if (forceUpdate != undefined) {
                if (forceUpdate) {
                    markForUpdate = true;
                }
            }
            // trigger update
            if (markForUpdate)
                s.queueUpdate(this);
        }
    }
}
class StaminaExperienceRenderer extends PersistentSystem {
    constructor() {
        super(...arguments);
        // private baseXP: number = 1186;
        // private maxXP: number = 1287;    
        this.baseXP = 9444;
        this.maxXP = 9840;
    }
    draw(state) {
        throw new Error("Method not implemented.");
    }
    update() {
        // every player has a stamina value on that board
        // using that, we can work out the base values and the max
        // this will run each tick, and does not require a draw queue!
        for (const player of UI.getPlayers()) {
            if (!player.player.isValid())
                return;
            // get their max stamina value
            // get their current stamina value
            let maxStamina = world.scoreboard.getObjective("hotbar_stamina_size").getScore(".max");
            let current = world.scoreboard.getObjective("stamina").getScore(player.player.scoreboardIdentity);
            if (current == undefined) {
                world.scoreboard.getObjective("stamina").setScore(player.player, maxStamina);
                current = maxStamina;
            }
            if (current > maxStamina) {
                current = maxStamina;
            }
            // remove xp
            player.player.runCommandAsync("xp -100000L @s");
            // work out the xp that should be given
            let totalForLevel = this.maxXP - this.baseXP;
            let step = totalForLevel / maxStamina;
            let next = Math.ceil(this.baseXP + (step * current));
            player.player.runCommandAsync(`xp ${next} @s`);
        }
    }
}
function resolve(value) {
    if (typeof value == "function") {
        return value();
    }
    return value;
}
// the 5 persistent elements
class PersistentUiRenderer extends PersistentSystem {
    constructor(boardName, triggerText) {
        super(boardName, triggerText);
        this.hasSubValues = false;
        this.resourceMap = new Map();
        this.subMap = new Map();
    }
    set(id, title, subtitle, uniqueElement, bossElement) {
        if (!this.resourceMap.has(id)) {
            if (subtitle != undefined) {
                this.resourceMap.set(id, {
                    title: title,
                    subtitle: subtitle
                });
                return;
            }
            if (uniqueElement != undefined) {
                this.resourceMap.set(id, {
                    title: title,
                    uniqueSubtitle: uniqueElement
                });
                return;
            }
            if (bossElement != undefined) {
                this.resourceMap.set(id, {
                    title: title,
                    escapeBossTime: bossElement
                });
                return;
            }
            this.resourceMap.set(id, {
                title: title
            });
            return;
        }
    }
    draw(state) {
        let player = state.player;
        let value = this.boardVales.get(player.id);
        // state.player.sendMessage(`Drawing ${this.triggerText} - ${value}`);
        // set the onscreen display
        let display = this.resourceMap.get(value);
        // if it has a subtitle
        if (display.subtitle != undefined) {
            // update
            player.onScreenDisplay.setTitle(resolve(display.title), {
                subtitle: resolve(display.subtitle),
                stayDuration: 0,
                fadeInDuration: 0,
                fadeOutDuration: 0
            });
            return;
        }
        if (display.uniqueSubtitle != undefined) {
            // { rawtext: [{ text: "hud:task:§x" }, { score: { name: "@s", objective: "tut_i_bots" } }, { text: "§f/3" }] }
            let unique = display.uniqueSubtitle;
            player.onScreenDisplay.setTitle(resolve(display.title), {
                subtitle: {
                    rawtext: [
                        {
                            text: unique.trigger
                        },
                        {
                            score: {
                                name: player.scoreboardIdentity.displayName,
                                objective: unique.objective
                            }
                        },
                        {
                            text: unique.text
                        }
                    ]
                },
                stayDuration: 0,
                fadeInDuration: 0,
                fadeOutDuration: 0
            });
            return;
        }
        if (display.escapeBossTime != undefined) {
            // { "rawtext": [{ "text": "hud:task:§x" }, { "score": { "name": ".bminute", "objective": "lv_escape_level" } }, { "text": ":" }, { "score": { "name": ".bsecond", "objective": "lv_escape_level" } }] }
            // we will also append the correct values for this!
            let ebs = display.escapeBossTime;
            function pad(value) {
                let z = value.toString().length;
                return z == 1 ? "0" + value.toString() : value.toString();
            }
            let scoreboard = world.scoreboard.getObjective(ebs.objective);
            let minutes = scoreboard.getScore(".bminute");
            let seconds = scoreboard.getScore(".bsecond");
            let timeString = `${pad(minutes)}:${pad(seconds)}`;
            player.onScreenDisplay.setTitle(resolve(display.title), {
                subtitle: {
                    rawtext: [
                        {
                            text: ebs.trigger
                        },
                        {
                            text: timeString
                        }
                    ]
                },
                stayDuration: 0,
                fadeInDuration: 0,
                fadeOutDuration: 0
            });
            return;
        }
        player.onScreenDisplay.setTitle(resolve(display.title));
    }
    update() {
        // detect change... thats all
        for (const state of UI.getPlayers()) {
            if (!state.player.isValid())
                return;
            let id = state.player.id;
            if (!this.boardVales.has(id)) {
                // create and set default value, queue update
                let b = world.scoreboard.getObjective(this.boardName);
                // if the board has a value, we use that
                if (b.hasParticipant(state.player.scoreboardIdentity)) {
                    let score = b.getScore(state.player.scoreboardIdentity);
                    if (!this.resourceMap.has(score)) {
                        b.setScore(state.player.scoreboardIdentity, 0);
                        this.boardVales.set(state.player.id, 0);
                        state.queueUpdate(this);
                        return;
                    }
                    this.boardVales.set(state.player.id, score);
                    state.queueUpdate(this);
                    continue;
                }
                b.setScore(state.player.scoreboardIdentity, this.defaultValue);
                this.boardVales.set(state.player.id, this.defaultValue);
                // queue update
                state.queueUpdate(this);
                continue;
            }
            if (this.boardVales.has(id)) {
                let remoteValue = world.scoreboard.getObjective(this.boardName).getScore(state.player.scoreboardIdentity);
                if (!this.resourceMap.has(remoteValue)) {
                    this.boardVales.set(id, 0);
                    let b = world.scoreboard.getObjective(this.boardName);
                    b.setScore(state.player.scoreboardIdentity, 0);
                    state.queueUpdate(this);
                    return;
                }
                let ourValue = this.boardVales.get(id);
                if (remoteValue != ourValue) {
                    // queue
                    this.boardVales.set(id, remoteValue);
                    this.subMap = new Map();
                    state.queueUpdate(this);
                }
                // need to detect changes for sub values
                if (this.hasSubValues) {
                    let rm = this.resourceMap.get(ourValue);
                    if (rm.uniqueSubtitle != undefined) {
                        let sid = state.player.scoreboardIdentity;
                        let board = rm.uniqueSubtitle.objective;
                        let value = world.scoreboard.getObjective(board).getScore(sid);
                        if (!this.subMap.has(state.player.id)) {
                            this.subMap.set(state.player.id, value);
                            state.queueUpdate(this);
                            return;
                        }
                        // is on map
                        let curValue = this.subMap.get(state.player.id);
                        if (curValue != value) {
                            this.subMap.set(state.player.id, value);
                            state.queueUpdate(this);
                        }
                    }
                    if (rm.escapeBossTime != undefined) {
                        let watchVaue = rm.escapeBossTime.scoreName;
                        let board = rm.escapeBossTime.objective;
                        let value = world.scoreboard.getObjective(board).getScore(watchVaue);
                        if (!this.subMap.has(state.player.id)) {
                            this.subMap.set(state.player.id, value);
                            state.queueUpdate(this);
                            return;
                        }
                        // is on map
                        let curValue = this.subMap.get(state.player.id);
                        if (curValue != value) {
                            this.subMap.set(state.player.id, value);
                            state.queueUpdate(this);
                        }
                    }
                }
            }
        }
    }
}
class PersistentElement {
    constructor(triggerText) {
        this.displayElements = new Map();
        this.triggerText = triggerText;
        if (!triggerText.endsWith(":§x")) {
            this.triggerText += ":§x";
        }
    }
    addElement(id, element) {
        if (!this.displayElements.has(id)) {
            this.displayElements.set(id, element);
        }
    }
    drawElement(player, id) {
        if (this.displayElements.has(id)) {
            let element = this.displayElements.get(id);
            if (element.subtitle == undefined) {
                player.onScreenDisplay.setTitle(resolve(element.title));
                return;
            }
            player.onScreenDisplay.setTitle(resolve(element.title), {
                subtitle: resolve(element.subtitle),
                fadeInDuration: 0,
                fadeOutDuration: 0,
                stayDuration: 0
            });
        }
    }
}
