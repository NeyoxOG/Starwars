import { BlockPermutation, world } from "@minecraft/server";
import { Level } from "./level";
import { computeBounds, isPointInsideAABB } from "./AABB";
import { LEVEL_MANAGER } from "./engine";
import { clamp, getTagThatContains, randomRange, resetBoard, setDialogue, tagContains } from "./util";
import { LocationLang } from "./extensions";
import { Vector } from "./Vector";
const labrinthAchievementTime = 20 * 720;
export class EscapeLevel extends Level {
    constructor(name) {
        super(name);
        this.distanceOffsetMax = 5;
        this.cloneRunDistance = 15;
        this.cloneTeleportDistance = 50;
        // astromech stuff
        this.astromechCrumbDistance = 2;
        this.doorUnlockTimeRequired = 20 * 2.5;
        this.inLabrinth = false;
        this.inBossFight = false;
        this.scoreboardName = `lv_${this.levelName}`;
        this.petBreadcrumbIndex = 1;
        this.anakinSpawn = { x: 6046.5, y: -41, z: 2738.5 };
        this.ahsokaSpawn = { x: 6040.5, y: -41, z: 2741.5 };
        this.astromechHoldingZone = computeBounds({ x: 6037, y: -31, z: 2749 }, { x: 6040, y: -31, z: 2754 });
        this.venatorDialogueZone = computeBounds({
            x: 6028,
            y: -30,
            z: 2747
        }, {
            x: 6059,
            y: -46,
            z: 2727
        });
        this.cellBounds = [
            { bounds: computeBounds({ x: 5914, y: -62, z: 2857 }, { x: 5905, y: -52, z: 2846 }), fallLocation: { x: 5909.5, y: -52, z: 2852.5 } },
            { bounds: computeBounds({ x: 5914, y: -62, z: 2835 }, { x: 5905, y: -52, z: 2846 }), fallLocation: { x: 5909.5, y: -52, z: 2841.5 } },
            { bounds: computeBounds({ x: 5888, y: -62, z: 2835 }, { x: 5897, y: -52, z: 2847 }), fallLocation: { x: 5893.5, y: -52, z: 2841.5 } },
            { bounds: computeBounds({ x: 5897, y: -62, z: 2847 }, { x: 5888, y: -52, z: 2857 }), fallLocation: { x: 5893.5, y: -52, z: 2852.5 } }
        ];
        // cutscene lengths
        this.ch07_c02 = 895;
        this.cellTimerOffset = 100;
        // achievement board
        let achievementBoard = `lv_${this.levelName}_achievements`;
        if (world.scoreboard.getObjective(achievementBoard) == undefined) {
            world.scoreboard.addObjective(achievementBoard, "");
            world.scoreboard.getObjective(achievementBoard).setScore("finished", 0);
            world.scoreboard.getObjective(achievementBoard).setScore("fastest_time", 0);
            world.scoreboard.getObjective(achievementBoard).setScore("target_time", 20 * 720);
        }
        if (world.scoreboard.getObjective(achievementBoard) != undefined) {
            world.scoreboard.getObjective(achievementBoard).setScore("finished", 0);
            world.scoreboard.getObjective(achievementBoard).setScore("fastest_time", 0);
            world.scoreboard.getObjective(achievementBoard).setScore("target_time", 20 * 720);
        }
        this.state = 0;
        this.subState = 1;
        this.dimension = world.getDimension("overworld");
        // init stuff
        this.clones = [];
        this.enemies = [];
        // astromech
        this.astromechLerpCache = new Map();
        this.astromechUnlockTime = new Map();
        this.stationDoorMappings = new Map();
        this.patrols = [];
        this.labrinthTime = 0;
        this.defaultBossTime = 20 * 120;
        this.currentBossTime = this.defaultBossTime;
        this.leftGuardDead = 0;
        this.rightGuardDead = 0;
        this.deathCounter = 0;
        this.bossDeaths = 0;
        this.bossSummonTimer = 0;
        this.playerDeathTimer = new Map();
        this.playerDeathPoints = new Map();
        this.panelMusicMapping = new Set();
        this.bossTrigger = undefined;
        this.panelDroidMappings = new Map();
        this.soundTick = 0;
        // 5767.63 -79.87 2691.86 6136.11 7.88 3295.28
        this.levelBounds = computeBounds({
            x: 5767,
            y: -79,
            z: 2691,
        }, {
            x: 6136,
            y: 8,
            z: 3295,
        });
    }
    // ----------------------------------- //
    // ---------- First Venator ---------- //
    // ----------------------------------- //
    setupStartSequence() {
        this.sequence.clear();
        this.sequence.createStepOnTick(0, (tick) => {
        }, 0);
        // cinematic setup
        this.sequence.createStepOnTick(100, (tick) => {
            // fade all players
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                players[i].fadeOut();
                // players[i].clearPersistentUI();
                if (players[i].hasTag("escape.interact.station"))
                    players[i].removeTag("escape.interact.station");
            }
            // stop astromechs from teleporting
            this.dimension.runCommandAsync(`tickingarea add circle ${this.astromechHoldingZone.center.x} ${this.astromechHoldingZone.center.y} ${this.astromechHoldingZone.center.z} 2 scripting.astromech.pen true`);
        }, 1);
        this.sequence.createStepOnTick(125, (tick) => {
            for (const player of this.dimension.getPlayers()) {
                player.teleport({ x: 6043.5, y: -41, z: 2754.5 }, { facingLocation: { x: 6043.5, y: -41, z: 2739.5 } });
                player.fadeIn();
                player.disableCutsceneSettings();
                player.setDefaultHotbarLoadout();
            }
            this.subState = 1;
            this.save();
        }, 2);
        this.sequence.start(this.subState);
        // trigger to do the things in
        const zoneAABB = computeBounds({
            x: 6026,
            y: -28,
            z: 2729.87
        }, {
            x: 6062,
            y: -48,
            z: 2779.20
        });
        this.createTrigger(zoneAABB.min, zoneAABB.max, (self) => {
            // despawn everything in this just in case
            for (const entity of this.dimension.getEntities({ excludeTypes: ["minecraft:player", "spark:venator_holo_table", "spark:venator_bridge_door", "spark:venator_screen", "spark:astromech"] })) {
                if (isPointInsideAABB(entity.location, zoneAABB.min, zoneAABB.max)) {
                    entity.despawn();
                }
            }
            for (const player of this.dimension.getPlayers()) {
                player.clearPersistentUI();
            }
            // differ spawning
            LEVEL_MANAGER.differSpawn("spark:anakin_skywalker", this.anakinSpawn, this.dimension, undefined, (e) => {
                e.teleport(e.location, { rotation: { x: 0, y: 70 } });
            });
            LEVEL_MANAGER.differSpawn("spark:ahsoka_tano", this.ahsokaSpawn, this.dimension, undefined, (e) => {
                e.teleport(e.location, { rotation: { x: 0, y: -30 } });
            }, ["has_quest"], ["spark:quest_npc"]);
            // clones
            const clones = [
                { x: 6047.5, y: -41, z: 2734.5 },
                { x: 6045.5, y: -41, z: 2734.5 },
                { x: 6043.5, y: -41, z: 2733.5 },
                { x: 6041.5, y: -41, z: 2734.5 },
                { x: 6039.5, y: -41, z: 2734.5 }
            ];
            for (const c of clones) {
                LEVEL_MANAGER.differSpawn("spark:clone_trooper", c, this.dimension, () => { }, () => { }, [], ["spark:color_blue"]);
            }
            LEVEL_MANAGER.queueAction(20, (tick) => {
                if (tick == 19) {
                    // location display
                    const players = this.dimension.getPlayers();
                    for (const player of players) {
                        if (isPointInsideAABB(player.location, zoneAABB.min, zoneAABB.max)) {
                            player.displayLocation(LocationLang.Venator, "sound.spark.enter_venator");
                        }
                    }
                    world.playMusic("sound.spark.ambience_spaceship", { volume: 1.0, fade: 0.1, loop: true });
                }
            });
            self.disabled = true;
        });
        // make a trigger to set dialog when entering, like we have done at the end
        this.createTrigger(this.venatorDialogueZone.min, this.venatorDialogueZone.max, (self) => {
            const ahsoka = this.dimension.getEntities({ type: "spark:ahsoka_tano", location: this.ahsokaSpawn, maxDistance: 1 });
            if (ahsoka.length > 0) {
                setDialogue(ahsoka[0], "spark:venator.ahsoka.beacon_explanation");
                self.disable();
            }
        });
        // wait for talk with anakin
        this.createTrigger(zoneAABB.min, zoneAABB.max, (self) => {
            const anakin = this.dimension.getEntities({ type: "spark:anakin_skywalker", location: this.anakinSpawn, maxDistance: 1 });
            if (anakin.length > 0) {
                if (anakin[0].hasTag("venator.1.accepted")) {
                    // trigger cutscenes
                    anakin[0].removeTag("venator.1.accepted");
                    // despawn clones
                    this.setupCh07c02();
                    // load first cutscene thing
                    this.subState = 0;
                    this.save();
                    self.disabled = true;
                }
            }
        });
    }
    setupCh07c02() {
        this.sequence.stop();
        this.sequence.clear();
        this.sequence.createStepOnTick(0, (tick) => {
            // play fade, wait 25 ticks
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                players[i].fadeOut();
            }
        });
        this.sequence.createStepOnTick(25, () => {
            for (const clone of this.dimension.getEntities({ type: "spark:clone_trooper" })) {
                clone.despawn();
            }
            for (const npc of this.dimension.getEntities({ families: ["npc"] })) {
                if (isPointInsideAABB(npc.location, this.levelBounds.min, this.levelBounds.max)) {
                    npc.despawn();
                }
            }
            // astromech stuff
            // need to teleport then to a holding area for use in a little bit!
            this.holdDroids();
            // play cutscene
            this.dimension.runCommandAsync("function spark/cutscene/start_ch07_c02");
        });
        // final tick to move on!
        this.sequence.createStepOnTick(this.ch07_c02 + 25 + 1, (tick) => {
            // load next sequence!
            this.state = 1;
            this.subState = 0;
            this.save();
            // hand off to next section
            this.setupPrisonSequence();
        });
        this.sequence.start();
    }
    holdDroids() {
        for (const companion of this.dimension.getEntities({ type: "spark:astromech" })) {
            // if in level bounds
            if (isPointInsideAABB(companion.location, this.levelBounds.min, this.levelBounds.max)) {
                if (!companion.hasTag("no_tp")) {
                    companion.addTag("no_tp");
                }
                // remove ability to move
                // teleport to holding area
                companion.triggerEvent("spark:immobile");
                if (!isPointInsideAABB(companion.location, this.astromechHoldingZone.min, this.astromechHoldingZone.max)) {
                    let x = randomRange(this.astromechHoldingZone.min.x, this.astromechHoldingZone.max.x);
                    let z = randomRange(this.astromechHoldingZone.min.z, this.astromechHoldingZone.max.z);
                    companion.teleport({ x: x, y: this.astromechHoldingZone.center.y, z: z });
                }
            }
        }
    }
    // ---------------------------- //
    // ---------- prison ---------- //
    // ---------------------------- //
    setupPrisonSequence() {
        // trigger to spawn things in and setup the sequence
        // queue action to do the teleporting (we will be full black)
        LEVEL_MANAGER.queueAction(1, (tick) => {
            if (this.subState > 0) {
                return;
            }
            if (tick == 0) {
                let players = this.dimension.getPlayers();
                let cells = [
                    { x: 5910.5, y: -61, z: 2841.5 },
                    { x: 5892.5, y: -61, z: 2841.5 },
                    { x: 5892.5, y: -61, z: 2852.5 },
                    { x: 5910.5, y: -61, z: 2852.5 },
                ];
                let looks = [
                    { x: 5906, y: -60, z: 2841 },
                    { x: 5896, y: -60, z: 2841 },
                    { x: 5896, y: -60, z: 2852 },
                    { x: 5906, y: -60, z: 2852 }
                ];
                for (let i = 0; i < players.length; i++) {
                    let player = players[i];
                    player.teleport(cells[i], { facingLocation: looks[i] });
                    player.runCommandAsync("clear");
                }
            }
            this.subState = 1;
            this.save();
        });
        // if any player is within the prison area, differ spawn everything!
        let zone = computeBounds({
            x: 5885,
            y: -64,
            z: 2824
        }, {
            x: 5917,
            y: -47,
            z: 2859
        });
        this.createTrigger(zone.min, zone.max, (self) => {
            // pure spawning and sequence stuff?
            let entities = this.dimension.getEntities({ excludeTypes: ["minecraft:player", "spark:astromech", "spark:venator_bridge_door", "spark:venator_screen", "spark:venator_holo_table"] });
            for (let i = 0; i < entities.length; i++) {
                let e = entities[i];
                if (e.isValid()) {
                    if (isPointInsideAABB(e.location, zone.min, zone.max)) {
                        e.despawn();
                    }
                }
            }
            // scoreboard stuff
            if (world.scoreboard.getObjective("escape_zones") == undefined) {
                world.scoreboard.addObjective("escape_zones", "");
            }
            // spawn in doors
            // this door doesnt despawn.. so ehh this will work!
            if (this.subState < 1) {
                LEVEL_MANAGER.differSpawn("spark:prison_exit_door", { x: 5901.5, y: -59, z: 2824.5 }, this.dimension, undefined, undefined, ["final_prison_door"], ["spark:door_north"]);
                // decoration
                LEVEL_MANAGER.differSpawn("spark:prison_exit_door", { x: 5901.5, y: -59, z: 2858.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
            }
            if (this.subState < 3) {
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5897.5, y: -59, z: 2852.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5905.5, y: -59, z: 2852.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5905.5, y: -59, z: 2841.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5897.5, y: -59, z: 2841.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5897.5, y: -59, z: 2830.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
                LEVEL_MANAGER.differSpawn("spark:prison_cell_door", { x: 5905.5, y: -59, z: 2830.5 }, this.dimension, undefined, undefined, ["group_open"], ["spark:door_east"]);
            }
            // spawn in control panels with barriers
            // these need a better rotation! 5906 -61 2837
            if (this.subState < 2) {
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2848.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2837.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2845.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2856.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west"]);
                this._mapStationToDoor("prison_panel", { x: 5897.5, y: -59, z: 2852.5 }, { x: 5905.5, y: -59, z: 2852.5 }, { x: 5905.5, y: -59, z: 2841.5 }, { x: 5897.5, y: -59, z: 2841.5 }, { x: 5897.5, y: -59, z: 2830.5 }, { x: 5905.5, y: -59, z: 2830.5 });
            }
            if (this.subState == 2) {
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2848.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east", "spark:allow_interaction"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2837.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east", "spark:allow_interaction"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2845.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west", "spark:allow_interaction"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2856.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west", "spark:allow_interaction"]);
                this._mapStationToDoor("prison_panel", { x: 5897.5, y: -59, z: 2852.5 }, { x: 5905.5, y: -59, z: 2852.5 }, { x: 5905.5, y: -59, z: 2841.5 }, { x: 5897.5, y: -59, z: 2841.5 }, { x: 5897.5, y: -59, z: 2830.5 }, { x: 5905.5, y: -59, z: 2830.5 });
            }
            if (this.subState > 2) {
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2848.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east", "spark:finish"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5906.5, y: -61, z: 2837.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:east", "spark:finish"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2845.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west", "spark:finish"]);
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5896.5, y: -61, z: 2856.5 }, this.dimension, undefined, undefined, ["prison_panel"], ["spark:west", "spark:finish"]);
            }
            if (this.subState <= 3) {
                // final panel
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5903.5, y: -59, z: 2826.5 }, this.dimension, undefined, undefined, ["final_prison_panel"], ["spark:west"]);
                this._mapStationToDoor("final_prison_panel", { x: 5901.5, y: -59, z: 2824.5 });
                // clones 5900.5 -59 2827.5 0 0
                LEVEL_MANAGER.differSpawn("spark:interactable_clone", { x: 5900.5, y: -59, z: 2827.5 }, this.dimension, undefined, (entity) => {
                    entity.teleport(entity.location, { rotation: { x: 0, y: 0 } });
                }, ["has_quest"], ["spark:quest_npc"]);
            }
            if (this.subState > 3) {
                // begin differ spawning :D
                this.generateLabrinthDoors();
                this.generatePatrols();
                this.differDecorations();
                // clones 5900.5 -59 2827.5 0 0
                LEVEL_MANAGER.differSpawn("spark:clone_trooper", { x: 5900.5, y: -59, z: 2827.5 }, this.dimension, undefined, (entity) => {
                    entity.teleport(entity.location, { rotation: { x: 0, y: 0 } });
                }, [], ["spark:set_pushable", "spark:color_blue"]);
                // final panel
                LEVEL_MANAGER.differSpawn("spark:droid_station", { x: 5903.5, y: -59, z: 2826.5 }, this.dimension, undefined, undefined, ["final_prison_panel"], ["spark:west", "spark:allow_interaction"]);
                this._mapStationToDoor("final_prison_panel", { x: 5901.5, y: -59, z: 2824.5 });
            }
            LEVEL_MANAGER.differSpawn("spark:clone_trooper", { x: 5898.5, y: -59, z: 2829.75 }, this.dimension, undefined, 
            // (entity: Entity) => { entity.teleport(entity.location, { rotation: { x: -90, y: 0 } }) }
            (entity) => { entity.teleport(entity.location, { rotation: { x: 0, y: -90 } }); }, [], ["spark:set_not_pushable", "spark:color_blue"]);
            LEVEL_MANAGER.differSpawn("spark:clone_trooper", { x: 5898.5, y: -59, z: 2831.25 }, this.dimension, undefined, 
            // (entity: Entity) => { entity.teleport(entity.location, { rotation: { x: 90, y: 0 } }) }
            (entity) => { entity.teleport(entity.location, { rotation: { x: 0, y: -90 } }); }, [], ["spark:set_not_pushable", "spark:color_blue"]);
            LEVEL_MANAGER.differSpawn("spark:clone_trooper", { x: 5904.5, y: -59, z: 2831.25 }, this.dimension, undefined, 
            // (entity: Entity) => { entity.teleport(entity.location, { rotation: { x: 90, y: 0 } }) }
            (entity) => { entity.teleport(entity.location, { rotation: { x: 0, y: 90 } }); }, [], ["spark:set_not_pushable", "spark:color_blue"]);
            LEVEL_MANAGER.differSpawn("spark:clone_trooper", { x: 5904.5, y: -59, z: 2829.75 }, this.dimension, undefined, 
            // (entity: Entity) => { entity.teleport(entity.location, { rotation: { x: -90, y: 0 } }) }
            (entity) => { entity.teleport(entity.location, { rotation: { x: 0, y: 90 } }); }, [], ["spark:set_not_pushable", "spark:color_blue"]);
            // quest
            LEVEL_MANAGER.queueAction(5, (tick) => {
                if (tick == 4) {
                    let intClone = this.dimension.getEntities({ location: { x: 5900.5, y: -59, z: 2827.5 }, maxDistance: 1 });
                    if (intClone.length > 0) {
                        if (intClone[0].typeId === "spark:interactable_clone") {
                            setDialogue(intClone[0], "spark:escape.clone_1");
                        }
                    }
                }
            });
            // need a list of playter cell bounds for triggers
            // these will then all play out the correct intro sequence
            // until intro sequence is done!
            if (this.subState == 0) {
                for (const cell of this.cellBounds) {
                    // if a player is in here
                    for (const player of this.dimension.getPlayers()) {
                        if (isPointInsideAABB(player.location, cell.bounds.min, cell.bounds.max)) {
                            this.setupEntryTrigger(player, cell);
                        }
                    }
                }
            }
            self.disable();
        });
        // MOVE TO NEW FUNCTION
        // trigger for the next few states
        // remove tutorial message on final door open
        // set task on final door open
        // on door open
        this.createTrigger(zone.min, zone.max, (self) => {
            if (this.subState > 2) {
                self.disable();
                return;
            }
            let doors = this.dimension.getEntities({ type: "spark:prison_cell_door", tags: ["open"] });
            if (doors.length > 0) {
                let players = this.dimension.getPlayers();
                for (const p of players) {
                    if (isPointInsideAABB(p.location, zone.min, zone.max)) {
                        p.playSound("sound.spark.success_minor");
                    }
                }
                // dialogue
                let intClone = this.dimension.getEntities({ type: "spark:interactable_clone", location: { x: 5900.5, y: -59, z: 2827.5 }, maxDistance: 1 });
                if (intClone.length > 0) {
                    setDialogue(intClone[0], "spark:escape.clone_1");
                }
                this.subState = 3;
                this.save();
                self.disable();
            }
        });
        // trigger here, if state = 1, but we are in the hallway, open all of the doors!
        // 5898 -59 2858 5904 -53 2825
        let doorZone = computeBounds({
            x: 5898,
            y: -59,
            z: 2858
        }, {
            x: 5904,
            y: -53,
            z: 2825
        });
        let backupTrigger = this.createTrigger(doorZone.min, doorZone.max, (self) => {
            if (this.subState == 1) {
                // do not need to check, as we will only trigger this if we are in the zone...
                // open doors.
                for (const door of this.dimension.getEntities({ tags: ["group_open"] })) {
                    door.triggerEvent("spark:open_door");
                }
            }
        });
        // TODO: on first set of doors open, set synState = 2;
        // detect transform into clone
        this.createTrigger(zone.min, zone.max, (self) => {
            if (this.subState > 3) {
                self.disable();
                return;
            }
            let clone = this.dimension.getEntities({ type: "spark:clone_trooper", location: { x: 5900.5, y: -59, z: 2827.5 }, maxDistance: 1 });
            if (clone.length > 0) {
                let players = this.dimension.getPlayers();
                for (const p of players) {
                    if (isPointInsideAABB(p.location, zone.min, zone.max)) {
                        p.setTask(5001, "sound.spark.quest_major");
                    }
                }
                // make all clones pushable
                for (const c of this.dimension.getEntities({ type: "spark:clone_trooper" })) {
                    if (isPointInsideAABB(c.location, this.levelBounds.min, this.levelBounds.max)) {
                        c.triggerEvent("spark:set_pushable");
                    }
                }
                backupTrigger.disable();
                // begin differ spawning :D
                this.generateLabrinthDoors();
                this.generatePatrols();
                this.differDecorations();
                this.subState = 4;
                this.save();
                self.disable();
            }
        });
        // on door open "spark:prison_exit_door", { x: 5901.5, y: -59, z: 2824.5 }
        this.createTrigger(zone.min, zone.max, (self) => {
            let door = this.dimension.getEntities({ type: "spark:prison_exit_door", location: { x: 5901.5, y: -59, z: 2824.5 }, maxDistance: 1, tags: ["open"] });
            if (door.length > 0) {
                // remove tutorial message from players
                for (const player of this.dimension.getPlayers()) {
                    player.setTutorialMessage(0);
                }
                // time to start counting up.
                this.inLabrinth = true;
                this.state = 2;
                this.subState = 0;
                this.save();
                // remove ticking area
                this.dimension.runCommandAsync("tickingarea remove scripting.astromech.pen");
                // tag clones as no delete
                // does this duplicate the clones
                // for (const clone of this.dimension.getEntities({ type: "spark:clone_trooper" })) {
                //     if (!clone.hasTag("no_delete")) {
                //         clone.addTag("no_delete");
                //     }
                // }
                self.disable();
            }
        });
    }
    setupEntryTrigger(player, bounds) {
        this.createTrigger(bounds.bounds.min, bounds.bounds.max, (self) => {
            let mech = this.getPlayerPet(player);
            if (self.internalCounter <= 35) {
                if (self.internalCounter == 0) {
                    player.disableCutsceneSettings();
                    player.setEscapePrisonHotbarLoading();
                }
                if (self.internalCounter == 10) {
                    player.fadeIn("sound.spark.inside_cell");
                }
                if (self.internalCounter == 35) {
                    player.displayLocation(LocationLang.Dreadnaught);
                }
            }
            // astromech scream at 75
            if (self.internalCounter == 75 + this.cellTimerOffset) {
                player.playSound("sound.spark.droid_flee_prison_cells", {
                    location: Vector.add(player.location, new Vector(0, 2, 0)),
                    pitch: 1,
                    volume: 1
                });
            }
            // teleport astromech at 80
            if (self.internalCounter == 80 + this.cellTimerOffset) {
                // get players astromech
                // teleport it to the correct palce
                // enable mobile!
                mech.teleport(bounds.fallLocation);
            }
            // on landing, remove immobile
            if (self.internalCounter > 85 + this.cellTimerOffset) {
                // when y velo is 0, we are on the ground
                if (!mech.hasTag("script.landed")) {
                    // get the block below the pet
                    let blockBelow = this.dimension.getBlock(Vector.subtract(mech.location, new Vector(0, -1, 0)));
                    if (blockBelow != undefined) {
                        if (!blockBelow.permutation.matches("minecraft:air")) {
                            LEVEL_MANAGER.addParallelAction(110, (tick) => {
                                if (tick == 10) {
                                    mech.triggerEvent("spark:do_idle_interact_animation");
                                }
                                if (tick == 50) {
                                    player.setDefaultHotbarLoadout();
                                }
                                if (tick == 79) {
                                    player.setTutorialMessage(5001, "sound.spark.quest_minor");
                                }
                                if (tick == 109) {
                                    mech.removeTag("script.landed");
                                    mech.removeTag("no_tp");
                                    mech.triggerEvent("spark:mobile");
                                    // enable panel here!
                                    let panels = this.dimension.getEntities({ type: "spark:droid_station", excludeTags: ["final_prison_panel"] });
                                    if (panels.length > 0) {
                                        for (let i = 0; i < panels.length; i++) {
                                            let panel = panels[i];
                                            if (isPointInsideAABB(panel.location, bounds.bounds.min, bounds.bounds.max)) {
                                                panel.triggerEvent("spark:allow_interaction");
                                            }
                                        }
                                    }
                                    this.subState = 2;
                                    this.save();
                                    self.disable();
                                }
                            });
                            mech.addTag("script.landed");
                        }
                    }
                }
            }
            self.internalCounter++;
        });
    }
    // ------------------------------------- //
    // ---------- escape sequence ---------- //
    // ------------------------------------- //
    differDecorations() {
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5942.5, y: -59, z: 2876.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6005.5, y: -59, z: 2899.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5927.5, y: -50, z: 2916.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5875.5, y: -50, z: 2916.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5875.5, y: -50, z: 2982.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5927.5, y: -50, z: 2982.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5927.5, y: -50, z: 2982.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:prison_exit_door", { x: 5933.5, y: -50, z: 2933.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:prison_exit_door", { x: 5869.5, y: -50, z: 2965.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5875.5, y: -50, z: 3132.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5927.5, y: -50, z: 3132.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5927.5, y: -50, z: 3079.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 5875.5, y: -50, z: 3079.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6000.5, y: -53, z: 3250.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
    }
    drawVisualElements() {
        // ship escape time | "hud:battleship_timer:§r"
        let players = this.dimension.getPlayers();
        let text = `hud:battleship_timer:§x${this.ticksToDisplayTime(this.labrinthTime)}`;
        for (let i = 0; i < players.length; i++) {
            let player = players[i];
            player.onScreenDisplay.setTitle(text);
        }
        // boss time
        if (this.inBossFight) {
            let totalSeconds = Math.floor(this.currentBossTime / 20);
            let minutes = Math.floor(totalSeconds / 60);
            let seconds = totalSeconds % 60;
            let board = world.scoreboard.getObjective(this.scoreboardName);
            board.setScore(".bminute", minutes);
            board.setScore(".bsecond", seconds);
        }
    }
    ticksToDisplayTime(ticks) {
        let totalSeconds = Math.floor(ticks / 20);
        let minutes = Math.floor(totalSeconds / 60);
        let seconds = totalSeconds % 60;
        return `${pad(minutes)}:${pad(seconds)}`;
        function pad(value) {
            let z = value.toString().length;
            return z == 1 ? "0" + value.toString() : value.toString();
        }
    }
    // ------------------------------ //
    // ---------- internal ---------- //
    // ------------------------------ //
    setupCh07c05() {
        let cutsceneLength = 162;
        // clear old stuff
        this.patrols = [];
        this.sequence.stop();
        this.sequence.clear();
        // remove this, do it all at the start of the fight
        this.sequence.createStepOnTick(1, (tick) => {
            this.dimension.runCommandAsync("function spark/cutscene/start_ch07_c05");
            // music
            this.dimension.runCommandAsync("music stop 4.0");
            // remove clones
            let clones = this.dimension.getEntities({ type: "spark:clone_trooper" });
            for (const c of clones) {
                c.despawn();
            }
        });
        // also make the battle without the boss
        this.sequence.createStepOnTick(cutsceneLength + 5, (tick) => {
            let players = this.dimension.getPlayers();
            LEVEL_MANAGER.differCommand("summon spark:gunship 6108.5 -47.50 3088.5 -90 0", { x: 6108.5, y: -47.50, z: 3088.5 }, this.dimension);
            for (let i = 0; i < players.length; i++) {
                let p = players[i];
                // p.fadeIn();
                p.disableCutsceneSettings();
                p.setDefaultHotbarLoadout();
            }
            // do boss things
            this.initBossFight();
        });
        this.sequence.start();
    }
    // -------------------------------- //
    // ---------- boss fight ---------- //
    // -------------------------------- //
    // give back control to the player
    // give equipment back
    // set task with time
    initBossFight() {
        this.currentBossTime = this.defaultBossTime;
        // init will act as a reset too
        // remove enemy tag stuff
        // remove the two respawn doors
        // remove arena circle if required
        // 6139.19 -61.64 3201.62 6030.53 -16.76 3030.51
        let bounds = computeBounds({
            x: 6139,
            y: -61,
            z: 3201
        }, {
            x: 6030,
            y: -16,
            z: 3030
        });
        // despawn all doors
        let doors = this.dimension.getEntities({ type: "spark:dreadnaught_gate" });
        if (doors.length > 0) {
            for (const door of doors) {
                if (isPointInsideAABB(door.location, bounds.min, bounds.max)) {
                    door.despawn();
                }
            }
        }
        // despawn all enemy
        let enemies = this.dimension.getEntities({ families: ["enemy"] });
        if (enemies.length > 0) {
            for (const enemy of enemies) {
                if (isPointInsideAABB(enemy.location, bounds.min, bounds.max)) {
                    enemy.despawn();
                }
            }
        }
        // despawn boss
        let boss = this.dimension.getEntities({ families: ["general_grievous"] });
        if (boss.length > 0) {
            for (const gre of boss) {
                if (isPointInsideAABB(gre.location, bounds.min, bounds.max)) {
                    gre.despawn();
                }
            }
        }
        // spawn everything above!
        // center door 6036.5 -53 3115.5 east (locked)
        // left door 6062.5 -53 3057.5 north
        // right door 6062.5 -53 3173.5 north
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6036.5, y: -53, z: 3115.5 }, this.dimension, undefined, undefined, [], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6062.5, y: -53, z: 3057.5 }, this.dimension, undefined, undefined, [], ["spark:door_north", "spark:disable_despawn_after_open"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6062.5, y: -53, z: 3173.5 }, this.dimension, undefined, undefined, [], ["spark:door_north", "spark:disable_despawn_after_open"]);
        this.differBossRoomDecorations();
        // summon boss
        LEVEL_MANAGER.differSpawn("spark:general_grievous", { x: 6079.5, y: -53, z: 3115.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        }, [], ["spark:set_boss", "spark:set_mode_chasing"]);
        // summon guards [6081.5 -53 3121.5 90 0] [6083.5 -53 3118.5 90 0] [6083.5 -53 3112.5 90 0] [6081.5 -53 3109.5 90 0]
        // LEVEL_MANAGER.differCommand("summon spark:magna_guard 6081.5 -53 3121.5 90 0 spark:mobile", { x: 6079.5, y: -53, z: 3115.5 }, this.dimension);
        // old spawning of guards
        LEVEL_MANAGER.differSpawn("spark:magna_guard", { x: 6083.5, y: -53, z: 3118.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        }, ["magna.left"], ["spark:mobile"]);
        LEVEL_MANAGER.differSpawn("spark:magna_guard", { x: 6083.5, y: -53, z: 3112.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        }, ["magna.right"], ["spark:mobile"]);
        // if (this.leftGuardDead == 0) {
        //     // LEVEL_MANAGER.differCommand("summon spark:magna_guard 6083.5 -53 3118.5 90 0 spark:mobile", { x: 6079.5, y: -53, z: 3115.5 }, this.dimension);
        //     LEVEL_MANAGER.differSpawn("spark:magna_guard", { x: 6083.5, y: -53, z: 3118.5 }, this.dimension,
        //         undefined,
        //         (e: Entity) => {
        //             e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        //         },
        //         ["magna.left"], ["spark:mobile"]);
        // }
        // if (this.rightGuardDead == 0) {
        //     // LEVEL_MANAGER.differCommand("summon spark:magna_guard 6083.5 -53 3112.5 90 0 spark:mobile", { x: 6079.5, y: -53, z: 3115.5 }, this.dimension);
        //     LEVEL_MANAGER.differSpawn("spark:magna_guard", { x: 6083.5, y: -53, z: 3112.5 }, this.dimension,
        //         undefined,
        //         (e: Entity) => {
        //             e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        //         },
        //         ["magna.right"], ["spark:mobile"]);
        // }
        // music
        this.dimension.runCommandAsync("music play sound.spark.music.GeneralGrievous 1.0 0.1 loop");
        // summon droids (15)
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6067.5, y: -53, z: 3097.5 }, this.dimension);
        LEVEL_MANAGER.differSpawn("spark:b1_battle_droid", { x: 6064.5, y: -53, z: 3097.5 }, this.dimension);
        LEVEL_MANAGER.differSpawn("spark:b1_battle_droid", { x: 6060.5, y: -53, z: 3097.5 }, this.dimension);
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6057.5, y: -53, z: 3097.5 }, this.dimension);
        // rotation
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6058.5, y: -53, z: 3134.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 180 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b1_battle_droid", { x: 6061.5, y: -53, z: 3134.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 180 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b1_battle_droid", { x: 6064.5, y: -53, z: 3134.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 180 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b1_battle_droid", { x: 6067.5, y: -53, z: 3134.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 180 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6070.5, y: -53, z: 3134.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 180 } });
        });
        // more rotation
        LEVEL_MANAGER.differSpawn("spark:droideka", { x: 6098.5, y: -53, z: 3130.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 100 } });
        });
        LEVEL_MANAGER.differSpawn("spark:droideka", { x: 6098.5, y: -53, z: 3100.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 70 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6101.5, y: -53, z: 3125.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6101.5, y: -53, z: 3105.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6101.5, y: -53, z: 3121.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        });
        LEVEL_MANAGER.differSpawn("spark:b2_battle_droid", { x: 6101.5, y: -53, z: 3109.5 }, this.dimension, undefined, (e) => {
            e.teleport(e.location, { rotation: { x: 0, y: 90 } });
        });
        // disable task and play new one!
        // teleport players [6038.5 -53 3115.5 -90 0]
        for (const player of this.dimension.getPlayers()) {
            player.setTask(5002);
            player.teleport({ x: 6056.5, y: -53, z: 3115.5 }, { facingLocation: { x: 6079.5, y: -53, z: 3115.5 } });
            this.playerDeathPoints.set(player.id, [{ x: 6038.5, y: -53, z: 3115.5 }, { x: 0, y: 0 }]);
            player.setSpawnPoint({ dimension: this.dimension, x: 6038.5, y: -53, z: 3115.5 });
        }
        this.inBossFight = true;
        this.inLabrinth = false;
        // trigger for all of this!
        this.bossTrigger = this.createTrigger(bounds.min, bounds.max, (self) => {
            // information
            let players = this.dimension.getPlayers();
            let playerCount = players.length;
            let leftPush = computeBounds({ x: 6057, y: -53, z: 3059 }, { x: 6067, y: -46, z: 3061 });
            let rightPush = computeBounds({ x: 6067, y: -53, z: 3171 }, { x: 6057, y: -46, z: 3169 });
            let leftSpawnZone = computeBounds({ x: 6066, y: -53, z: 3054 }, { x: 6057, y: -51, z: 3048 });
            let rightSpawnZone = computeBounds({ x: 6058, y: -53, z: 3176 }, { x: 6066, y: -51, z: 3182 });
            let leftDoorZone = computeBounds({ x: 6072, y: -53, z: 3063 }, { x: 6055, y: -50, z: 3036 });
            let rightDoorZone = computeBounds({ x: 6055, y: -53, z: 3167 }, { x: 6069, y: -50, z: 3194 });
            let activationCircle = { x: 6109.5, y: -53, z: 3095.5 };
            // boss time
            this.currentBossTime = clamp(--this.currentBossTime, 0, Number.POSITIVE_INFINITY);
            // general boss control
            // if bossTime == 0 and there isnt an exit point, summon it
            if (this.currentBossTime == 0) {
                let exitPoint = this.dimension.getEntities({ type: "spark:activation_circle", location: activationCircle, maxDistance: 1 });
                if (exitPoint.length == 0) {
                    LEVEL_MANAGER.differSpawn("spark:activation_circle", activationCircle, this.dimension, undefined, undefined, [], ["spark:enable", "spark:activate"]);
                    // set task
                    for (const player of players) {
                        player.setTask(5003);
                        player.sendAnnouncement("battleship.dreadnought.announcement.ship_repaired.announcement1", "sound.spark.raid_cleared");
                    }
                }
                if (exitPoint.length > 0) {
                    // if any player is in the exit point, end and goto the next stage
                    for (const player of players) {
                        if (Vector.distance(exitPoint[0].location, player.location) < 3) {
                            // we are finished!
                            // queue next actions
                            this.setupPostBossFight();
                            this.state = 4;
                            this.subState = 0;
                            this.save();
                            self.disable();
                        }
                    }
                }
            }
            // manga stuff
            let leftGuard = this.dimension.getEntities({ type: "spark:magna_guard", tags: ["magna.left"] });
            if (leftGuard.length == 0) {
                this.leftGuardDead = 1;
            }
            let rightGuard = this.dimension.getEntities({ type: "spark:magna_guard", tags: ["magna.right"] });
            if (rightGuard.length == 0) {
                this.rightGuardDead = 1;
            }
            // if there is only one player, and they die, reset
            // will call the correct function elsewere
            if (playerCount == 1) {
                for (const player of players) {
                    if (player.hasTag("death_sequence")) {
                        self.disable();
                    }
                }
            }
            this.bossSummonTimer--;
        });
    }
    // --------------------------------- //
    // ---------- final stuff ---------- //
    // --------------------------------- //
    setupPostBossFight() {
        this.sequence.stop();
        this.sequence.clear();
        let cutsceneLength = 302;
        this.inBossFight = false;
        this.inLabrinth = false;
        this.sequence.createStepOnTick(0, (tick) => {
            // music
            this.dimension.runCommandAsync("music stop 5.0");
            // display escape announcement
            let players = this.dimension.getPlayers();
            // let announcement: RawMessage = {
            //     rawtext: [
            //         {
            //             text: "hud:announce:"
            //         },
            //         {
            //             translate: "battleship.dreadnought.announcement.escape_successful.announcement1"
            //         }
            //     ]
            // }
            for (let i = 0; i < players.length; i++) {
                let p = players[i];
                p.setTask(0); // disable task
                // p.onScreenDisplay.setActionBar(announcement);
                // // sound
                p.playSound("sound.spark.success_major");
            }
            // music
            this.dimension.runCommandAsync("music stop 3.0");
            world.playMusic("sound.spark.music_meadow_picnic", { volume: 1.0, fade: 0.1 });
            world.queueMusic("sound.spark.ambience_spaceship_small", { volume: 1.0, fade: 0.1, loop: true });
        }, 0);
        // wait for a little bit!
        this.sequence.createStepOnTick(40, (tick) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                let p = players[i];
                p.fadeOut();
                p.clearPersistentUI();
                // remove timer
            }
        }, 1);
        this.sequence.createStepBetweenRange(41, 50, (tick) => {
            let players = this.dimension.getPlayers();
            let raw = {
                text: "hud:battleship_timer:"
            };
            // spam remove timer, as its very buggy!
            for (let i = 0; i < players.length; i++) {
                let p = players[i];
                p.onScreenDisplay.setTitle(raw);
            }
        }, 2);
        // wait for a little bit!
        this.sequence.createStepOnTick(51, (tick) => {
            // disable movement on mobs and stuff
            let boss = this.dimension.getEntities({ type: "spark:general_grievous" });
            if (boss.length > 0) {
                boss[0].despawn();
            }
            let otherMobs = this.dimension.getEntities({ families: ["enemy"] });
            for (let i = 0; i < otherMobs.length; i++) {
                // ehh, should be fine for now!
                otherMobs[i].despawn();
            }
            // remove other stuff
            let exitPoint = this.dimension.getEntities({ type: "spark:activation_circle", location: { x: 6109.5, y: -53, z: 3095.5 }, maxDistance: 1 });
            for (const e of exitPoint) {
                e.despawn();
            }
            // remove ship spark:gunship 6108.5 -47.50 3088.5
            let ship = this.dimension.getEntities({ type: "spark:gunship", location: { x: 6108.5, y: -47.50, z: 3088.5 }, maxDistance: 2 });
            for (const s of ship) {
                s.despawn();
            }
            this.dimension.runCommandAsync("function spark/cutscene/start_ch07_c06");
        }, 3);
        // last part :D
        // nuke from orbit!
        this.sequence.createStepBetweenRange(61, 9999, (tick) => {
            let board = world.scoreboard.getObjective("CS_timer");
            if (board == undefined)
                return;
            let time = board.getScore(".timer");
            if (time != undefined) {
                if (time == 320) {
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        let p = players[i];
                        p.teleport({ x: 6043.5, y: -41, z: 2754.5 }, { facingLocation: { x: 6043.5, y: -40.5, z: 2740.5 } });
                        p.fadeIn();
                        p.disableCutsceneSettings();
                        p.setDefaultHotbarLoadout();
                    }
                    this.state = 5;
                    this.save();
                    this.sequence.stop();
                    this.finalVenator();
                }
            }
        }, 4);
        // wont need a check here, yay!
        this.sequence.start(this.subState);
    }
    finalVenator() {
        const zoneAABB = computeBounds({
            x: 6026,
            y: -28,
            z: 2729.87
        }, {
            x: 6062,
            y: -48,
            z: 2779.20
        });
        this.createTrigger(zoneAABB.min, zoneAABB.max, (self) => {
            // differ spawning
            LEVEL_MANAGER.differSpawn("spark:anakin_skywalker", this.anakinSpawn, this.dimension, undefined, (e) => {
                e.teleport(e.location, { rotation: { x: 0, y: 70 } });
            }, ["has_quest"], ["spark:quest_npc"]);
            LEVEL_MANAGER.differSpawn("spark:ahsoka_tano", this.ahsokaSpawn, this.dimension, undefined, (e) => {
                e.teleport(e.location, { rotation: { x: 0, y: -30 } });
            });
            // queue action for making anakin do things and setting location for player
            this.createTrigger(this.venatorDialogueZone.min, this.venatorDialogueZone.max, (self) => {
                const anakin = this.dimension.getEntities({ type: "spark:anakin_skywalker", location: this.anakinSpawn, maxDistance: 2 });
                if (anakin.length > 0) {
                    setDialogue(anakin[0], "spark:venator.anakin.escape_congratulations");
                    self.disable();
                }
            });
            // queue displays
            LEVEL_MANAGER.queueAction(20, (tick) => {
                if (tick == 19) {
                    for (const player of this.dimension.getPlayers()) {
                        player.displayLocation(LocationLang.Venator);
                    }
                }
            });
            LEVEL_MANAGER.queueAction(100, (tick) => {
                if (tick != 99)
                    return;
                // display escape time
                // convert time to string
                let raw = {
                    rawtext: [
                        {
                            text: "hud:announce:§x",
                        },
                        {
                            translate: "battleship.dreadnought.announcement.escape_time.announcement1",
                            with: [this.ticksToDisplayTime(this.labrinthTime)]
                        }
                    ]
                };
                for (const player of this.dimension.getPlayers()) {
                    player.onScreenDisplay.setActionBar(raw);
                }
                // set labrinth time
                if (world.scoreboard.getObjective("lv_escape_level_achievements") == undefined) {
                    world.scoreboard.addObjective("lv_escape_level_achievements", "");
                    world.scoreboard.getObjective("lv_escape_level_achievements").setScore("fastest_time", this.labrinthTime);
                    world.scoreboard.getObjective("lv_escape_level_achievements").setScore("target_time", labrinthAchievementTime);
                }
                world.scoreboard.getObjective("lv_escape_level_achievements").setScore("fastest_time", this.labrinthTime);
            });
            self.disable();
        });
        this.createTrigger(zoneAABB.min, zoneAABB.max, (self) => {
            // if anakin has the tag, trigger cutscene 
            // and give achievment!
            const ahsoka = this.dimension.getEntities({ type: "spark:ahsoka_tano", location: this.ahsokaSpawn, maxDistance: 1 });
            if (ahsoka.length > 0) {
                if (ahsoka[0].hasTag("venator.2.accepted")) {
                    // trigger cutscenes
                    ahsoka[0].removeTag("venator.2.accepted");
                    // load first cutscene thing
                    this.setupCh07c07();
                    self.disabled = true;
                }
            }
        });
    }
    setupCh07c07() {
        // lock input, do achievement
        // wait a few seconds
        // teleport back, done!
        this.sequence.stop();
        this.sequence.clear();
        this.sequence.createStepOnTick(81, () => {
            this.dimension.runCommandAsync("function spark/cutscene/start_ch02_c11");
        });
        LEVEL_MANAGER.addParallelAction(660, (tick) => {
            if (tick == 559) {
                for (const player of world.getDimension("overworld").getPlayers({ tags: ["is_host"] })) {
                    player.runCommandAsync("function spark/achievement/trigger/escape");
                }
            }
            if (tick == 659) {
                let targetTime = world.scoreboard.getObjective("lv_escape_level_achievements").getScore("target_time");
                if (this.labrinthTime <= targetTime) {
                    // display achievement and stuff
                    this.dimension.runCommandAsync("function spark/achievement/trigger/escape_post");
                }
                this.stop();
            }
        });
        this.sequence.start();
    }
    // ------------------------------ //
    // ---------- internal ---------- //
    // ------------------------------ //
    checkForOldEntities(uniqueValue) {
        for (const entity of this.dimension.getEntities({ excludeTypes: ["minecraft:player", "spark:astromech", "spark:venator_bridge_door", "spark:venator_screen", "spark:venator_holo_table", "spark:clone_trooper"] })) {
            if (!entity.isValid())
                continue;
            if (isPointInsideAABB(entity.location, this.levelBounds.min, this.levelBounds.max)) {
                if (entity.hasTag("no_delete"))
                    continue;
                // get its unique level tag
                let uniqueTag = getTagThatContains(entity, "unique_pf_");
                if (uniqueTag != undefined) {
                    if (uniqueTag !== uniqueValue) {
                        // this is an entity to remove
                        if (entity.hasTag("force_cube")) {
                            entity.runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                            continue;
                        }
                        // else run normal despawn
                        entity.despawn();
                    }
                }
            }
        }
    }
    cleanup() {
        // get all scoreboards and zero the values
        resetBoard(this.scoreboardName);
        resetBoard("escape_zones");
        resetBoard("escape_patrols");
        this.state = 0;
        this.subState = 1;
        this.dimension = world.getDimension("overworld");
        // init stuff
        this.clones = [];
        this.enemies = [];
        // astromech
        this.astromechLerpCache = new Map();
        this.astromechUnlockTime = new Map();
        this.stationDoorMappings = new Map();
        this.patrols = [];
        this.labrinthTime = 0;
        this.defaultBossTime = 20 * 90;
        // this.defaultBossTime = 20 * 10;
        this.deathCounter = 0;
        this.bossDeaths = 0;
        this.bossSummonTimer = 0;
        this.playerDeathTimer = new Map();
        this.playerDeathPoints = new Map();
        this.bossTrigger = undefined;
    }
    handleScriptEvent(command) {
        if (command.length > 0) {
            if (command[0] == "start") {
                this.start();
                this.load();
            }
            if (command[0] == "stop") {
                this.stop();
            }
            if (command[0] == "goto") {
                if (command[1] == "venator") {
                    this.setupStartSequence();
                    this.running = true;
                    // set running status in engine board
                    const boardName = "active_state";
                    if (world.scoreboard.getObjective(boardName) != undefined) {
                        world.scoreboard.getObjective(boardName).setScore(this.levelName, 1);
                    }
                }
                if (command[1] == "prison") {
                    this.running = true;
                    // set running status in engine board
                    const boardName = "active_state";
                    if (world.scoreboard.getObjective(boardName) != undefined) {
                        world.scoreboard.getObjective(boardName).setScore(this.levelName, 1);
                    }
                    this.setupPrisonSequence();
                }
                if (command[1] == "boss") {
                    this.running = true;
                    // set running status in engine board
                    const boardName = "active_state";
                    if (world.scoreboard.getObjective(boardName) != undefined) {
                        world.scoreboard.getObjective(boardName).setScore(this.levelName, 1);
                    }
                    this.setupCh07c05();
                }
                if (command[1] == "ending") {
                    this.running = true;
                    this.setupPostBossFight();
                }
            }
            if (command[0] == "test") {
                for (const player of this.dimension.getPlayers()) {
                    player.runCommandAsync("function spark/achievement/trigger/escape");
                }
                // this.dimension.runCommandAsync("function spark/achievement/trigger/escape");
            }
        }
    }
    isActive() {
        return this.running;
    }
    load() {
        if (world.scoreboard.getObjective(this.scoreboardName) == undefined) {
            // we are going to create the board, and we do not need to load anything!
            let board = world.scoreboard.addObjective(this.scoreboardName, "");
            board.setScore("state", this.state);
            board.setScore("subState", this.subState);
            board.setScore("labrinth_time", 0);
            board.setScore("deaths", 0);
            board.setScore("lgd", 0);
            board.setScore("rgd", 0);
            board.setScore("sound", 0);
            return;
        }
        // boards exists, load the values from here!
        let board = world.scoreboard.getObjective(this.scoreboardName);
        // so this line it funny to me... we just checked for this on line 26, but in strict mode we have to again...
        if (board != undefined) {
            if (!board.hasParticipant("state"))
                board.setScore("state", this.state);
            this.state = board.getScore("state");
            if (!board.hasParticipant("subState"))
                board.setScore("subState", this.subState);
            this.subState = board.getScore("subState");
            if (!board.hasParticipant("labrinth_time"))
                board.setScore("labrinth_time", this.labrinthTime);
            this.labrinthTime = board.getScore("labrinth_time");
            if (!board.hasParticipant("deaths"))
                board.setScore("deaths", this.deathCounter);
            this.deathCounter = board.getScore("deaths");
            if (!board.hasParticipant("lgd"))
                board.setScore("lgd", this.leftGuardDead);
            this.leftGuardDead = board.getScore("lgd");
            if (!board.hasParticipant("rgd"))
                board.setScore("rgd", this.rightGuardDead);
            this.rightGuardDead = board.getScore("rgd");
            if (!board.hasParticipant("sound"))
                board.setScore("sound", this.soundTick);
            this.soundTick = board.getScore("sound");
        }
        switch (this.state) {
            case 0:
                this.setupStartSequence();
                break;
            case 1:
                this.setupPrisonSequence();
                break;
            case 2:
                this.generateLabrinthDoors();
                this.generatePatrols();
                this.differDecorations();
                this.inLabrinth = true;
                break;
            case 3:
                this.setupCh07c05();
                this.inBossFight = true;
                break;
            case 4:
                this.setupPostBossFight();
                break;
            case 5:
                this.finalVenator();
                break;
        }
    }
    save() {
        let boardName = `lv_${this.levelName}`;
        if (world.scoreboard.getObjective(boardName) == undefined) {
            // we are going to create the board, and we do not need to load anything!
            let board = world.scoreboard.addObjective(boardName, "");
            board.setScore("state", this.state);
            board.setScore("subState", this.subState);
            board.setScore("labrinth_time", 0);
            board.setScore("deaths", 0);
            board.setScore("lgd", 0);
            board.setScore("rgd", 0);
            board.setScore("sound", 0);
            return;
        }
        let board = world.scoreboard.getObjective(boardName);
        if (board != undefined) {
            // set state
            board.setScore("state", this.state);
            board.setScore("subState", this.subState);
            board.setScore("labrinth_time", this.labrinthTime);
            board.setScore("deaths", this.deathCounter);
            board.setScore("lgd", this.leftGuardDead);
            board.setScore("rgd", this.rightGuardDead);
            board.setScore("sound", this.soundTick);
        }
    }
    update(tick) {
        if (this.sequence.isActive()) {
            this.subState = this.sequence.activeState;
        }
        this.updateTriggers();
        this.sequence.update();
        this.processDeaths();
        this._processDoorInteractions();
        if (this.inLabrinth) {
            this._collectEntities();
            this._updateClones();
            this._updatePatrols();
            this.labrinthTime++;
            this.drawVisualElements();
            this.soundLoop();
        }
        if (this.inBossFight) {
            this.labrinthTime++;
            this.drawVisualElements();
        }
    }
    // ------------------------------- //
    // ---------- mechanics ---------- //
    // ------------------------------- //
    _mapStationToDoor(tag, ...doors) {
        if (this.stationDoorMappings.has(tag)) {
            throw new Error(`mapping already contains this tag: ${tag}`);
        }
        this.stationDoorMappings.set(tag, doors);
    }
    _collectEntities() {
        this.clones = this.dimension.getEntities({ families: ["clone"] });
        this.enemies = this.dimension.getEntities({ families: ["enemy"] });
    }
    _updateClones() {
        for (const clone of this.dimension.getEntities({ families: ["clone"] })) {
            // these dont work at all!
            let hasFollow = clone.hasTag("following");
            let hasCombat = clone.hasTag("combat");
            let postTransform = clone.hasTag("post_transform");
            // global stuff
            // faster movement
            // teleport it too far away
            let nearestPlayer = this.dimension.getPlayers({ location: clone.location, closest: 1 });
            if (nearestPlayer.length > 0) {
                let player = nearestPlayer[0];
                let dist = Vector.distance(clone.location, player.location);
                if (dist < this.cloneRunDistance) {
                    clone.triggerEvent("spark:make_walk");
                }
                if (dist >= this.cloneRunDistance) {
                    // enable running
                    clone.triggerEvent("spark:make_run");
                }
                if (dist >= this.cloneTeleportDistance) {
                    clone.teleport(player.location);
                }
            }
            // detect if we can see any enemies
            // if no, do normal walking loop
            // if true, do attacking loop
            const canSee = this.canSeeEnemies(clone);
            if (!canSee) {
                if (hasCombat) {
                    // drops our target, only action this tick
                    clone.triggerEvent("spark:drop_target");
                    break;
                }
                // the nearest player is our follow target!
                let nearestPlayer = this.dimension.getPlayers({ location: clone.location, closest: 1 });
                if (nearestPlayer.length == 0)
                    return;
                let player = nearestPlayer[0];
                let dist = Vector.distance(clone.location, player.location);
                if (hasFollow) {
                    let threshold = this.distanceOffsetMax * Math.random();
                    if (threshold > dist)
                        clone.triggerEvent("spark:stop_follow");
                }
                // if we are a greater distance than dist, add follow
                // add a small lag time window
                if (dist > this.distanceOffsetMax + 1) {
                    if (!hasFollow) {
                        clone.triggerEvent("spark:start_follow");
                    }
                }
                continue;
            }
            if (!postTransform)
                break;
            if (hasFollow) {
                // only action this tick
                clone.triggerEvent("spark:drop_target");
                break;
            }
            if (!hasCombat) {
                // also stops following
                // this just spams, the tag detect is taking too long to work
                // think of a nother way to do this...
                clone.triggerEvent("spark:enable_combat");
            }
        }
    }
    // kinda broken right now
    canSeeEnemies(clone) {
        if (this.enemies.length == 0)
            return false;
        for (const enemy of this.enemies) {
            let distnace = Vector.distance(enemy.location, clone.location);
            if (distnace < 32) {
                // if we can see them without getting any block returned
                let blocks = this.dimension.getBlockFromRay(Vector.add(clone.location, new Vector(0, 1.5, 0)), Vector.subtract(enemy.location, clone.location), { maxDistance: distnace, includePassableBlocks: true, includeLiquidBlocks: true });
                if (blocks == undefined)
                    return true;
                if (blocks.block.permutation.matches("minecraft:air"))
                    return true;
            }
        }
        return false;
    }
    // need to alter this so we can 
    _processDoorInteractions() {
        // the detection stage
        const panels = this.dimension.getEntities({ type: "spark:droid_station", tags: ["panel.waiting"] });
        const players = this.dimension.getPlayers({ tags: ["escape.interact.station"] });
        if (panels.length > 0 && players.length > 0) {
            // find a match
            for (let i = 0; i < panels.length; i++) {
                let panel = panels[i];
                if (!panel.hasTag("panel.waiting"))
                    continue;
                for (const player of players) {
                    if (!player.hasTag("escape.interact.station"))
                        continue;
                    // if we close enough to that panel
                    if (Vector.distance(panel.location, player.location) < 7) {
                        // get the players pet
                        let pet = this.getPlayerPet(player);
                        if (pet == undefined) {
                            continue;
                        }
                        if (tagContains(pet, "panel.mv_")) {
                            continue;
                        }
                        // workout what breadcrumb to spawn spark:escape_breadcrumb_1
                        let event = "spark:escape_breadcrumb_" + this.petBreadcrumbIndex;
                        // summon breadcrumb
                        this.summonBreadcrumb(panel);
                        if (!this.panelDroidMappings.has(pet.id)) {
                            this.panelDroidMappings.set(pet.id, panel);
                        }
                        // make astromech move towards it!
                        pet.triggerEvent(event);
                        pet.addTag(`panel.mv_${this.petBreadcrumbIndex}`);
                        pet.addTag(`no_tp`);
                        this.petBreadcrumbIndex++;
                        this.petBreadcrumbIndex = this.petBreadcrumbIndex % 5;
                        if (this.petBreadcrumbIndex == 0) {
                            this.petBreadcrumbIndex = 1;
                        }
                    }
                }
            }
        }
        // at this stage we are doing the normal lerp to the pets target
        // get all droids
        for (const companion of this.dimension.getEntities({ families: ["companion"] })) {
            let targetFamily = `breadcrumb_${this.getTargetBreadcrumb(companion, "panel.mv_")}`;
            // now we process this
            let worldCrumbs = this.dimension.getEntities({ families: [targetFamily] });
            if (worldCrumbs.length > 0) {
                for (const crumb of worldCrumbs) {
                    if (isPointInsideAABB(crumb.location, this.levelBounds.min, this.levelBounds.max)) {
                        // when we are 1 away from that crumb, cache its position for later use
                        if (Vector.distance(crumb.location, companion.location) <= this.astromechCrumbDistance) {
                            this.astromechLerpCache.set(companion.id, crumb.location);
                            crumb.despawn();
                            // freeze companion
                            companion.triggerEvent("spark:immobile");
                            // companion.triggerEvent("spark:freeze");
                        }
                    }
                }
            }
            if (worldCrumbs.length == 0) {
                if (this.panelDroidMappings.has(companion.id)) {
                    let id = this.getTargetBreadcrumb(companion, "panel.mv_");
                    let panel = this.panelDroidMappings.get(companion.id);
                    this.summonBreadcrumb(panel, id);
                }
            }
            // if we are doing the lerp stuff
            if (this.astromechLerpCache.has(companion.id)) {
                if (this.panelDroidMappings.has(companion.id)) {
                    this.panelDroidMappings.delete(companion.id);
                }
                let targetPos = this.astromechLerpCache.get(companion.id);
                let distance = Vector.distance(companion.location, targetPos);
                companion.teleport(Vector.lerp(companion.location, targetPos, distance / 12));
                if (distance < 0.8) {
                    // trigger the event
                    companion.triggerEvent("spark:trigger_open_sequence");
                    // get closest panel, and face that
                    let panel = this.dimension.getEntities({ type: "spark:droid_station", location: companion.location, closest: 1 });
                    if (panel.length > 0) {
                        companion.teleport(targetPos, { facingLocation: panel[0].location });
                        world.playSound("sound.spark.droid_hack", targetPos, { volume: 1.0, pitch: 1.0 });
                        // remove from cache
                        this.astromechLerpCache.delete(companion.id);
                        this.astromechUnlockTime.set(companion.id, this.doorUnlockTimeRequired);
                    }
                }
            }
            // the unlocking time
            // if we have panel.countdown
            if (this.astromechUnlockTime.has(companion.id)) {
                let time = this.astromechUnlockTime.get(companion.id);
                time--;
                this.astromechUnlockTime.set(companion.id, time);
                // if time == 0; unlocks door
                if (time <= 0) {
                    // remove tags and shit
                    this.astromechUnlockTime.delete(companion.id);
                    let tag = getTagThatContains(companion, "panel.mv_");
                    companion.triggerEvent("spark:end_open_sequence");
                    // get player and remove tag
                    let player = this.getPetsPlayer(companion);
                    // remove player tag, should make this be removed on any player join really.
                    player.removeTag("escape.interact.station");
                    if (tag != undefined) {
                        companion.removeTag(tag);
                    }
                    if (companion.hasTag("no_tp")) {
                        companion.removeTag("no_tp");
                    }
                    this.unlockDoor(companion);
                }
            }
        }
    }
    unlockDoor(entity) {
        let station = this.dimension.getEntities({ type: "spark:droid_station", closest: 1, location: entity.location });
        if (station.length > 0) {
            station[0].triggerEvent("spark:finish");
            for (const tag of station[0].getTags()) {
                if (this.stationDoorMappings.has(tag)) {
                    // loop over the locations and open them!
                    for (const v of this.stationDoorMappings.get(tag)) {
                        let door = this.dimension.getEntities({ families: ["door"], location: v, maxDistance: 1 });
                        if (door.length > 0) {
                            door[0].triggerEvent("spark:open_door");
                            world.playSound("sound.spark.dreadnought_door_open", v);
                            // set door as open
                            world.scoreboard.getObjective("escape_zones").setScore(tag, 1);
                            // set players respawn to door location for now
                            for (const player of this.dimension.getPlayers()) {
                                let rot = { x: 0, y: 0 };
                                if (door[0].hasTag("respawn.north"))
                                    rot = { x: 0, y: 180 };
                                if (door[0].hasTag("respawn.south"))
                                    rot = { x: 0, y: 0 };
                                if (door[0].hasTag("respawn.east"))
                                    rot = { x: 0, y: -90 };
                                if (door[0].hasTag("respawn.west"))
                                    rot = { x: 0, y: 90 };
                                this.playerDeathPoints.set(player.id, [door[0].location, rot]);
                                // backup
                                player.setSpawnPoint({ dimension: this.dimension, x: door[0].location.x, y: door[0].location.y, z: door[0].location.z });
                            }
                        }
                    }
                }
                if (this.panelMusicMapping.has(tag)) {
                    this.playCombatMusic();
                }
            }
        }
    }
    getTargetBreadcrumb(entity, matchTag) {
        if (tagContains(entity, matchTag)) {
            let tag = getTagThatContains(entity, matchTag);
            if (tag != undefined) {
                // extract what breadcrumb we are moving to.
                let test = tag.replace(matchTag, '');
                let value = parseInt(test);
                if (value > 0 && value < 5) {
                    return value;
                }
            }
        }
        return -1;
    }
    summonBreadcrumb(panel, idOverride) {
        for (const tag of panel.getTags()) {
            // ~1 ~ ~ east
            // ~-1 ~ ~ west
            // ~ ~ ~1 south
            // ~ ~ ~-1 north
            if (tag == "panel.north") {
                let pos = Vector.add(panel.location, new Vector(0, 0, -1));
                LEVEL_MANAGER.differSpawn(`spark:breadcrumb_${idOverride != undefined ? idOverride : this.petBreadcrumbIndex}`, pos, this.dimension);
                // remove tags
                panel.removeTag("panel.waiting");
                panel.addTag("panel.processing");
                return;
            }
            if (tag == "panel.south") {
                let pos = Vector.add(panel.location, new Vector(0, 0, 1));
                LEVEL_MANAGER.differSpawn(`spark:breadcrumb_${idOverride != undefined ? idOverride : this.petBreadcrumbIndex}`, pos, this.dimension);
                // remove tags
                panel.removeTag("panel.waiting");
                panel.addTag("panel.processing");
                return;
            }
            if (tag == "panel.east") {
                let pos = Vector.add(panel.location, new Vector(1, 0, 0));
                LEVEL_MANAGER.differSpawn(`spark:breadcrumb_${idOverride != undefined ? idOverride : this.petBreadcrumbIndex}`, pos, this.dimension);
                // remove tags
                panel.removeTag("panel.waiting");
                panel.addTag("panel.processing");
                return;
            }
            if (tag == "panel.west") {
                let pos = Vector.add(panel.location, new Vector(-1, 0, 0));
                LEVEL_MANAGER.differSpawn(`spark:breadcrumb_${idOverride != undefined ? idOverride : this.petBreadcrumbIndex}`, pos, this.dimension);
                // remove tags
                panel.removeTag("panel.waiting");
                panel.addTag("panel.processing");
                return;
            }
        }
    }
    getPlayerPet(player) {
        let pScore = world.scoreboard.getObjective("player_id").getScore(player.scoreboardIdentity);
        let petBoard = world.scoreboard.getObjective("pet_id");
        for (const ent of petBoard.getScores()) {
            if (ent.score == pScore) {
                return ent.participant.getEntity();
            }
        }
        return undefined;
    }
    getPetsPlayer(entity) {
        let eScore = world.scoreboard.getObjective("pet_id").getScore(entity.scoreboardIdentity);
        let playerBoard = world.scoreboard.getObjective("player_id");
        for (const ply of playerBoard.getScores()) {
            if (ply.score == eScore) {
                return ply.participant.getEntity();
            }
        }
        return undefined;
    }
    _updatePatrols() {
        for (let i = this.patrols.length - 1; i > -1; i--) {
            let patrol = this.patrols[i];
            // if no player within distance
            for (const player of this.dimension.getPlayers()) {
                if (Vector.distance(player.location, patrol.center) <= patrol.distance) {
                    // loop over the spawns
                    // will spawn in that entity at a random position between min and max
                    if (patrol.spawns.length > 0) {
                        for (const btype of patrol.spawns) {
                            let count = btype[1];
                            let type = btype[0];
                            for (let i = 0; i < count; i++) {
                                let halfY = (patrol.max.y - patrol.min.y) + patrol.min.y;
                                let spawnX = randomRange(patrol.min.x, patrol.max.x);
                                let spawnY = patrol.min.y + 1; // stops fall damage and such
                                let spawnZ = randomRange(patrol.min.z, patrol.max.z);
                                if (type === "spark:droideka") {
                                    LEVEL_MANAGER.differSpawn(type, { x: spawnX, y: spawnY, z: spawnZ }, this.dimension, undefined, undefined, [patrol.tag], []);
                                    continue;
                                }
                                if (type === "b2_battle_droid") { // spark:escape_variant_command_spawned
                                    // LEVEL_MANAGER.differCommand(`summon spark:b2_battle_droid ${spawnX} ${spawnY} ${spawnZ} 0 0 spark:escape_variant_command_spawned`, { x: spawnX, y: spawnY, z: spawnZ }, this.dimension);
                                    LEVEL_MANAGER.differSpawn(type, { x: spawnX, y: spawnY, z: spawnZ }, this.dimension, undefined, undefined, [patrol.tag], ["spark:disable_limb_loss"]);
                                    continue;
                                }
                                LEVEL_MANAGER.differSpawn(type, { x: spawnX, y: spawnY, z: spawnZ }, this.dimension, undefined, undefined, [patrol.tag], ["spark:disable_limb_loss"]);
                            }
                        }
                    }
                    // remove when done
                    world.scoreboard.getObjective("escape_patrols").setScore(patrol.tag, 1);
                    this.patrols.splice(i, 1);
                }
            }
        }
    }
    soundLoop() {
        if (this.soundTick > 0) {
            this.soundTick--;
        }
    }
    playCombatMusic() {
        if (this.soundTick == 0) {
            world.playMusic("sound.spark.music.KesselRunExtended");
            this.soundTick = 20 * 60;
        }
    }
    // ------------------------------------------ //
    // ---------- large spawning stuff ---------- //
    // ------------------------------------------ //
    differBossRoomDecorations() {
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6036.5, y: -53, z: 3159.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6036.5, y: -53, z: 3071.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_east"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6096.5, y: -53, z: 3057.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", { x: 6096.5, y: -53, z: 3173.5 }, this.dimension, undefined, undefined, ["decoration"], ["spark:door_north"]);
    }
    generateLabrinthDoors() {
        // start door
        this.createDifferedDoorZone("pd001", { x: 5896.5, y: -59, z: 2818.5 }, "spark:east", { x: 5901.5, y: -59, z: 2811.5 }, "spark:door_north", "respawn.north", true);
        this.createDifferedDoorZone("pd002", { x: 5869.5, y: -59, z: 2798.5 }, "spark:south", { x: 5866.5, y: -59, z: 2803.5 }, "spark:door_east", "respawn.east");
        this.createDifferedDoorZone("pd003", { x: 5947.5, y: -59, z: 2843.5 }, "spark:west", { x: 5942.5, y: -59, z: 2850.5 }, "spark:door_north", "respawn.south");
        this.createDifferedDoorZone("pd004", { x: 6000.5, y: -59, z: 2853.5 }, "spark:south", { x: 6003.5, y: -59, z: 2858.5 }, "spark:door_east", "respawn.west");
        this.createDifferedDoorZone("pd005", { x: 5901.5, y: -59, z: 2889.5 }, "spark:south", { x: 5901.5, y: -59, z: 2918.5 }, "spark:door_north", "respawn.south", true);
        this.createDifferedDoorZone("pd006", { x: 5896.5, y: -59, z: 2978.5 }, "spark:north", { x: 5901.5, y: -59, z: 2980.5 }, "spark:door_north", "respawn.north");
        this.createDifferedDoorZone("pd007", { x: 5917.5, y: -59, z: 2954.5 }, "spark:west", { x: 5919.5, y: -59, z: 2949.5 }, "spark:door_east", "respawn.east");
        this.createDifferedDoorZone("pd008", { x: 5972.5, y: -59, z: 2954.5 }, "spark:north", { x: 5975.5, y: -59, z: 2949.5 }, "spark:door_east", "respawn.west");
        this.createDifferedDoorZone("pd009", { x: 5960.5, y: -59, z: 2993.5 }, "spark:west", { x: 5955.5, y: -59, z: 2996.5 }, "spark:door_north", "respawn.south");
        this.createDifferedDoorZone("pd010", { x: 5983.5, y: -59, z: 2999.5 }, "spark:south", { x: 5990.5, y: -59, z: 3004.5 }, "spark:door_east", "respawn.west");
        this.createDifferedDoorZone("pd011", { x: 5939.5, y: -59, z: 3045.5 }, "spark:west", { x: 5909.5, y: -59, z: 3045.5 }, "spark:door_east", "respawn.west");
        this.createDifferedDoorZone("pd012", { x: 5885.5, y: -59, z: 2944.5 }, "spark:east", { x: 5883.5, y: -59, z: 2949.5 }, "spark:door_east", "respawn.west");
        this.createDifferedDoorZone("pd013", { x: 5830.5, y: -59, z: 2944.5 }, "spark:south", { x: 5827.5, y: -59, z: 2949.5 }, "spark:door_east", "respawn.east");
        this.createDifferedDoorZone("pd014", { x: 5852.5, y: -59, z: 2993.5 }, "spark:west", { x: 5847.5, y: -59, z: 2996.5 }, "spark:door_north", "respawn.south");
        this.createDifferedDoorZone("pd015", { x: 5815.5, y: -59, z: 2999.5 }, "spark:south", { x: 5812.5, y: -59, z: 3004.5 }, "spark:door_east", "respawn.east");
        this.createDifferedDoorZone("pd016", { x: 5863.5, y: -59, z: 3045.5 }, "spark:east", { x: 5893.5, y: -59, z: 3045.5 }, "spark:door_east", "respawn.east");
        this.createDifferedDoorZone("pd017", { x: 5906.5, y: -59, z: 3078.5 }, "spark:west", { x: 5901.5, y: -59, z: 3081.5 }, "spark:door_north", "respawn.south", true);
        // missing a door here?
        this.createDifferedDoorZone("pd018", { x: 5897.5, y: -53, z: 3129.5 }, "spark:north", { x: 5901.5, y: -53, z: 3131.5 }, "spark:door_north", "respawn.south");
        this.createDifferedDoorZone("pd019", { x: 5930.5, y: -53, z: 3179.5 }, "spark:east", { x: 5942.5, y: -53, z: 3189.5 }, "spark:door_north", "respawn.south", true);
        this.createDifferedDoorZone("pd020", { x: 5937.5, y: -53, z: 3241.5 }, "spark:east", { x: 5942.5, y: -53, z: 3244.5 }, "spark:door_north", "respawn.north");
        this.createDifferedDoorZone("pd021", { x: 5976.5, y: -53, z: 3253.5 }, "spark:west", { x: 5971.5, y: -53, z: 3256.5 }, "spark:door_north", "respawn.north");
        this.createDifferedDoorZone("pd022", { x: 5995.5, y: -53, z: 3199.5 }, "spark:east", { x: 6000.5, y: -53, z: 3192.5 }, "spark:door_north", "respawn.north");
        this.createDifferedDoorZone("pd023", { x: 6029.5, y: -53, z: 3120.5 }, "spark:north", { x: 6036.5, y: -53, z: 3115.5 }, "spark:door_east");
        // final trigger :D
        let zone = computeBounds({ x: 5990, y: -58, z: 3125 }, { x: 6037, y: -41, z: 3106 });
        this.createTrigger(zone.min, zone.max, (self) => {
            // when door opens, goto next stage!
            let door = this.dimension.getEntities({ type: "spark:dreadnaught_gate", location: { x: 6036.5, y: -53, z: 3115.5 }, maxDistance: 1, tags: ["open"] });
            if (door.length > 0) {
                // final door is open
                // goto next
                this.setupCh07c05();
                this.inLabrinth = false;
                this.state = 3;
                this.save();
                self.disable();
            }
        });
    }
    createDifferedDoorZone(tag, panel, panelEvent, door, doorEvent, respawnDirection = "north", musicString = false) {
        // scoreboard stuff
        if (world.scoreboard.getObjective("escape_zones") == undefined) {
            world.scoreboard.addObjective("escape_zones", "");
        }
        const board = world.scoreboard.getObjective("escape_zones");
        if (!board.hasParticipant(tag)) {
            board.setScore(tag, 0);
        }
        let score = board.getScore(tag);
        if (score == 1)
            return;
        // setup differed spawning
        LEVEL_MANAGER.differSpawn("spark:droid_station", panel, this.dimension, undefined, undefined, [tag], [panelEvent, "spark:allow_interaction"]);
        LEVEL_MANAGER.differSpawn("spark:dreadnaught_gate", door, this.dimension, undefined, undefined, [respawnDirection], [doorEvent]);
        // map
        this._mapStationToDoor(tag, door);
        if (musicString) {
            this.panelMusicMapping.add(tag);
        }
    }
    generatePatrols() {
        // section 1
        this.createDifferedPatrolData("pt001", { x: 5904, y: -59, z: 2807 }, { x: 5897, y: -53, z: 2801 }, 20, [["spark:b1_battle_droid", 4]]);
        this.createDifferedPatrolData("pt002", { x: 5850, y: -54, z: 2809 }, { x: 5858, y: -59, z: 2796 }, 25, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt003", { x: 5945, y: -54, z: 2825 }, { x: 5939, y: -59, z: 2814 }, 25, [["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt004", { x: 5945, y: -59, z: 2861 }, { x: 5939, y: -53, z: 2857 }, 20, [["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt005", { x: 5953, y: -59, z: 2855 }, { x: 5959, y: -54, z: 2861 }, 25, [["spark:b1_battle_droid", 3]]);
        this.createDifferedPatrolData("pt006", { x: 6011, y: -59, z: 2852 }, { x: 6018, y: -53, z: 2864 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 2]]);
        // this.createDifferedPatrolData("pt007", { x: 5984, y: -59, z: 2867 }, { x: 5986, y: -56, z: 2889 }, 25, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt008", { x: 5980, y: -59, z: 2902 }, { x: 5972, y: -54, z: 2896 }, 25, [["spark:b1_battle_droid", 4]]);
        this.createDifferedPatrolData("pt009", { x: 5939, y: -59, z: 2890 }, { x: 5945, y: -54, z: 2883 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt010", { x: 5898, y: -59, z: 2915 }, { x: 5904, y: -54, z: 2907 }, 25, [["spark:b2_battle_droid", 3], ["spark:droideka", 2]]);
        // room 1
        this.createDifferedPatrolData("pt011", { x: 5907, y: -59, z: 2938 }, { x: 5895, y: -55, z: 2960 }, 55, [["spark:b1_battle_droid", 8], ["spark:b2_battle_droid", 2], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt011", { x: 5907, y: -59, z: 2987 }, { x: 5895, y: -54, z: 2997 }, 25, [["spark:b1_battle_droid", 4], ["spark:b2_battle_droid", 2]]);
        // section 2 left
        this.createDifferedPatrolData("pt012", { x: 5928, y: -59, z: 2951 }, { x: 5936, y: -55, z: 2947 }, 25, [["spark:b1_battle_droid", 2], ["spark:b2_battle_droid", 2], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt013", { x: 5982, y: -59, z: 2943 }, { x: 5992, y: -53, z: 2955 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt014", { x: 5958, y: -59, z: 2960 }, { x: 5952, y: -54, z: 2968 }, 30, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt015", { x: 5997, y: -59, z: 2998 }, { x: 6007, y: -54, z: 3010 }, 25, [["spark:b1_battle_droid", 2], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt016", { x: 5942, y: -59, z: 3007 }, { x: 5936, y: -54, z: 3001 }, 30, [["spark:b1_battle_droid", 4], ["spark:b2_battle_droid", 1]]);
        this.createDifferedPatrolData("pt017", { x: 5931, y: -59, z: 3012 }, { x: 5925, y: -54, z: 3018 }, 25, [["spark:b1_battle_droid", 4]]);
        this.createDifferedPatrolData("pt018", { x: 5919, y: -59, z: 3042 }, { x: 5913, y: -55, z: 3048 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 1]]);
        // section 2 right
        this.createDifferedPatrolData("pt019", { x: 5874, y: -59, z: 2952 }, { x: 5866, y: -55, z: 2946 }, 25, [["spark:b1_battle_droid", 2], ["spark:b2_battle_droid", 2], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt020", { x: 5819, y: -59, z: 2943 }, { x: 5811, y: -53, z: 2955 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt021", { x: 5850, y: -59, z: 2960 }, { x: 5844, y: -55, z: 2971 }, 30, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt022", { x: 5805, y: -59, z: 2998 }, { x: 5796, y: -54, z: 3010 }, 25, [["spark:b1_battle_droid", 2], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt023", { x: 5860, y: -59, z: 3001 }, { x: 5864, y: -54, z: 3007 }, 30, [["spark:b1_battle_droid", 4], ["spark:b2_battle_droid", 1]]);
        this.createDifferedPatrolData("pt024", { x: 5871, y: -59, z: 3012 }, { x: 5877, y: -54, z: 3018 }, 25, [["spark:b1_battle_droid", 4]]);
        this.createDifferedPatrolData("pt025", { x: 5883, y: -59, z: 3042 }, { x: 5889, y: -54, z: 3048 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 1]]);
        // room 2
        this.createDifferedPatrolData("pt026", { x: 5904, y: -59, z: 3055 }, { x: 5898, y: -54, z: 3061 }, 30, [["spark:b1_battle_droid", 1], ["spark:b2_battle_droid", 1], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt027", { x: 5907, y: -59, z: 3091 }, { x: 5895, y: -53, z: 3113 }, 60, [["spark:b1_battle_droid", 8], ["spark:b2_battle_droid", 4], ["spark:droideka", 2]]);
        // section 3
        this.createDifferedPatrolData("pt028", { x: 5904, y: -53, z: 3140 }, { x: 5898, y: -48, z: 3148 }, 25, [["spark:b1_battle_droid", 2], ["spark:b2_battle_droid", 2], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt029", { x: 5911, y: -53, z: 3164 }, { x: 5921, y: -49, z: 3170 }, 30, [["spark:b1_battle_droid", 3], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt030", { x: 5944, y: -53, z: 3194 }, { x: 5939, y: -49, z: 3202 }, 45, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 3]]);
        this.createDifferedPatrolData("pt031", { x: 5946, y: -53, z: 3250 }, { x: 5936, y: -48, z: 3261 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 2]]);
        this.createDifferedPatrolData("pt032", { x: 5968, y: -53, z: 3243 }, { x: 5974, y: -49, z: 3236 }, 40, [["spark:b1_battle_droid", 4], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt033", { x: 5968, y: -53, z: 3262 }, { x: 5976, y: -48, z: 3274 }, 25, [["spark:b1_battle_droid", 4], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt034", { x: 5997, y: -53, z: 3229 }, { x: 6003, y: -49, z: 3221 }, 30, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
        this.createDifferedPatrolData("pt035", { x: 5997, y: -53, z: 3185 }, { x: 6003, y: -49, z: 3177 }, 25, [["spark:b1_battle_droid", 3], ["spark:droideka", 1]]);
        this.createDifferedPatrolData("pt036", { x: 6011, y: -53, z: 3118 }, { x: 6019, y: -48, z: 3112 }, 30, [["spark:b1_battle_droid", 3], ["spark:b2_battle_droid", 2]]);
    }
    createDifferedPatrolData(tag, boundsX, boundsY, distance, spawns) {
        // scoreboard stuff
        if (world.scoreboard.getObjective("escape_patrols") == undefined) {
            world.scoreboard.addObjective("escape_patrols", "");
        }
        const board = world.scoreboard.getObjective("escape_patrols");
        if (!board.hasParticipant(tag)) {
            board.setScore(tag, 0);
        }
        let score = board.getScore(tag);
        if (score == 1)
            return;
        let zone = computeBounds(boundsX, boundsY);
        this.patrols.push({
            tag: tag,
            distance: distance,
            min: zone.min,
            max: zone.max,
            center: Vector.add(zone.min, Vector.subtract(zone.max, zone.min)),
            spawns: spawns
        });
    }
    processDeaths() {
        for (const player of this.dimension.getPlayers()) {
            if (player.hasTag("death_can_respawn")) {
                player.removeTag("death_can_respawn");
                if (this.inLabrinth) {
                    // if we die here and we have just reloaded, we need to find a default spawnpoint
                    if (this.playerDeathPoints.has(player.id)) {
                        let loc = this.playerDeathPoints.get(player.id);
                        player.teleport(loc[0], { rotation: loc[1] });
                        return;
                    }
                    // if not... 
                    let backup = player.getSpawnPoint();
                    player.teleport({ x: backup.x, y: backup.y, z: backup.z });
                }
                if (this.inBossFight) {
                    // need to disable the trigger here
                    // multiplayer????
                    let count = this.dimension.getPlayers().length;
                    if (count == 1) {
                        if (this.bossTrigger != undefined) {
                            this.bossTrigger.disable();
                        }
                        this.initBossFight();
                    }
                }
            }
        }
    }
}
var cubeNumber = 0;
function summonObstacleMedium(loc, tag = []) {
    tag.push("size_2", "force_cube", `cb_${cubeNumber}`);
    cubeNumber++;
    // differ
    LEVEL_MANAGER.differSpawn("spark:box", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 1; x++) {
            for (let y = 0; y < 2; y++) {
                for (let z = -1; z < 1; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_2"]);
}
