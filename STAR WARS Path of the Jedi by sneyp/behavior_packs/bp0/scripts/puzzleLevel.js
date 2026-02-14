import { BlockPermutation, MolangVariableMap, system, world } from "@minecraft/server";
import { Level, isPositionLoaded } from "./level";
import { LocationLang } from "./extensions";
import { getTagThatContains, randomRange, setDialogue, tagContains } from "./util";
import { computeBounds, isPointInsideAABB } from "./AABB";
import { LEVEL_MANAGER } from "./engine";
import { BlockAreaSize, Vector } from "./Vector";
var c05Length = 200;
export class PuzzleLevel extends Level {
    constructor(name) {
        super(name);
        this.cubeCullingEnforceDistance = 8;
        this.cubeCullingReturnSize = 50;
        this.leftDoor = { x: 6195.5, y: 69, z: 9388.5 };
        this.rightDoor = { x: 6099.5, y: 69, z: 9388.5 };
        this.centerDoor = { x: 6147.5, y: 72, z: 9444.5 };
        this.hubYodaLocation = { x: 6147.5, y: 61, z: 9388.5 };
        this.leftDoorTriggerSendLocation = { x: 5866.5, y: -5, z: 8880.5 };
        this.leftDoorTriggerFaceLocation = { x: 5866.5, y: -4, z: 8846.5 };
        this.centerDoorTriggerSendLocation = { x: 5454.5, y: 106, z: 8793.5 };
        this.centerDoorTriggerFaceLocation = { x: 5454.5, y: 107, z: 8803.5 };
        this.rightDoorTriggerSendLocation = { x: 5744.5, y: -4, z: 8879.5 };
        this.rightDoorTriggerFaceLocation = { x: 5744.5, y: -3, z: 8834.5 };
        this.elevatorStartZone = computeBounds({ x: 5459, y: 120, z: 8838 }, { x: 5449, y: 0, z: 8828 });
        this.doorPaticleOffset = { x: 0, y: 2.0, z: 0 };
        this.particleMap = new MolangVariableMap();
        this.bossFight1SendPos = { x: 5822.5, y: 1, z: 8396.5 };
        this.bossFight1FacePos = { x: 5822.5, y: 2, z: 8383.5 };
        this.bossFight1BossPos = { x: 5822.5, y: 1, z: 8383.5 };
        this.bossFight1BoundsMin = { x: 5800, y: -2, z: 8361 };
        this.bossFight1BoundsMax = { x: 5844, y: 19, z: 8405 };
        this.bossFight2SendPos = { x: 5745.5, y: 1, z: 7957.5 };
        this.bossFight2FacePos = { x: 5745.5, y: 2, z: 7944.5 };
        this.bossFight2BossPos = { x: 5745.5, y: 1, z: 7944.5 };
        this.bossFight2BoundsMin = { x: 5722, y: -1, z: 7921 };
        this.bossFight2BoundsMax = { x: 5767, y: 19, z: 7966 };
        this.defaultBossEvents = ["start_dueling"];
        this.bossRoomDeaths = 0;
        this.yodaTickingArea = 0;
        this.droidPen = computeBounds({ x: 5999, y: 61, z: 9007 }, { x: 6005, y: 61, z: 9012 });
        // 0 = start
        // 1 = hub area
        // 999 = hub area waiting
        // -1 = disabled
        //t1
        this.enteredAnyTemple = 0;
        this.levelBounds = computeBounds({
            x: 6686,
            y: 250,
            z: 9576
        }, {
            x: 5047,
            y: -60,
            z: 7209
        });
        // special respawn zones
        // zones for respawning for both players and cubes!
        this.t3KillZones = [
            [{ x: 5435, y: 95, z: 8814 }, { x: 5473, y: 101, z: 8852 }],
            [{ x: 5347, y: 60, z: 8809 }, { x: 5431, y: 95, z: 8887 }]
        ];
        this.maxRequiredBlocksOnPlate = 3;
        this.resetBoard = function (board) {
            let levelBoard = world.scoreboard.getObjective(board);
            if (levelBoard != undefined) {
                let parts = levelBoard.getParticipants();
                for (let i = parts.length - 1; i > -1; i--) {
                    if (parts[i].displayName != "first_playthrough")
                        levelBoard.removeParticipant(parts[i]);
                }
            }
        };
        let achievementBoard = `lv_${this.levelName}_achievements`;
        if (world.scoreboard.getObjective(achievementBoard) == undefined) {
            world.scoreboard.addObjective(achievementBoard, "");
            world.scoreboard.getObjective(achievementBoard).setScore("finished", 0);
            world.scoreboard.getObjective(achievementBoard).setScore("deathless", 0);
        }
        // set xy
        // this.levelBoundsX = {x:980,y:-5,z:980}; 
        // this.levelBoundsY = {x:1020,y:5,z:1020};
        // 6223 28 9337 6070 109 9475
        const hubBounds = computeBounds({ x: 6223, y: 28, z: 9337 }, { x: 6070, y: 109, z: 9475 });
        this.hubX = hubBounds.min;
        this.hubY = hubBounds.max;
        this.state = 0;
        this.subStep = 0;
        this.hubState = 0;
        this.firstEnter = false;
        this.dimension = world.getDimension("overworld");
        this.leftDoorActive = 0;
        this.centerDoorActive = 0;
        this.rightDoorActive = 0;
        this.hubReturnLocation = { x: 6147.5, y: 61, z: 9385.5 };
        this.huhReturnFacingLocation = { x: 6147.5, y: 61, z: 9388.5 };
        this.triggers = [];
        this.playersOnGround = new Map();
        this.culledCubes = [];
        this.killZones = [];
        this.playerDeathTimer = new Map();
        this.puzzleCounter = 0;
        this.playerDeathPoints = new Map();
        this.t3KillZonesTagMappings = new Map();
        this.bossRoomDeaths = 0;
        this.yodaTickingArea = 0;
        this.t3LeftFinished = 0;
        this.t3TopFinished = 0;
        this.t3RightFinished = 0;
        this.isFirstPlaythrough = 0;
        this.minorDuelZones = [];
        this.majorDuelZones = [];
        this.setupDuelZones();
    }
    loadStartSequence() {
        this.sequence.clear();
        var cutsceneLength = 1 + 476;
        // add in stuff
        this.sequence.createStepOnTick(1, (tick) => {
            // fade all players
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                players[i].clearPersistentUI();
            }
            // ticking area
            this.dimension.runCommandAsync(`tickingarea add circle ${this.droidPen.center.x} ${this.droidPen.center.y} ${this.droidPen.center.z} 2 scripting.astromech.pen true`);
            this.dimension.runCommandAsync("function spark/cutscene/start_ch10_c01");
            // player.playSound("sound.spark.cutscene_custom2_arrival");
        }, 0);
        let postCutscene = cutsceneLength + 1;
        this.sequence.createStepOnTick(postCutscene, (tick) => {
            // end of cutscene
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                let player = players[i];
                player.disableCutsceneSettings();
                player.setDefaultHotbarLoadout();
                // player.teleport({ x: 5999, y: 61, z: 9001 }, { facingLocation: { x: 6006, y: 61, z: 9001 } });
                // player.setSpawnPoint({ dimension: this.dimension, x: 5999.5, y: 60, z: 9001.5 });
                this.setRespawnPoint(player, { x: 5999.5, y: 60, z: 9001.5 });
                // player.fadeIn("sound.spark.transitioner_custom2_ship");
            }
            // queue cubes along path
            summonObstacleMedium({ x: 6129.5, y: 61, z: 9040.5 }, ["free_roam"]);
            summonObstacleMedium({ x: 6104.5, y: 63, z: 8965.5 }, ["free_roam"]);
            summonObstacleMedium({ x: 6210.5, y: 61, z: 9031.5 }, ["free_roam"]);
            summonObstacleMedium({ x: 6264.5, y: 62, z: 9088.5 }, ["free_roam"]);
            summonObstacleLarge({ x: 6316.5, y: 65, z: 9110.5 }, ["free_roam"]);
            summonObstacleLarge({ x: 6206.5, y: 68, z: 9269.5 }, ["free_roam"]);
            // play music
            world.playMusic("sound.spark.music_padme_ruminations", { fade: 1.0, volume: 1.0 });
            world.queueMusic("sound.spark.ambience_custom2_outside", { volume: 1.0, fade: 0.1, loop: true });
            // summon yoda 6004 61 9001
            let isYodaInLocation = this.dimension.getEntities({ type: "spark:yoda", location: { x: 6004.5, y: 61, z: 9001.5 }, maxDistance: 3 });
            if (isYodaInLocation.length > 0) {
                // remove this yoda, teleport and despawn
                isYodaInLocation[0].teleport({ x: 6004, y: -60, z: 9001 });
                isYodaInLocation[0].triggerEvent("spark:despawn");
            }
            LEVEL_MANAGER.differSpawn("spark:yoda", { x: 6004.5, y: 61, z: 9001.5 }, this.dimension, undefined, undefined, [], ["spark:disable_lightsaber", "spark:quest_npc"]);
        }, 1);
        // setup yoda dialogue
        // play location banner
        // play location banner sound
        this.sequence.createStepOnTick(postCutscene + 2, (tick) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                let player = players[i];
                player.displayLocation(LocationLang.Puzzle, "sound.spark.enter_custom2");
                // player.setTask(6001, "sound.spark.quest_major");
            }
            let yoda = this.dimension.getEntities({ type: "spark:yoda", location: { x: 6004, y: 61, z: 9001 }, maxDistance: 3 });
            if (yoda.length > 0) {
                setDialogue(yoda[0], "spark:puzzle.yoda.after_landed");
            }
        }, 2);
        // wait for input, then fade out and in, while removing yoda
        // TODO: make this set the correct subState, and overall state too :D
        this.sequence.createAlwaysActiveStep((tick) => {
            let players = this.dimension.getPlayers();
            if (tick > postCutscene + 2) {
                // if yoda has the correct tag.. yay :D
                let yoda = this.dimension.getEntities({ type: "spark:yoda", tags: ["puzzle.yoda.accepted"], location: { x: 6004, y: 61, z: 9001 }, maxDistance: 3 });
                if (yoda.length > 0) {
                    // remove tag
                    // if yoda has this tag, we need to queue up a fade out and in, and a removal of him
                    let yo = yoda[0];
                    // queue an action here, and end the sequence
                    this.levelManager.queueAction(60, (tick) => {
                        let players = this.dimension.getPlayers();
                        for (let i = 0; i < players.length; i++) {
                            let player = players[i];
                            if (tick == 1) {
                                player.fadeOut();
                            }
                            if (tick == 30) {
                                player.fadeIn();
                            }
                            if (tick == 59) {
                                player.setTask(6001, "sound.spark.quest_major");
                            }
                        }
                        // remove yoda
                        if (tick == 25) {
                            let yoda = this.dimension.getEntities({ type: "spark:yoda", location: { x: 6004, y: 61, z: 9001 }, maxDistance: 3 });
                            if (yoda.length > 0) {
                                let pos = yoda[0].location;
                                pos.y += 100;
                                yoda[0].teleport(pos);
                                yoda[0].triggerEvent("spark:despawn");
                            }
                        }
                    });
                    // set state to 1
                    this.state = 1;
                    this.subStep = 0;
                    // ehh?
                    this.hubState = 0;
                    this.save();
                    // disable sequence
                    this.sequence.stop();
                }
            }
        }, 3);
        this.sequence.start(this.subStep);
        this.createFreeRoamTriggers();
        this.pollKillZones();
    }
    createFreeRoamTriggers() {
        // queue dripleave spawning
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6266.5 63.0 9140.5 180 0", { x: 6266.5, y: 63.0, z: 9140.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6268.5 63.0 9143.5 -90 0", { x: 6268.5, y: 63.0, z: 9143.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6277.5 62.0 9150.5 90 0", { x: 6277.5, y: 62.0, z: 9150.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6279.5 62.0 9153.5 0 0", { x: 6279.5, y: 62.0, z: 9153.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6282.5 63.0 9167.5 180 0", { x: 6282.5, y: 63.0, z: 9167.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6280.5 65.0 9169.5 90 0", { x: 6280.5, y: 65.0, z: 9169.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6284.5 64.0 9181.5 90 0", { x: 6284.5, y: 64.0, z: 9181.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6275.5 63.0 9190.5 180 0", { x: 6275.5, y: 63.0, z: 9190.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6277.5 63.0 9192.5 -90 0", { x: 6277.5, y: 63.0, z: 9192.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6262.5 63.0 9187.5 -90 0", { x: 6262.5, y: 63.0, z: 9187.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6259.5 62.0 9183.5 -180 0", { x: 6259.5, y: 62.0, z: 9183.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6257.5 62.0 9185.5 90 0", { x: 6257.5, y: 62.0, z: 9185.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6333.5 65.0 9137.5 -180 0", { x: 6333.5, y: 65.0, z: 9137.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6331.5 66.0 9139.5 90 0", { x: 6331.5, y: 66.0, z: 9139.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6323.5 65.0 9149.5 -90 0", { x: 6323.5, y: 65.0, z: 9149.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6320.5 66.0 9152.5 0 0", { x: 6320.5, y: 66.0, z: 9152.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6328.5 64.0 9158.5 90 0", { x: 6328.5, y: 64.0, z: 9158.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6327.5 64.0 9169.5 -180 0", { x: 6327.5, y: 64.0, z: 9169.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6327.5 65.0 9173.5 0 0", { x: 6327.5, y: 65.0, z: 9173.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6318.5 64.0 9169.5 -90 0", { x: 6318.5, y: 64.0, z: 9169.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6319.5 65.0 9186.5 -180 0", { x: 6319.5, y: 65.0, z: 9186.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6317.5 64.0 9188.5 90 0", { x: 6317.5, y: 64.0, z: 9188.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6318.5 63.0 9203.5 180 0", { x: 6318.5, y: 63.0, z: 9203.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6315.5 63.0 9205.5 90 0", { x: 6315.5, y: 63.0, z: 9205.5 }, this.dimension);
        // LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6317.5 62.0 9206.5 0 0", { x: 6317.5, y: 62.0, z: 9206.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6312.5 65.0 9226.5 90 0", { x: 6312.5, y: 65.0, z: 9226.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6307.5 65.0 9237.5 90 0", { x: 6307.5, y: 65.0, z: 9237.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6299.5 65.0 9242.5 -90 0", { x: 6299.5, y: 65.0, z: 9242.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6296.5 64.0 9244.5 0 0", { x: 6296.5, y: 64.0, z: 9244.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6294.5 65.0 9255.5 90 0", { x: 6294.5, y: 65.0, z: 9255.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6275.5 65.0 9258.5 -90 0", { x: 6275.5, y: 65.0, z: 9258.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6273.5 64.0 9255.5 -180 0", { x: 6273.5, y: 64.0, z: 9255.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6271.5 64.0 9257.5 90 0", { x: 6271.5, y: 64.0, z: 9257.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6278.5 63.0 9242.5 90 0", { x: 6278.5, y: 63.0, z: 9242.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6279.5 64.0 9240.5 180 0", { x: 6279.5, y: 64.0, z: 9240.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6284.5 64.0 9229.5 90 0", { x: 6284.5, y: 64.0, z: 9229.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6286.5 64.0 9229.5 180 0", { x: 6286.5, y: 64.0, z: 9229.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6315.5 65.0 9225.5 180 0", { x: 6315.5, y: 65.0, z: 9225.5 }, this.dimension);
        LEVEL_MANAGER.differCommand("summon spark:torren_dripleaf 6319.5 64.0 9177.5 -90 0", { x: 6319.5, y: 64.0, z: 9177.5 }, this.dimension);
        // respawn zones
        let leftDeathZoneRespawnX = { x: 6231, y: 53, z: 9031 };
        let leftDeathZoneRespawnY = { x: 6238, y: 67, z: 9054 };
        this.createTrigger(leftDeathZoneRespawnX, leftDeathZoneRespawnY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (isPointInsideAABB(players[i].location, leftDeathZoneRespawnX, leftDeathZoneRespawnY)) {
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: 6233, y: 60, z: 9042 });
                    this.setRespawnPoint(players[i], { x: 6233, y: 60, z: 9042 });
                }
                // remove tutorial message
                players[i].setTutorialMessage(0);
            }
        });
        let rightDeathZoneRespawnX = { x: 6215, y: 47, z: 9064 };
        let rightDeathZoneRespawnY = { x: 6241, y: 61, z: 9098 };
        this.createTrigger(rightDeathZoneRespawnX, rightDeathZoneRespawnY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (isPointInsideAABB(players[i].location, rightDeathZoneRespawnX, rightDeathZoneRespawnY)) {
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: 6217, y: 57, z: 9069 });
                    this.setRespawnPoint(players[i], { x: 6217, y: 57, z: 9069 });
                }
                // remove tutorial message
                players[i].setTutorialMessage(0);
            }
        });
        let rightLeafZoneRespawnX = { x: 6211, y: 53, z: 9175 };
        let rightLeafZoneRespawnY = { x: 6218, y: 66, z: 9196 };
        this.createTrigger(rightLeafZoneRespawnX, rightLeafZoneRespawnY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (isPointInsideAABB(players[i].location, rightLeafZoneRespawnX, rightLeafZoneRespawnY)) {
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: 6240, y: 61, z: 9184 });
                    this.setRespawnPoint(players[i], { x: 6240, y: 61, z: 9184 });
                }
            }
        });
        let centerLeafZoneRespawnX = { x: 6263, y: 59, z: 9106 };
        let centerLeafZoneRespawnY = { x: 6274, y: 69, z: 9122 };
        this.createTrigger(centerLeafZoneRespawnX, centerLeafZoneRespawnY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (isPointInsideAABB(players[i].location, centerLeafZoneRespawnX, centerLeafZoneRespawnY)) {
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: 6268, y: 64, z: 9124 });
                    this.setRespawnPoint(players[i], { x: 6268, y: 64, z: 9124 });
                }
            }
        });
        let leftLeafZoneRespawnX = { x: 6317, y: 56, z: 9117 };
        let leftLeafZoneRespawnY = { x: 6343, y: 69, z: 9127 };
        this.createTrigger(leftLeafZoneRespawnX, leftLeafZoneRespawnY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (isPointInsideAABB(players[i].location, leftLeafZoneRespawnX, leftLeafZoneRespawnY)) {
                    //players[i].setSpawnPoint({ dimension: this.dimension, x: 6332, y: 64, z: 9120 });
                    this.setRespawnPoint(players[i], { x: 6332, y: 64, z: 9120 });
                }
            }
        });
    }
    pollKillZones() {
        // main temple 6088 47 9335 6221 -34 9434
        this.createTrigger({ x: 0, y: 0, z: 0 }, { x: 0, y: 0, z: 0 }, (self) => {
            let players = this.dimension.getPlayers();
            // if a player enters this for the first time, tag them
            for (let i = 0; i < players.length; i++) {
                let player = players[i];
                if (player.hasTag("death"))
                    continue;
                for (let j = 0; j < this.killZones.length; j++) {
                    if (isPointInsideAABB(player.location, this.killZones[j].X, this.killZones[j].Y)) {
                        if (!player.hasTag("death"))
                            player.addTag("death");
                    }
                }
            }
        }, true);
        // the zones (outside)
        this.createKillZone({ x: 6087, y: -35, z: 8999 }, { x: 6422, y: 44, z: 9470 });
        // temple 1
        this.createKillZone({ x: 5829, y: -59, z: 8810 }, { x: 5908, y: -11, z: 8894 });
        this.createKillZone({ x: 5821, y: -63, z: 8585 }, { x: 5916, y: 1, z: 8796 });
        // temple 2
        this.createKillZone({ x: 5724, y: -59, z: 8745 }, { x: 5779, y: -13, z: 8896 });
        this.createKillZone({ x: 5707, y: -60, z: 8573 }, { x: 5803, y: -23, z: 8735 });
        // temple 3 5417 -50 8709 5509 -2 8863
        this.createKillZone({ x: 5417, y: -50, z: 8709 }, { x: 5509, y: -2, z: 8863 });
    }
    createKillZone(x, y) {
        this.killZones.push({ X: x, Y: y });
    }
    createTempleOneTriggers() {
        // spawn
        let t1BoundsX = { x: 5814, y: -62, z: 8492 };
        let t1BoundsY = { x: 5916, y: 115, z: 8894 };
        this.createTrigger(t1BoundsX, t1BoundsY, (self) => {
            if (this.subStep >= 1) {
                self.disable();
                return;
            }
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (this.enteredAnyTemple == 0) {
                    players[i].playSound("sound.spark.enter_sith_temple_minor");
                    // players[i].sendMessage("This temple is currently WIP, only story beats are implemented");
                    players[i].setDefaultHotbarLoadout();
                    players[i].setTutorialMessage(0);
                    // set spawn point
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: this.leftDoorTriggerSendLocation.x, y: this.leftDoorTriggerSendLocation.y, z: this.leftDoorTriggerSendLocation.z });
                    this.setRespawnPoint(players[i], { x: this.leftDoorTriggerSendLocation.x, y: this.leftDoorTriggerSendLocation.y, z: this.leftDoorTriggerSendLocation.z });
                }
            }
            // set entered temple to 1, to disable the on first join sound
            this.enteredAnyTemple = 1;
            // play music
            this.dimension.runCommandAsync("music stop 5.0");
            this.dimension.runCommandAsync("music play sound.spark.ambience_custom2_inside 1.0 0.1");
            // disable this trigger
            self.disabled = true;
        });
        // spawn in holocron (or relic, whatever its called)
        let t1RelicSpawnBoundsX = { x: 5860, y: 1, z: 8691.98 };
        let t1RelicSpawnBoundsY = { x: 5873, y: 27, z: 8707.98 };
        this.createTrigger(t1RelicSpawnBoundsX, t1RelicSpawnBoundsY, (self) => {
            LEVEL_MANAGER.differSpawn("spark:torren_relic_1", { x: 5866.5, y: 22.5, z: 8625.5 }, this.dimension, () => {
                let relicExists = this.dimension.getEntities({ type: "spark:torren_relic_1", maxDistance: 2, location: { x: 5866.5, y: 22.5, z: 8625.5 } });
                if (relicExists.length > 0) {
                    relicExists[0].triggerEvent("spark:despawn");
                }
            });
            // for any other events
            self.disabled = true;
        });
        // create a trigger here that will detect if players are within the dueling areas while the torren_relic_1 exists
        let backupTeleport = this.createTrigger(Vector.zero, Vector.zero, (self) => {
            let inZones = false;
            for (const player of this.dimension.getPlayers()) {
                for (const zone of this.minorDuelZones) {
                    if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                        inZones = true;
                        break;
                    }
                }
            }
            // teleport back to the relic place
            if (inZones) {
                for (const player of this.dimension.getPlayers()) {
                    for (const zone of this.minorDuelZones) {
                        if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                            player.teleport({ x: 5866.5, y: 10.5, z: 8650.5 }, { facingLocation: { x: 5866.5, y: 11.5, z: 8641.5 } });
                            LEVEL_MANAGER.differSpawn("spark:torren_relic_1", { x: 5866.5, y: 22.5, z: 8625.5 }, this.dimension, () => {
                                let relicExists = this.dimension.getEntities({ type: "spark:torren_relic_1", maxDistance: 2, location: { x: 5866.5, y: 22.5, z: 8625.5 } });
                                if (relicExists.length > 0) {
                                    relicExists[0].triggerEvent("spark:despawn");
                                }
                            });
                        }
                    }
                }
            }
        }, true);
        // on interaction with the relic, do the fun stuff!
        let t1RelicRoomBoundsX = { x: 5831, y: -49, z: 8592.53 };
        let t1RelicRoomBoundsY = { x: 5901, y: 100, z: 8691.65 };
        this.createTrigger(t1RelicRoomBoundsX, t1RelicRoomBoundsY, (self) => {
            // need to detect if the relic has a tag, then we play the sequence and teleport to fight room
            // in the fight room we have a skip button or something
            let relic = this.dimension.getEntities({ type: "spark:torren_relic_1", families: ["interacted"], location: { x: 5866.5, y: 22.5, z: 8625.5 }, maxDistance: 2 });
            if (relic.length > 0) {
                // make it invis
                backupTeleport.disable();
                // setup fighting stage
                this.subStep = 3;
                this.save();
                // queue action
                this.levelManager.queueAction(60, (tick) => {
                    // sound.spark.sith_relic_interact
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 1) {
                            players[i].fadeOut();
                            players[i].playSound("sound.spark.sith_relic_interact");
                        }
                        if (tick == 50) {
                            players[i].fadeIn();
                            LEVEL_MANAGER.addParallelAction(21, (tick) => {
                                if (tick != 20)
                                    return;
                                players[i].playSound("sound.spark.sith_fight_begin");
                            });
                        }
                    }
                    if (tick == 30) {
                        // despawn relic
                        relic[0].triggerEvent("spark:despawn");
                        let players = this.dimension.getPlayers();
                        for (let i = 0; i < players.length; i++) {
                            let zone = this.minorDuelZones[i];
                            players[i].teleport(zone.pStart, { facingLocation: zone.pFacing });
                            this.resetArena(zone, "spark:vision_darth_maul", false);
                            // create arena tick here!
                            this.setupArenaTrigger(zone, "spark:vision_darth_maul");
                        }
                        // play music
                        world.playMusic("sound.spark.music.StarWarsROTSA", { loop: true, fade: 2.0 });
                        this.enableDuelSettings();
                    }
                });
                self.disabled = true;
            }
        });
        // detect maul trigger to end (would be death)
        // on reload, this trigger is doing funky shit!
        this.createTrigger(Vector.zero, Vector.zero, (self) => {
            // while in this state we will poll for players in the correct zone
            // once all players have the correct tag, remove tag and goto next stage!
            let finishedPlayers = this.dimension.getPlayers({ tags: ["pz_i_win"] });
            let totalPlayers = this.dimension.getPlayers().length;
            if (totalPlayers == 0) {
                return;
            }
            if (finishedPlayers.length == totalPlayers) {
                this.levelManager.addParallelAction(140, (tick) => {
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 105) {
                            players[i].enableCutsceneSettings();
                            players[i].clearPersistentUI();
                            players[i].fadeOut();
                        }
                    }
                    if (tick == 80) {
                        this.dimension.runCommandAsync("music stop 3.0");
                    }
                    if (tick == 139) {
                        this.levelManager.addParallelAction(90, (tick) => {
                            let players = this.dimension.getPlayers();
                            for (let i = 0; i < players.length; i++) {
                                if (tick == 85) {
                                    players[i].disableCutsceneSettings();
                                    players[i].setDefaultHotbarLoadout();
                                    players[i].teleport(this.hubReturnLocation, { facingLocation: this.huhReturnFacingLocation });
                                    players[i].fadeIn("sound.spark.return_from_vision");
                                    players[i].removeTag("pz_i_win");
                                }
                            }
                            if (tick == 89) {
                                // change settings
                                this.disableDuelSettings();
                                this.createTrigger(this.hubX, this.hubY, (self) => {
                                    let yoda = this.dimension.getEntities({ type: "spark:yoda", location: this.hubYodaLocation, maxDistance: 2 });
                                    if (yoda.length > 0) {
                                        setDialogue(yoda[0], "spark:puzzle.yoda.dooku_story");
                                        self.disable();
                                        // save states
                                        // setup fighting stage
                                        this.subStep = 0;
                                        this.state = 999;
                                        this.save();
                                    }
                                });
                                // LEVEL_MANAGER.differDialogueChange("spark:yoda", "spark:puzzle.yoda.dooku_story", this.hubYodaLocation, this.dimension);
                                this.hubState = 1;
                                this.state = 999;
                            }
                        });
                    }
                });
                self.disable();
                return;
            }
            // notify all of those with the tag that they need to wait
            if (self.internalCounter % 100 == 0) {
                // spark.ui.puzzle.waiting_for_players
                let waiting = this.dimension.getPlayers({ tags: ["pz_i_win"] });
                for (const player of waiting) {
                    player.setTutorialMessage(13);
                    // player.onScreenDisplay.setActionBar({
                    //     translate: "spark.ui.waiting"
                    // });
                }
            }
            self.internalCounter++;
        }, true);
        if (this.subStep < 1) {
            // back up respawn point!
            this.setupPuzzle1();
        }
        if (this.subStep < 2) {
            this.setupPuzzle2();
        }
    }
    setupPuzzle2() {
        // ----- Puzzle 2 ----- //
        // ----- Puzzle 2 ----- //
        // ----- Puzzle 2 ----- //
        // ----- Puzzle 2 ----- //
        // ----- Puzzle 2 ----- //
        // ----- Puzzle 2 ----- //
        // 5830.76 -6.33 8691.47 | 5918.04 40.84 8807.77
        let templeZone2Min = { x: 5830, y: -6, z: 8691 };
        let templeZone2Max = { x: 5918, y: 40, z: 8807 };
        let searchBoundsT2 = new BlockAreaSize(templeZone2Max.x - templeZone2Min.x, templeZone2Max.y - templeZone2Min.y, templeZone2Max.z - templeZone2Min.z);
        // plates
        // redstone 5862 10 8721 
        let redstonePlate = { x: 5862.5, y: 10, z: 8721.5 };
        // diamond 5870 10 8721
        let diamonPlate = { x: 5870.5, y: 10, z: 8721.5 };
        // grey 5862 10 8729
        let greyPlate = { x: 5862.5, y: 10, z: 8729.5 };
        // eme 5870 10 8729 
        let emePlate = { x: 5870.5, y: 10, z: 8729.5 };
        // blocks
        // redstone 5882 14 8746
        let redstoneBlock = { x: 5882.5, y: 16, z: 8746.5 };
        // diamond 5882 8 8762
        let diamondBlock = { x: 5882.5, y: 8, z: 8762.5 };
        // grey 5850 14 8746
        let greyBlock = { x: 5850.5, y: 16, z: 8746.5 };
        // eme 5850 8 8762
        let emeBlock = { x: 5850.5, y: 8, z: 8762.5 };
        // door
        // 5866 10 8692 north
        let p2Door = { x: 5866.5, y: 10, z: 8692.5 };
        // markers
        // redstone 5864 31 8708
        let redstoneMarker = { x: 5864.5, y: 31, z: 8708.5 };
        // diamond 5868 31 8708
        let diamondMarker = { x: 5868.5, y: 31, z: 8708.5 };
        // grey 5864 27 8708
        let greyMarker = { x: 5864.5, y: 27, z: 8708.5 };
        // eme 5868 27 8708
        let emeMarker = { x: 5868.5, y: 27, z: 8708.5 };
        let roomTag2 = "rm2";
        let cubeID = "cb";
        let resetButtonLocation = { x: 5868.5, y: 8, z: 8778.5 };
        let resetButtonEvent = "spark:set_west";
        let redstonePlateSoundEmitter = new PlateSoundEmitter(redstonePlate, this.dimension);
        let diamondPlateSoundEmitter = new PlateSoundEmitter(diamonPlate, this.dimension);
        let greyPlateSoundEmitter = new PlateSoundEmitter(greyPlate, this.dimension);
        let emePlateSoundEmitter = new PlateSoundEmitter(emePlate, this.dimension);
        this.createTrigger(templeZone2Min, templeZone2Max, (self) => {
            // queue action to spawn, then disable
            this.levelManager.queueAction(2, (tick) => {
                if (tick == 1) {
                    // pressure plates
                    summonPressurePlate(redstonePlate, ["rs_p", roomTag2]);
                    summonPressurePlate(diamonPlate, ["di_p", roomTag2]);
                    summonPressurePlate(greyPlate, ["gr_p", roomTag2]);
                    summonPressurePlate(emePlate, ["em_p", roomTag2]);
                    // cubes
                    summonAurebeshObstacle(redstoneBlock, "spark:set_type_0", [cubeID, "rs_cube", "important"]);
                    summonAurebeshObstacle(diamondBlock, "spark:set_type_1", [cubeID, "di_cube", "important"]);
                    summonAurebeshObstacle(greyBlock, "spark:set_type_2", [cubeID, "gr_cube", "important"]);
                    summonAurebeshObstacle(emeBlock, "spark:set_type_3", [cubeID, "em_cube", "important"]);
                    // markers
                    // summonAurebeshObstacleFake(redstoneMarker, "spark:set_type_0", [roomTag2]);
                    // summonAurebeshObstacleFake(diamondMarker, "spark:set_type_1", [roomTag2]);
                    // summonAurebeshObstacleFake(greyMarker, "spark:set_type_2", [roomTag2]);
                    // summonAurebeshObstacleFake(emeMarker, "spark:set_type_3", [roomTag2]);
                    LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag2], [resetButtonEvent]);
                    // door
                    LEVEL_MANAGER.differSpawn("spark:torren_gate_large", p2Door, this.dimension, undefined, undefined, [roomTag2], ["spark:door_north"]);
                    // let centerDoor = this.dimension.spawnEntity("spark:torren_gate_large", p2Door);
                    // centerDoor.triggerEvent("spark:door_north");
                    // centerDoor.addTag(roomTag2);
                    // respawn point
                    for (const player of this.dimension.getPlayers()) {
                        this.setRespawnPoint(player, { x: 5866.5, y: 10, z: 8786.5 });
                    }
                }
            });
            self.disable();
        });
        // functionality
        this.createTrigger(templeZone2Min, templeZone2Max, (self) => {
            let redstonePlatePressed = this.isCubeOnPlate(redstonePlate);
            let diamonPlatePressed = this.isCubeOnPlate(diamonPlate);
            let greyPlatePressed = this.isCubeOnPlate(greyPlate);
            let emePlatePressed = this.isCubeOnPlate(emePlate);
            let isRedstonePlateCorrect = false;
            let isDiamondPlateCorrect = false;
            let isGreyPlateCorrect = false;
            let isEmePlateCorrect = false;
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT1Room2();
                self.disable();
            }
            // if the door is open, skip
            let sectionDoor = this.dimension.getEntities({ type: "spark:torren_gate_large", location: p2Door, maxDistance: 2 });
            if (sectionDoor.length > 0) {
                if (sectionDoor[0].hasTag("open")) {
                    self.disabled = true;
                    return;
                }
                let door = sectionDoor[0];
                if (door.hasTag("redstone") && door.hasTag("diamond") && door.hasTag("grey") && door.hasTag("eme")) {
                    door.triggerEvent("spark:open_door");
                    self.disable();
                    this.subStep = 2;
                    this.save();
                    for (const cubes of this.dimension.getEntities({ type: "spark:torren_obstacle_m", tags: ["important"] })) {
                        if (isPointInsideAABB(cubes.location, templeZone2Min, templeZone2Max)) {
                            cubes.removeTag("important");
                        }
                    }
                    return;
                }
                // while in here, we check all of the cubes and stuff
                if (redstonePlatePressed) {
                    // get entity and detect its variant
                    let cube = this.dimension.getEntities({ tags: [cubeID], location: redstonePlate, maxDistance: 2 });
                    if (cube.length > 0) {
                        // loop over entities and see if its the correct one
                        for (let i = 0; i < cube.length; i++) {
                            if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                                // get variant
                                let variant = cube[0].getComponent("minecraft:variant");
                                if (variant != undefined) {
                                    if (variant.value == 0) {
                                        isRedstonePlateCorrect = true;
                                    }
                                }
                            }
                        }
                    }
                }
                if (diamonPlatePressed) {
                    // get entity and detect its variant
                    let cube = this.dimension.getEntities({ tags: [cubeID], location: diamonPlate, maxDistance: 2 });
                    if (cube.length > 0) {
                        // loop over entities and see if its the correct one
                        for (let i = 0; i < cube.length; i++) {
                            if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                                // get variant
                                let variant = cube[0].getComponent("minecraft:variant");
                                if (variant != undefined) {
                                    if (variant.value == 1) {
                                        isDiamondPlateCorrect = true;
                                    }
                                }
                            }
                        }
                    }
                }
                if (greyPlatePressed) {
                    // get entity and detect its variant
                    let cube = this.dimension.getEntities({ tags: [cubeID], location: greyPlate, maxDistance: 2 });
                    if (cube.length > 0) {
                        // loop over entities and see if its the correct one
                        for (let i = 0; i < cube.length; i++) {
                            if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                                // get variant
                                let variant = cube[0].getComponent("minecraft:variant");
                                if (variant != undefined) {
                                    if (variant.value == 2) {
                                        isGreyPlateCorrect = true;
                                    }
                                }
                            }
                        }
                    }
                }
                if (emePlatePressed) {
                    // get entity and detect its variant
                    let cube = this.dimension.getEntities({ tags: [cubeID], location: emePlate, maxDistance: 2 });
                    if (cube.length > 0) {
                        // loop over entities and see if its the correct one
                        for (let i = 0; i < cube.length; i++) {
                            if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                                // get variant
                                let variant = cube[0].getComponent("minecraft:variant");
                                if (variant != undefined) {
                                    if (variant.value == 3) {
                                        isEmePlateCorrect = true;
                                    }
                                }
                            }
                        }
                    }
                }
                if (isRedstonePlateCorrect) {
                    if (!door.hasTag("redstone")) {
                        door.addTag("redstone");
                    }
                }
                if (isDiamondPlateCorrect) {
                    if (!door.hasTag("diamond")) {
                        door.addTag("diamond");
                    }
                }
                if (isGreyPlateCorrect) {
                    if (!door.hasTag("grey")) {
                        door.addTag("grey");
                    }
                }
                if (isEmePlateCorrect) {
                    if (!door.hasTag("eme")) {
                        door.addTag("eme");
                    }
                }
                redstonePlateSoundEmitter.update(redstonePlatePressed, isRedstonePlateCorrect);
                diamondPlateSoundEmitter.update(diamonPlatePressed, isDiamondPlateCorrect);
                greyPlateSoundEmitter.update(greyPlatePressed, isGreyPlateCorrect);
                emePlateSoundEmitter.update(emePlatePressed, isEmePlateCorrect);
                let rsp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: redstonePlate, maxDistance: 2 });
                if (rsp.length > 0) {
                    rsp[0].triggerEvent(redstonePlatePressed == true ? "spark:press_down" : "spark:press_up");
                }
                let dp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: diamonPlate, maxDistance: 2 });
                if (dp.length > 0) {
                    dp[0].triggerEvent(diamonPlatePressed == true ? "spark:press_down" : "spark:press_up");
                }
                let gp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: greyPlate, maxDistance: 2 });
                if (gp.length > 0) {
                    gp[0].triggerEvent(greyPlatePressed == true ? "spark:press_down" : "spark:press_up");
                }
                let ep = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: emePlate, maxDistance: 2 });
                if (ep.length > 0) {
                    ep[0].triggerEvent(emePlatePressed == true ? "spark:press_down" : "spark:press_up");
                }
            }
            // detect if a cube has fallen into the kill zone
            // { x: 5829, y: -59, z: 8810 }, { x: 5908, y: -11, z: 8894 }
            let boxes = this.dimension.getEntities({ tags: [cubeID] });
            if (boxes.length > 0) {
                for (let i = 0; i < boxes.length; i++) {
                    if (isPointInsideAABB(boxes[i].location, { x: 5821, y: -63, z: 8585 }, { x: 5916, y: 1, z: 8796 })) {
                        let box = boxes[i];
                        if (box.hasTag("removing"))
                            continue;
                        box.runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        box.addTag("removing");
                        // respawn box
                        if (box.hasTag("rs_cube"))
                            summonAurebeshObstacle(redstoneBlock, "spark:set_type_0", [cubeID, "rs_cube", "important"]);
                        if (box.hasTag("di_cube"))
                            summonAurebeshObstacle(diamondBlock, "spark:set_type_1", [cubeID, "di_cube", "important"]);
                        if (box.hasTag("gr_cube"))
                            summonAurebeshObstacle(greyBlock, "spark:set_type_2", [cubeID, "gr_cube", "important"]);
                        if (box.hasTag("em_cube"))
                            summonAurebeshObstacle(emeBlock, "spark:set_type_3", [cubeID, "em_cube", "important"]);
                    }
                }
            }
        });
    }
    setupPuzzle1() {
        // ----- Puzzle 1 ----- //
        // ----- Puzzle 1 ----- //
        // ----- Puzzle 1 ----- //
        // ----- Puzzle 1 ----- //
        // ----- Puzzle 1 ----- //
        // ----- Puzzle 1 ----- //
        // zones for puzzles
        // trigger to spawn the required stuff
        // 2 doors, 1 large doors, 3 normal cubes
        // min 5830 -44 8810
        // max 5901 32 8889
        let templeZone1Min = { x: 5830, y: -44, z: 8810 };
        let templeZone1Max = { x: 5901, y: 32, z: 8889 };
        let searchBounds = new BlockAreaSize(templeZone1Max.x - templeZone1Min.x, templeZone1Max.y - templeZone1Min.y, templeZone1Max.z - templeZone1Min.z);
        let leftPlateLoc = { x: 5859.5, y: -2, z: 8837.5 };
        let rightPlateLoc = { x: 5873.5, y: -2, z: 8837.5 };
        let zone1LeftOb = { x: 5893.5, y: -1, z: 8837.5 };
        let zone1CenterOb = { x: 5866.5, y: -1, z: 8828.5 }; // 5866 -1 8828
        let zone1RightOb = { x: 5839.5, y: -1, z: 8837.5 };
        let cubeID = "cb";
        let roomTag = "rm1";
        let resetButtonLocation = { x: 5868.5, y: -4, z: 8848.5 };
        let resetButtonEvent = "spark:set_west";
        let leftPlateEmitter = new PlateSoundEmitter(leftPlateLoc, this.dimension);
        let rightPlateEmitter = new PlateSoundEmitter(rightPlateLoc, this.dimension);
        // state stuf
        this.createTrigger(templeZone1Min, templeZone1Max, (self) => {
            // queue action to spawn, then disable
            this.levelManager.queueAction(2, (tick) => {
                if (tick == 1) {
                    // pressure plates
                    // 5859 -2 8837 | 5873 -2 8837
                    summonPressurePlate(leftPlateLoc, ["left_plate", roomTag]);
                    summonPressurePlate(rightPlateLoc, ["right_plate", roomTag]);
                    // cubes
                    // 5893 -1 8837 | 5866 -1 8830 | 5839 -1 8837
                    // no tag for the room as we are despawning from another method
                    summonObstacleMedium(zone1LeftOb, [cubeID, "left_cube", "important"]);
                    summonObstacleMedium(zone1CenterOb, [cubeID, "start_cube", "important"]);
                    summonObstacleMedium(zone1RightOb, [cubeID, "right_cube", "important"]);
                    LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag], [resetButtonEvent]);
                    // doors
                    // 5845 -2 8837 east smoll
                    LEVEL_MANAGER.differSpawn("spark:torren_gate_small", { x: 5845.5, y: -2, z: 8837.5 }, this.dimension, undefined, undefined, [roomTag], ["spark:door_east"]);
                    // 5887 -2 8837 east smoll
                    LEVEL_MANAGER.differSpawn("spark:torren_gate_small", { x: 5887.5, y: -2, z: 8837.5 }, this.dimension, undefined, undefined, [roomTag], ["spark:door_east"]);
                    // 5866 10 8814 north large
                    LEVEL_MANAGER.differSpawn("spark:torren_gate_large", { x: 5866.5, y: 10, z: 8814.5 }, this.dimension, undefined, undefined, [roomTag], ["spark:door_north"]);
                    // respawn point
                    for (const player of this.dimension.getPlayers()) {
                        this.setRespawnPoint(player, { x: this.leftDoorTriggerSendLocation.x, y: this.leftDoorTriggerSendLocation.y, z: this.leftDoorTriggerSendLocation.z });
                    }
                }
            });
            self.disabled = true;
        });
        // the functionality in this area
        // keep this in scripting!
        this.createTrigger(templeZone1Min, templeZone1Max, (self) => {
            let leftPlateActive = this.isCubeOnPlate(leftPlateLoc);
            let rightPlateActive = this.isCubeOnPlate(rightPlateLoc);
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT1Room1();
                self.disable();
            }
            // if the door is open, skip
            let sectionDoor = this.dimension.getEntities({ type: "spark:torren_gate_large", location: { x: 5866.5, y: 10, z: 8814.5 }, maxDistance: 2 });
            if (sectionDoor.length > 0) {
                if (sectionDoor[0].hasTag("open")) {
                    self.disabled = true;
                    return;
                }
                // while in here, we check all of the cubes and stuff
                // check for any cube ontop of the plate points
                if (leftPlateActive) {
                    let door = this.dimension.getEntities({ type: "spark:torren_gate_small", location: { x: 5845.5, y: -2, z: 8837.5 }, maxDistance: 2 });
                    if (door.length > 0) {
                        if (door[0].hasTag("closed")) {
                            door[0].triggerEvent("spark:open_door");
                        }
                    }
                }
                if (rightPlateActive) {
                    let door = this.dimension.getEntities({ type: "spark:torren_gate_small", location: { x: 5887.5, y: -2, z: 8837.5 }, maxDistance: 2 });
                    if (door.length > 0) {
                        if (door[0].hasTag("closed")) {
                            door[0].triggerEvent("spark:open_door");
                        }
                    }
                }
                // do proxy check for players 
                // 5858 7 8814
                // 5874 17 8823
                let players = this.dimension.getPlayers();
                if (players.length > 0) {
                    for (let i = 0; i < players.length; i++) {
                        if (isPointInsideAABB(players[i].location, { x: 5858, y: 7, z: 8814 }, { x: 5874, y: 17, z: 8824 })) {
                            // open final door and disable :D
                            sectionDoor[0].triggerEvent("spark:open_door");
                            self.disable();
                            this.subStep = 1;
                            this.save();
                            for (const cubes of this.dimension.getEntities({ type: "spark:torren_obstacle_m", tags: ["important"] })) {
                                if (isPointInsideAABB(cubes.location, templeZone1Min, templeZone1Max)) {
                                    cubes.removeTag("important");
                                }
                            }
                            break;
                        }
                    }
                }
            }
            // detect if a cube has fallen into the kill zone
            // { x: 5829, y: -59, z: 8810 }, { x: 5908, y: -11, z: 8894 }
            let boxes = this.dimension.getEntities({ tags: [cubeID] });
            if (boxes.length > 0) {
                for (let i = 0; i < boxes.length; i++) {
                    if (isPointInsideAABB(boxes[i].location, { x: 5829, y: -59, z: 8810 }, { x: 5908, y: -11, z: 8894 })) {
                        let box = boxes[i];
                        if (box.hasTag("removing"))
                            continue;
                        box.runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        box.addTag("removing");
                        // respawn box
                        if (box.hasTag("left_cube")) {
                            summonObstacleMedium(zone1LeftOb, [cubeID, "left_cube", "important"]);
                        }
                        if (box.hasTag("start_cube")) {
                            summonObstacleMedium(zone1CenterOb, [cubeID, "start_cube", "important"]);
                        }
                        if (box.hasTag("right_cube")) {
                            summonObstacleMedium(zone1RightOb, [cubeID, "right_cube", "important"]);
                        }
                    }
                }
            }
            leftPlateEmitter.update(leftPlateActive, false);
            rightPlateEmitter.update(rightPlateActive, false);
            let rsp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: leftPlateLoc, maxDistance: 2 });
            if (rsp.length > 0) {
                rsp[0].triggerEvent(leftPlateActive == true ? "spark:press_down" : "spark:press_up");
            }
            let dp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: rightPlateLoc, maxDistance: 2 });
            if (dp.length > 0) {
                dp[0].triggerEvent(rightPlateActive == true ? "spark:press_down" : "spark:press_up");
            }
        });
    }
    createTempleTwoTriggers() {
        // spawn
        let t2BoundsX = { x: 5696, y: -59, z: 8567 };
        let t2BoundsY = { x: 5805, y: 91, z: 8900 };
        this.createTrigger(t2BoundsX, t2BoundsY, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (this.enteredAnyTemple == 0) {
                    players[i].playSound("sound.spark.enter_sith_temple_minor");
                }
                players[i].setDefaultHotbarLoadout();
                players[i].setTutorialMessage(0);
                // set spawn point
                // players[i].setSpawnPoint({ dimension: this.dimension, x: this.rightDoorTriggerSendLocation.x, y: this.rightDoorTriggerSendLocation.y, z: this.rightDoorTriggerSendLocation.z });
                this.setRespawnPoint(players[i], { x: this.rightDoorTriggerSendLocation.x, y: this.rightDoorTriggerSendLocation.y, z: this.rightDoorTriggerSendLocation.z });
            }
            // set entered temple to 1, to disable the on first join sound
            this.enteredAnyTemple = 1;
            // play music
            this.dimension.runCommandAsync("music stop 5.0");
            this.dimension.runCommandAsync("music play sound.spark.ambience_custom2_inside 1.0 0.1");
            // disable this trigger
            self.disabled = true;
        });
        // spawn in holocron (or relic, whatever its called)
        let t2RelicSpawnBoundsX = { x: 5729, y: -17, z: 8674.98 };
        let t2RelicSpawnBoundsY = { x: 5756, y: -3, z: 8682.98 };
        this.createTrigger(t2RelicSpawnBoundsX, t2RelicSpawnBoundsY, (self) => {
            LEVEL_MANAGER.differSpawn("spark:torren_relic_2", { x: 5744.5, y: -1.5, z: 8605.5 }, this.dimension, () => { });
            // let relic = this.dimension.spawnEntity("spark:planet_2_relic", { x: 5744.5, y: -2, z: 8607.5 });
            // for any other events
            self.disabled = true;
        });
        // create a trigger here that will detect if players are within the dueling areas while the torren_relic_1 exists
        let backupTeleport = this.createTrigger(Vector.zero, Vector.zero, (self) => {
            let inZones = false;
            for (const player of this.dimension.getPlayers()) {
                for (const zone of this.minorDuelZones) {
                    if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                        inZones = true;
                        break;
                    }
                }
            }
            // teleport back to the relic place
            if (inZones) {
                for (const player of this.dimension.getPlayers()) {
                    for (const zone of this.minorDuelZones) {
                        if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                            player.teleport({ x: 5744.5, y: -14, z: 8627.5 }, { facingLocation: { x: 5744.5, y: -13.5, z: 8622.5 } });
                            LEVEL_MANAGER.differSpawn("spark:torren_relic_2", { x: 5744.5, y: -1.5, z: 8605.5 }, this.dimension, () => {
                                let relicExists = this.dimension.getEntities({ type: "spark:torren_relic_2", maxDistance: 2, location: { x: 5744.5, y: -1.5, z: 8605.5 } });
                                if (relicExists.length > 0) {
                                    relicExists[0].triggerEvent("spark:despawn");
                                }
                            });
                        }
                    }
                }
            }
        }, true);
        // on interaction with the relic, do the fun stuff!
        this.createTrigger({ x: 5727, y: -19, z: 8590 }, { x: 5761, y: 2, z: 8624 }, (self) => {
            // need to detect if the relic has a tag, then we play the sequence and teleport to fight room
            // in the fight room we have a skip button or something
            let relic = this.dimension.getEntities({ type: "spark:torren_relic_2", families: ["interacted"], location: { x: 5744.5, y: -1.5, z: 8605.5 }, maxDistance: 2 });
            if (relic.length > 0) {
                // setup fighting stage
                this.subStep = 3;
                this.save();
                backupTeleport.disable();
                // queue action
                this.levelManager.queueAction(60, (tick) => {
                    // sound.spark.sith_relic_interact
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 1) {
                            players[i].fadeOut();
                            players[i].playSound("sound.spark.sith_relic_interact");
                        }
                        if (tick == 50) {
                            players[i].fadeIn();
                            LEVEL_MANAGER.addParallelAction(21, (tick) => {
                                if (tick != 20)
                                    return;
                                players[i].playSound("sound.spark.sith_fight_begin");
                            });
                        }
                    }
                    if (tick == 30) {
                        // despawn relic
                        relic[0].triggerEvent("spark:despawn");
                        let players = this.dimension.getPlayers();
                        for (let i = 0; i < players.length; i++) {
                            let zone = this.minorDuelZones[i];
                            players[i].teleport(zone.pStart, { facingLocation: zone.pFacing });
                            this.resetArena(zone, "spark:vision_darth_tyrannus", false);
                            // create arena tick here!
                            this.setupArenaTrigger(zone, "spark:vision_darth_tyrannus");
                        }
                        // play music
                        world.playMusic("sound.spark.music.StarWarsROTSA", { loop: true, fade: 2.0 });
                        this.enableDuelSettings();
                    }
                });
                self.disabled = true;
            }
        });
        // detect maul trigger to end (would be death)
        this.createTrigger(Vector.zero, Vector.zero, (self) => {
            // while in this state we will poll for players in the correct zone
            // once all players have the correct tag, remove tag and goto next stage!
            let finishedPlayers = this.dimension.getPlayers({ tags: ["pz_i_win"] });
            let totalPlayers = this.dimension.getPlayers().length;
            if (totalPlayers == 0)
                return;
            if (finishedPlayers.length == totalPlayers) {
                this.levelManager.addParallelAction(140, (tick) => {
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 105) {
                            players[i].enableCutsceneSettings();
                            players[i].fadeOut();
                            players[i].clearPersistentUI();
                        }
                    }
                    if (tick == 80) {
                        this.dimension.runCommandAsync("music stop 3.0");
                    }
                    if (tick == 139) {
                        this.levelManager.addParallelAction(90, (tick) => {
                            let players = this.dimension.getPlayers();
                            for (let i = 0; i < players.length; i++) {
                                if (tick == 85) {
                                    players[i].disableCutsceneSettings();
                                    players[i].setDefaultHotbarLoadout();
                                    players[i].teleport(this.hubReturnLocation, { facingLocation: this.huhReturnFacingLocation });
                                    players[i].fadeIn("sound.spark.return_from_vision");
                                    players[i].removeTag("pz_i_win");
                                }
                            }
                            if (tick == 89) {
                                this.disableDuelSettings();
                                // spam setDialogue until it has a tag, should be fine!
                                // create trigger to set the quest
                                this.createTrigger(this.hubX, this.hubY, (self) => {
                                    let yoda = this.dimension.getEntities({ type: "spark:yoda", location: this.hubYodaLocation, maxDistance: 2 });
                                    if (yoda.length > 0) {
                                        setDialogue(yoda[0], "spark:puzzle.yoda.sith_story");
                                        // setup fighting stage
                                        this.subStep = 0;
                                        this.state = 999;
                                        self.disable();
                                    }
                                });
                                this.hubState = 1;
                                this.state = 999;
                            }
                        });
                    }
                });
                self.disable();
                return;
            }
            // notify all of those with the tag that they need to wait
            if (self.internalCounter % 100 == 0) {
                // spark.ui.puzzle.waiting_for_players
                let waiting = this.dimension.getPlayers({ tags: ["pz_i_win"] });
                for (const player of waiting) {
                    player.setTutorialMessage(13);
                }
            }
            self.internalCounter++;
        }, true);
        if (this.subStep < 1) {
            this.setupPuzzle3();
        }
        if (this.subStep < 2) {
            this.setupPuzzle4();
        }
    }
    setupPuzzle4() {
        // ----- Puzzle 4 ----- //
        // ----- Puzzle 4 ----- //
        // ----- Puzzle 4 ----- //
        // ----- Puzzle 4 ----- //
        // ----- Puzzle 4 ----- //
        // ----- Puzzle 4 ----- //
        // 5685 -17 8673 5797 10 8797
        let p4BoundsMin = { x: 5714.5, y: -17, z: 8673.5 };
        let p4BoundsMax = { x: 5791.5, y: 12, z: 8796.5 };
        // med conduct cube 5756 0 8772
        let p4MedConPos = { x: 5756.5, y: 0, z: 8772.5 };
        // power cube 5744 -10 8728
        let p4PowerPos = { x: 5744.5, y: -10, z: 8728.5 };
        let p4PowerPos2 = { x: 5763.5, y: -10, z: 8719.5 };
        // small conduct cube 5725 -10 8721
        let p4SmlConPos = { x: 5724.5, y: -9, z: 8718.5 };
        // large door 5744 -14 8674 north
        let p4EndDoorPos = { x: 5744.5, y: -14, z: 8674.5 };
        // small door 5730 -10 8720 east
        let p3LeftDoorPos = { x: 5731.5, y: -10, z: 8719.5 };
        // small door 5758 -10 8720 east
        let p3RightDoorPos = { x: 5757.5, y: -10, z: 8719.5 };
        let roomTagP4 = "rm4";
        let cubeID = "cb";
        let leftDoorPowerGap = [
            { x: 5739.5, y: -11, z: 8724.5 },
            { x: 5738.5, y: -11, z: 8724.5 },
            { x: 5737.5, y: -11, z: 8724.5 }
        ];
        let rightDoorPowerGap = [
            { x: 5749.5, y: -11, z: 8724.5 },
            { x: 5750.5, y: -11, z: 8724.5 }
        ];
        let finalDoorPowerGap = [
            { x: 5744.5, y: -11, z: 8703.5 },
            { x: 5744.5, y: -11, z: 8702.5 },
            { x: 5744.5, y: -11, z: 8701.5 }
        ];
        // wire lights
        let firstPowerT = new LinearWirePath(this.dimension);
        firstPowerT.spline = [
            { x: 5744.5, y: -11, z: 8727.5 },
            { x: 5744.5, y: -11, z: 8724.5 },
            { x: 5748.5, y: -11, z: 8724.5 },
            { x: 5740.5, y: -11, z: 8724.5 }
        ];
        let leftDoorConnect = new LinearWirePath(this.dimension);
        leftDoorConnect.spline = [
            { x: 5736.5, y: -11, z: 8724.5 },
            { x: 5732.5, y: -11, z: 8724.5 },
            { x: 5732.5, y: -10, z: 8724.5 }
        ];
        let firstPowerRightDoor = new LinearWirePath(this.dimension);
        firstPowerRightDoor.spline = [
            { x: 5751.5, y: -11, z: 8724.5 },
            { x: 5756.5, y: -11, z: 8724.5 },
            { x: 5756.5, y: -10, z: 8724.5 }
        ];
        let secondPower = new LinearWirePath(this.dimension);
        secondPower.spline = [
            { x: 5763.5, y: -11, z: 8718.5 },
            { x: 5763.5, y: -11, z: 8708.5 },
            { x: 5744.5, y: -11, z: 8708.5 },
            { x: 5744.5, y: -11, z: 8704.5 }
        ];
        let finalLine = new LinearWirePath(this.dimension);
        finalLine.spline = [
            { x: 5744.5, y: -11, z: 8700.5 },
            { x: 5744.5, y: -11, z: 8694.5 }
        ];
        let resetButtonLocation = { x: 5747.5, y: -9, z: 8729.5 };
        let resetButtonEvent = "spark:set_west";
        this.createTrigger(p4BoundsMin, p4BoundsMax, (self) => {
            summonPowerSource(p4PowerPos, [cubeID, "pw_c"]);
            // largeConduct
            summonConductorMedium(p4MedConPos, [cubeID, "cd_m"]);
            summonConductorSmall(p4SmlConPos, [cubeID, "cd_s"]);
            LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTagP4], [resetButtonEvent]);
            // doors
            LEVEL_MANAGER.differSpawn("spark:torren_gate_large", p4EndDoorPos, world.getDimension("overworld"), undefined, undefined, [roomTagP4], ["spark:door_north"]);
            LEVEL_MANAGER.differSpawn("spark:torren_gate_small", p3LeftDoorPos, world.getDimension("overworld"), undefined, undefined, [roomTagP4], ["spark:door_east"]);
            LEVEL_MANAGER.differSpawn("spark:torren_gate_small", p3RightDoorPos, world.getDimension("overworld"), undefined, undefined, [roomTagP4], ["spark:door_east"]);
            // fill pits with air!
            LEVEL_MANAGER.differCommand("fill 5737 -11 8725 5739 -13 8723 minecraft:air", { x: 5737, y: -11, z: 8725 }, this.dimension);
            LEVEL_MANAGER.differCommand("fill 5749 -11 8724 5750 -12 8723 minecraft:air", { x: 5749, y: 11, z: 8724 }, this.dimension);
            LEVEL_MANAGER.differCommand("fill 5743 -11 8703 5745 -13 8701 minecraft:air", { x: 5743, y: -11, z: 8703 }, this.dimension);
            self.disabled = true;
        });
        // respawn point 5734 4 8749 5753 -8 8740
        let p4RespawnSetTrigger = computeBounds({ x: 5734, y: 4, z: 8749 }, { x: 5753, y: -8, z: 8740 });
        this.createTrigger(p4RespawnSetTrigger.min, p4RespawnSetTrigger.max, (self) => {
            for (const player of this.dimension.getPlayers()) {
                this.setRespawnPoint(player, { x: 5744.5, y: -2, z: 8745.5 });
            }
        });
        // func
        this.createTrigger(p4BoundsMin, p4BoundsMax, (self) => {
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT2Room2();
                self.disable();
            }
            // remove important tag on everything but the special cubes
            for (const cubes of this.dimension.getEntities({ tags: [roomTagP4, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                cubes.removeTag("important");
            }
            let powerCube1Active = false;
            let powerCube2Active = false;
            let leftPitFull = false;
            let rightPitFull = false;
            let finalPitFull = false;
            let powerCubeStateOne = this.dimension.getEntities({ type: "spark:power_source", location: p4PowerPos, maxDistance: 1 });
            if (powerCubeStateOne.length > 0) {
                if (isBlockOfType(this.dimension, p4PowerPos, "spark:force_box_collision")) {
                    powerCube1Active = true;
                }
            }
            let powerCubeStateTwo = this.dimension.getEntities({ type: "spark:power_source", location: p4PowerPos2, maxDistance: 1 });
            if (powerCubeStateTwo.length > 0) {
                if (isBlockOfType(this.dimension, p4PowerPos2, "spark:force_box_collision")) {
                    powerCube2Active = true;
                }
            }
            let leftPitCount = 0;
            for (let i = 0; i < leftDoorPowerGap.length; i++) {
                if (isBlockOfType(this.dimension, leftDoorPowerGap[i], "spark:force_box_collision")) {
                    if (isEntityAtExactPosition(this.dimension, leftDoorPowerGap[i], "spark:conductor_obstacle_m")) {
                        leftPitCount++;
                    }
                }
            }
            if (leftPitCount == 3) {
                leftPitFull = true;
                let ent = this.dimension.getEntities({ location: leftDoorPowerGap[1], type: "spark:conductor_obstacle_m", maxDistance: 2 });
                if (ent.length > 0) {
                    // tag that entity as important
                    if (!ent[0].hasTag("important"))
                        ent[0].addTag("important");
                }
            }
            let rightPitCount = 0;
            for (let i = 0; i < rightDoorPowerGap.length; i++) {
                if (isBlockOfType(this.dimension, rightDoorPowerGap[i], "spark:force_box_collision")) {
                    if (isEntityAtExactPosition(this.dimension, rightDoorPowerGap[i], "spark:conductor_obstacle_s")) {
                        rightPitCount++;
                    }
                }
            }
            if (rightPitCount == 2) {
                rightPitFull = true;
                let ent = this.dimension.getEntities({ location: rightDoorPowerGap[0], type: "spark:conductor_obstacle_s", maxDistance: 2 });
                if (ent.length > 0) {
                    // tag that entity as important
                    if (!ent[0].hasTag("important"))
                        ent[0].addTag("important");
                }
            }
            let finalPitCount = 0;
            for (let i = 0; i < finalDoorPowerGap.length; i++) {
                if (isBlockOfType(this.dimension, finalDoorPowerGap[i], "spark:force_box_collision")) {
                    if (isEntityAtExactPosition(this.dimension, finalDoorPowerGap[i], "spark:conductor_obstacle_m")) {
                        finalPitCount++;
                    }
                }
            }
            if (finalPitCount == 3) {
                finalPitFull = true;
                let ent = this.dimension.getEntities({ location: finalDoorPowerGap[1], type: "spark:conductor_obstacle_m", maxDistance: 2 });
                if (ent.length > 0) {
                    // tag that entity as important
                    if (!ent[0].hasTag("important"))
                        ent[0].addTag("important");
                }
            }
            // we need to be doing things before the final door check
            if (powerCube1Active) {
                // if the left door isnt open, check for 3 blocks in pit
                let leftDoor = this.dimension.getEntities({ type: "spark:torren_gate_small", location: p3LeftDoorPos, maxDistance: 2 });
                if (leftDoor.length > 0) {
                    let door = leftDoor[0];
                    // if not open
                    if (!door.hasTag("open")) {
                        if (leftPitFull) {
                            // open door
                            door.triggerEvent("spark:open_door");
                        }
                    }
                }
                // if the right door isnt open, check for 2 blocks in pit
                let rightDoor = this.dimension.getEntities({ type: "spark:torren_gate_small", location: p3RightDoorPos, maxDistance: 2 });
                if (rightDoor.length > 0) {
                    let door = rightDoor[0];
                    // if not open
                    if (!door.hasTag("open")) {
                        if (rightPitFull) {
                            // open door
                            door.triggerEvent("spark:open_door");
                        }
                    }
                }
            }
            // if power cube is in the second position, we do the checking for the final door! 5763 -10 8719
            if (powerCube2Active) {
                // check for final door status
                let finalDoor = this.dimension.getEntities({ type: "spark:torren_gate_large", location: p4EndDoorPos, maxDistance: 2 });
                if (finalDoor.length > 0) {
                    // if open, finished
                    if (finalDoor[0].hasTag("open")) {
                        self.disabled = true;
                        // remove important tag on everything but the special cubes
                        for (const cubes of this.dimension.getEntities({ tags: [roomTagP4, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                            cubes.removeTag("important");
                        }
                        return;
                    }
                    let door = finalDoor[0];
                    if (finalPitFull) {
                        door.triggerEvent("spark:open_door");
                        this.subStep = 2;
                        this.save();
                    }
                }
            }
            // power lines
            firstPowerT.update(powerCube1Active);
            leftDoorConnect.update(powerCube1Active && leftPitFull);
            firstPowerRightDoor.update(powerCube1Active && rightPitFull);
            secondPower.update(powerCube2Active);
            finalLine.update(powerCube2Active && finalPitFull);
            // respawning cubes
            // cube reset trigger { x: 5724, y: -59, z: 8745 }, { x: 5779, y: -13, z: 8896 }
            let boxes = this.dimension.getEntities({ tags: [cubeID] });
            if (boxes.length > 0) {
                for (let i = 0; i < boxes.length; i++) {
                    if (isPointInsideAABB(boxes[i].location, { x: 5724, y: -59, z: 8745 }, { x: 5779, y: -13, z: 8896 })
                        || isPointInsideAABB(boxes[i].location, { x: 5707, y: -60, z: 8573 }, { x: 5803, y: -23, z: 8735 })) {
                        let box = boxes[i];
                        if (box.hasTag("removing"))
                            continue;
                        box.runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        box.addTag("removing");
                        // respawn box
                        if (box.hasTag("pw_c")) {
                            summonPowerSource(p4PowerPos, [cubeID, "pw_c"]);
                        }
                        if (box.hasTag("cd_m")) {
                            summonConductorMedium(p4MedConPos, [cubeID, "cd_m"]);
                        }
                        if (box.hasTag("cd_s")) {
                            summonConductorSmall(p4SmlConPos, [cubeID, "cd_s"]);
                        }
                    }
                }
            }
        });
    }
    setupPuzzle3() {
        // ----- Puzzle 3 ----- //
        // ----- Puzzle 3 ----- //
        // ----- Puzzle 3 ----- //
        // ----- Puzzle 3 ----- //
        // ----- Puzzle 3 ----- //
        // ----- Puzzle 3 ----- //
        // zones for puzzles
        // trigger to spawn the required stuff
        // 2 doors, 1 large doors, 3 normal cubes
        // min 5707 -7 8787
        let p3BoundsMin = { x: 5707, y: -7, z: 8787 };
        // max 5778 25 8886
        let p3BoundsMax = { x: 5778, y: 25, z: 8886 };
        // power cube 5744 -4 8840
        let powerCube = { x: 5744.5, y: -4, z: 8840.5 };
        // conduct 3x3 5751 -3 8840
        let largeConduct = { x: 5751.5, y: -3, z: 8840.5 };
        // contuct 2x2 5738 -4 8840
        let smallConduct = { x: 5737.5, y: -3, z: 8840.5 };
        // large door 5744 -4 8788 north
        let largeDoor = { x: 5744.5, y: -4, z: 8788.5 };
        // blocks
        let smallHole1 = { x: 5744.5, y: -5, z: 8819.5 };
        let smallHole2 = { x: 5743.5, y: -5, z: 8819.5 };
        let largeHolePositions = [
            { x: 5743.5, y: -5, z: 8813.5 },
            { x: 5744.5, y: -5, z: 8813.5 },
            { x: 5743.5, y: -5, z: 8812.5 },
            { x: 5744.5, y: -5, z: 8812.5 }
        ];
        let roomTag = "rm3";
        let cubeID = "cb";
        // light paths
        let power2SmallHole = new LinearWirePath(this.dimension);
        power2SmallHole.spline = [
            { x: 5745.5, y: -5, z: 8826.5 },
            { x: 5751.5, y: -5, z: 8826.5 },
            { x: 5751.5, y: -5, z: 8819.5 },
            { x: 5745.5, y: -5, z: 8819.5 }
        ];
        let small2largeHole = new LinearWirePath(this.dimension);
        small2largeHole.spline = [
            { x: 5742.5, y: -5, z: 8819.5 },
            { x: 5737.5, y: -5, z: 8819.5 },
            { x: 5737.5, y: -5, z: 8813.5 },
            { x: 5742.5, y: -5, z: 8813.5 }
        ];
        let large2door = new LinearWirePath(this.dimension);
        large2door.spline = [
            { x: 5744.5, y: -5, z: 8811.5 },
            { x: 5744.5, y: -5, z: 8789.5 }
        ];
        let resetButtonLocation = { x: 5746.5, y: -3, z: 8846.5 };
        let resetButtonEvent = "spark:set_west";
        this.createTrigger(p3BoundsMin, p3BoundsMax, (self) => {
            summonPowerSource(powerCube, [cubeID, "pw_c"]);
            // largeConduct
            summonConductorMedium(largeConduct, [cubeID, "cd_m"]);
            summonConductorSmall(smallConduct, [cubeID, "cd_s"]);
            // reset button
            LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag], [resetButtonEvent]);
            // door
            LEVEL_MANAGER.differSpawn("spark:torren_gate_large", largeDoor, world.getDimension("overworld"), undefined, undefined, [roomTag], ["spark:door_north"]);
            // fill pits with air!
            LEVEL_MANAGER.differCommand("fill 5743 -5 8819 5744 -6 8820 minecraft:air", { x: 5743, y: -5, z: 8819 }, this.dimension);
            LEVEL_MANAGER.differCommand("fill 5743 -5 8812 5745 -7 8814 minecraft:air", { x: 5743, y: -5, z: 8812 }, this.dimension);
            // respawn point
            for (const player of this.dimension.getPlayers()) {
                this.setRespawnPoint(player, { x: this.rightDoorTriggerSendLocation.x, y: this.rightDoorTriggerSendLocation.y, z: this.rightDoorTriggerSendLocation.z });
            }
            self.disabled = true;
        });
        // the functionality
        this.createTrigger(p3BoundsMin, p3BoundsMax, (self) => {
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT2Room1();
                self.disable();
            }
            let sectionDoor = this.dimension.getEntities({ type: "spark:torren_gate_large", location: largeDoor, maxDistance: 2 });
            if (sectionDoor.length > 0) {
                if (sectionDoor[0].hasTag("open")) {
                    self.disabled = true;
                    this.subStep = 1;
                    this.save();
                    // remove important tag on everything but the special cubes
                    for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                        cubes.removeTag("important");
                    }
                    return;
                }
                let door = sectionDoor[0];
                if (door.hasTag("power"))
                    door.removeTag("power");
                if (door.hasTag("small_hole"))
                    door.removeTag("small_hole");
                if (door.hasTag("large_hole"))
                    door.removeTag("large_hole");
                // detect if power is in the correct place
                // detect block, then entity!
                if (isBlockOfType(this.dimension, { x: 5744.5, y: -4, z: 8826.5 }, "spark:force_box_collision")) {
                    let power = this.dimension.getEntities({ type: "spark:power_source", location: { x: 5744.5, y: -4, z: 8826 }, maxDistance: 2 });
                    if (power.length > 0) {
                        if (!door.hasTag("power"))
                            door.addTag("power");
                    }
                }
                // detect if there are two spark:force_box_collision in line on the small area
                if (isBlockOfType(this.dimension, smallHole1, "spark:force_box_collision")) {
                    if (isBlockOfType(this.dimension, smallHole2, "spark:force_box_collision")) {
                        if (!door.hasTag("small_hole"))
                            door.addTag("small_hole");
                        let ent = this.dimension.getEntities({ location: smallHole1, type: "spark:conductor_obstacle_s" });
                        if (ent.length > 0) {
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
                // large hole, we only need 3 to be true
                let count = 0;
                for (let i = 0; i < largeHolePositions.length; i++) {
                    if (isBlockOfType(this.dimension, largeHolePositions[i], "spark:force_box_collision")) {
                        count++;
                        let ent = this.dimension.getEntities({ location: largeHolePositions[i], type: "spark:conductor_obstacle_m" });
                        if (ent.length > 0) {
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
                if (count >= 3) {
                    if (!door.hasTag("large_hole"))
                        door.addTag("large_hole");
                }
                // final check
                if (door.hasTag("power") && door.hasTag("small_hole") && door.hasTag("large_hole")) {
                    door.triggerEvent("spark:open_door");
                }
                // wire checks 
                power2SmallHole.update(door.hasTag("power"));
                small2largeHole.update(door.hasTag("power") && door.hasTag("small_hole"));
                large2door.update(door.hasTag("power") && door.hasTag("small_hole") && door.hasTag("large_hole"));
            }
            // cube reset trigger { x: 5724, y: -59, z: 8745 }, { x: 5779, y: -13, z: 8896 }
            let boxes = this.dimension.getEntities({ tags: [cubeID] });
            if (boxes.length > 0) {
                for (let i = 0; i < boxes.length; i++) {
                    if (isPointInsideAABB(boxes[i].location, { x: 5724, y: -59, z: 8745 }, { x: 5779, y: -13, z: 8896 })) {
                        let box = boxes[i];
                        if (box.hasTag("removing"))
                            continue;
                        box.runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        box.addTag("removing");
                        // respawn box
                        if (box.hasTag("pw_c")) {
                            summonPowerSource(powerCube, [roomTag, "pw_c"]);
                        }
                        if (box.hasTag("cd_m")) {
                            summonConductorMedium(largeConduct, [roomTag, cubeID, "cd_m"]);
                        }
                        if (box.hasTag("cd_s")) {
                            summonConductorSmall(smallConduct, [roomTag, cubeID, "cd_s"]);
                        }
                    }
                }
            }
        });
    }
    createTempleThreeTriggers() {
        // initial trigger 5337 68 8781 | 5548 218 8938
        // spawn
        let topBoundsMin = { x: 5337, y: 68, z: 8781 };
        let topBoundsMax = { x: 5548, y: 218, z: 8938 };
        // things used for later!
        let leftRoomEntrencePos = { x: 5478.5, y: 106, z: 8833.5 };
        let centerRoomEntrencePos = { x: 5454.5, y: 106, z: 8857.5 };
        let rightRoomEntrencePos = { x: 5430.5, y: 106, z: 8833.5 };
        let plateType0Pos = { x: 5467.5, y: 106, z: 8846.5 }; // left room
        let plateType1Pos = { x: 5441.5, y: 106, z: 8846.5 }; // top room left door
        let plateType2Pos = { x: 5467.5, y: 106, z: 8820.5 }; // top room right door
        let plateType3Pos = { x: 5441.5, y: 106, z: 8820.5 }; // right room
        let centerRoomTag = "rm_c";
        let cubeTag = "cube";
        this.createTrigger(topBoundsMin, topBoundsMax, (self) => {
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                players[i].setDefaultHotbarLoadout();
                players[i].setTutorialMessage(0);
                this.setRespawnPoint(players[i], { x: this.centerDoorTriggerSendLocation.x, y: this.centerDoorTriggerSendLocation.y, z: this.centerDoorTriggerSendLocation.z });
            }
            // play music
            this.dimension.runCommandAsync("music stop 5.0");
            this.dimension.runCommandAsync("music play sound.spark.ambience_custom2_inside 1.0 0.1");
            // differ spawning
            // power cell 5454 106 8820
            summonPowerSource({ x: 5454.5, y: 106, z: 8820.5 }, ["center_pw", centerRoomTag, cubeTag, "power_id_0"]);
            this.t3KillZonesTagMappings.set("power_id_0", { x: 5454.5, y: 106, z: 8820.5 });
            // doors
            // left 5478 106 8833 east
            LEVEL_MANAGER.differSpawn("spark:torren_gate_large", leftRoomEntrencePos, world.getDimension("overworld"), undefined, undefined, [centerRoomTag], ["spark:door_east"]);
            // center 5454 106 8857 north
            LEVEL_MANAGER.differSpawn("spark:torren_gate_large", centerRoomEntrencePos, world.getDimension("overworld"), undefined, undefined, [centerRoomTag], ["spark:door_north"]);
            // right 5430 106 8833 east
            LEVEL_MANAGER.differSpawn("spark:torren_gate_large", rightRoomEntrencePos, world.getDimension("overworld"), undefined, undefined, [centerRoomTag], ["spark:door_east"]);
            // plates
            // type 0 5467 106 8846
            // type 1 5441 106 8846
            // type 2 5467 106 8820
            // type 3 5441 106 8820
            summonPressurePlate(plateType0Pos, [centerRoomTag, "center_t0_plate"]);
            summonPressurePlate(plateType1Pos, [centerRoomTag, "center_t1_plate"]);
            summonPressurePlate(plateType2Pos, [centerRoomTag, "center_t2_plate"]);
            summonPressurePlate(plateType3Pos, [centerRoomTag, "center_t3_plate"]);
            // remove old blocks
            // summon elevator
            // LEVEL_MANAGER.differSpawn("spark:torren_elevator", { x: 5454.5, y: 104.5, z: 8833.5 }, this.dimension);
            LEVEL_MANAGER.differSpawn("spark:torren_elevator", { x: 5454.5, y: 105, z: 8833.5 }, this.dimension);
            LEVEL_MANAGER.addParallelAction(20, (tick) => {
                if (tick == 19) {
                    this.dimension.runCommandAsync("fill 5449 104 8838 5459 102 8828 air");
                    this.dimension.runCommandAsync("fill 5449 105 8828 5459 105 8838 minecraft:barrier");
                }
            });
            // need a fixing chekc here, if any player is within the three side areas
            // teleport them to the spawn of t3
            for (const player of this.dimension.getPlayers()) {
                if (isPointInsideAABB(player.location, leftRoom.min, leftRoom.max)) {
                    player.teleport(this.centerDoorTriggerSendLocation, { facingLocation: this.centerDoorTriggerFaceLocation });
                    continue;
                }
                if (isPointInsideAABB(player.location, topRoom.min, topRoom.max)) {
                    player.teleport(this.centerDoorTriggerSendLocation, { facingLocation: this.centerDoorTriggerFaceLocation });
                    continue;
                }
                if (isPointInsideAABB(player.location, rightRoom.min, rightRoom.max)) {
                    player.teleport(this.centerDoorTriggerSendLocation, { facingLocation: this.centerDoorTriggerFaceLocation });
                }
            }
            // disable this trigger
            self.disabled = true;
        });
        // process kills and cube respawns
        this.createTrigger(topBoundsMin, topBoundsMax, (self) => {
            this.t3CubeRespawn();
        });
        // center room door triggers
        // min 5479 104 8858
        // max 5429 122 8804
        let centerRoomMin = { x: 5429, y: 96, z: 8804 };
        let centerRoomMax = { x: 5479, y: 135, z: 8858 };
        // triggers and such
        let leftRoom = computeBounds({ x: 5477, y: 102, z: 8808 }, { x: 5537, y: 149, z: 8859 });
        let topRoom = computeBounds({ x: 5433, y: 104, z: 8856 }, { x: 5485, y: 146, z: 8926 });
        let rightRoom = computeBounds({ x: 5347, y: 60, z: 8809 }, { x: 5431, y: 152, z: 8887 });
        let plate0SoundEmitter = new PlateSoundEmitter(plateType0Pos, this.dimension);
        let plate1SoundEmitter = new PlateSoundEmitter(plateType1Pos, this.dimension);
        let plate2SoundEmitter = new PlateSoundEmitter(plateType2Pos, this.dimension);
        let plate3SoundEmitter = new PlateSoundEmitter(plateType3Pos, this.dimension);
        this.createTrigger(centerRoomMin, centerRoomMax, (self) => {
            let opened = 0;
            // detect if the cube is on the door pad
            let powerCubeOnConnector = this.dimension.getEntities({ type: "spark:power_source", location: { x: 5454.5, y: 106, z: 8822.5 }, maxDistance: 0.5 });
            if (powerCubeOnConnector.length > 0) {
                // open all three doors
                // tag to stop this part from playing out
                let leftDoorGrabber = this.dimension.getEntities({ type: "spark:torren_gate_large", location: leftRoomEntrencePos, maxDistance: 1 });
                if (leftDoorGrabber.length > 0) {
                    leftDoorGrabber[0].triggerEvent("spark:open_door");
                    opened++;
                }
                let centerDoorGrabber = this.dimension.getEntities({ type: "spark:torren_gate_large", location: centerRoomEntrencePos, maxDistance: 1 });
                if (centerDoorGrabber.length > 0) {
                    centerDoorGrabber[0].triggerEvent("spark:open_door");
                    opened++;
                }
                let rightDoorGrabber = this.dimension.getEntities({ type: "spark:torren_gate_large", location: rightRoomEntrencePos, maxDistance: 1 });
                if (rightDoorGrabber.length > 0) {
                    rightDoorGrabber[0].triggerEvent("spark:open_door");
                    opened++;
                }
                if (opened == 3) {
                    this.leftRoomStuff();
                    this.topRoomStuff();
                    this.rightRoomStuff();
                    self.disable();
                }
            }
        });
        // respawn triggers
        this.createTrigger(centerRoomMin, centerRoomMin, (self) => {
            for (const player of this.dimension.getPlayers()) {
                this.setRespawnPoint(player, this.centerDoorTriggerSendLocation);
            }
        });
        // center room plates
        let centerPowerLoop = new LinearWirePath(this.dimension);
        centerPowerLoop.spline = [
            { x: 5454, y: 105, z: 8823 },
            { x: 5454, y: 105, z: 8824 },
            { x: 5463, y: 105, z: 8824 },
            { x: 5463, y: 105, z: 8833 },
            { x: 5477, y: 105, z: 8833 },
            { x: 5463, y: 105, z: 8833 },
            { x: 5463, y: 105, z: 8842 },
            { x: 5454, y: 105, z: 8842 },
            { x: 5454, y: 105, z: 8856 },
            { x: 5454, y: 105, z: 8842 },
            { x: 5445, y: 105, z: 8842 },
            { x: 5445, y: 105, z: 8833 },
            { x: 5431, y: 105, z: 8833 },
            { x: 5445, y: 105, z: 8833 },
            { x: 5445, y: 105, z: 8824 },
            { x: 5454, y: 105, z: 8824 }
        ];
        this.createTrigger(centerRoomMin, centerRoomMax, (self) => {
            let counter = 0;
            let plate0Active = this.isCubeOnPlate(plateType0Pos);
            let plate1Active = this.isCubeOnPlate(plateType1Pos);
            let plate2Active = this.isCubeOnPlate(plateType2Pos);
            let plate3Active = this.isCubeOnPlate(plateType3Pos);
            let plate0Correct = false;
            let plate1Correct = false;
            let plate2Correct = false;
            let plate3Correct = false;
            // check each type of pad with the correct blocks and stuff!
            // update the line
            let powerCubeActive = false;
            let powerCubeOnConnector = this.dimension.getEntities({ type: "spark:power_source", location: { x: 5454.5, y: 106, z: 8822.5 }, maxDistance: 0.5 });
            if (powerCubeOnConnector.length > 0) {
                if (isBlockOfType(this.dimension, { x: 5454.5, y: 106, z: 8822.5 }, "spark:force_box_collision")) {
                    powerCubeActive = true;
                }
            }
            centerPowerLoop.update(powerCubeActive);
            // type 0;
            if (plate0Active) {
                // get that entity, and get its variant type.
                let cube = this.dimension.getEntities({ type: "spark:aurebesh_obstacle_m", location: plateType0Pos, maxDistance: 7 });
                if (cube.length > 0) {
                    // loop over entities and see if its the correct one
                    for (let i = 0; i < cube.length; i++) {
                        if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                            // get variant
                            let variant = cube[0].getComponent("minecraft:variant");
                            if (variant != undefined) {
                                if (variant.value == 0) {
                                    counter++;
                                    plate0Correct = true;
                                }
                            }
                        }
                    }
                }
            }
            // type 1;
            if (plate1Active) {
                // get that entity, and get its variant type.
                let cube = this.dimension.getEntities({ type: "spark:aurebesh_obstacle_m", location: plateType1Pos, maxDistance: 7 });
                if (cube.length > 0) {
                    // loop over entities and see if its the correct one
                    for (let i = 0; i < cube.length; i++) {
                        if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                            // get variant
                            let variant = cube[0].getComponent("minecraft:variant");
                            if (variant != undefined) {
                                if (variant.value == 1) {
                                    counter++;
                                    plate1Correct = true;
                                }
                            }
                        }
                    }
                }
            }
            // type 2;
            if (plate2Active) {
                // get that entity, and get its variant type.
                let cube = this.dimension.getEntities({ type: "spark:aurebesh_obstacle_m", location: plateType2Pos, maxDistance: 2 });
                if (cube.length > 0) {
                    // loop over entities and see if its the correct one
                    for (let i = 0; i < cube.length; i++) {
                        if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                            // get variant
                            let variant = cube[0].getComponent("minecraft:variant");
                            if (variant != undefined) {
                                if (variant.value == 2) {
                                    counter++;
                                    plate2Correct = true;
                                }
                            }
                        }
                    }
                }
            }
            // type 3;
            if (plate3Active) {
                // get that entity, and get its variant type.
                let cube = this.dimension.getEntities({ type: "spark:aurebesh_obstacle_m", location: plateType3Pos, maxDistance: 2 });
                if (cube.length > 0) {
                    // loop over entities and see if its the correct one
                    for (let i = 0; i < cube.length; i++) {
                        if (cube[0].typeId === "spark:aurebesh_obstacle_m") {
                            // get variant
                            let variant = cube[0].getComponent("minecraft:variant");
                            if (variant != undefined) {
                                if (variant.value == 3) {
                                    counter++;
                                    plate3Correct = true;
                                }
                            }
                        }
                    }
                }
            }
            // sounds
            plate0SoundEmitter.update(plate0Active, plate0Correct);
            plate1SoundEmitter.update(plate1Active, plate1Correct);
            plate2SoundEmitter.update(plate2Active, plate2Correct);
            plate3SoundEmitter.update(plate3Active, plate3Correct);
            let pl0 = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: plateType0Pos, maxDistance: 2 });
            if (pl0.length > 0) {
                pl0[0].triggerEvent(plate0Active == true ? "spark:press_down" : "spark:press_up");
            }
            let dp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: plateType1Pos, maxDistance: 2 });
            if (dp.length > 0) {
                dp[0].triggerEvent(plate1Active == true ? "spark:press_down" : "spark:press_up");
            }
            let gp = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: plateType2Pos, maxDistance: 2 });
            if (gp.length > 0) {
                gp[0].triggerEvent(plate2Active == true ? "spark:press_down" : "spark:press_up");
            }
            let ep = this.dimension.getEntities({ type: "spark:torren_pressure_plate", location: plateType3Pos, maxDistance: 2 });
            if (ep.length > 0) {
                ep[0].triggerEvent(plate3Active == true ? "spark:press_down" : "spark:press_up");
            }
            // bypass
            for (const player of this.dimension.getPlayers()) {
                if (player.hasTag("dev_bypass")) {
                    counter = 4;
                    break;
                }
            }
            // if 4, we are all active
            // TODO: Add elevator stuff here!
            if (counter == 4) {
                // remove barriers and tag elevator
                LEVEL_MANAGER.differCommand("fill 5449 105 8828 5459 105 8838 minecraft:air", { x: 5454.5, y: 104.5, z: 8833.5 }, this.dimension);
                let elevatorSelector = this.dimension.getEntities({ type: "spark:torren_elevator" });
                if (elevatorSelector.length > 0) {
                    if (!elevatorSelector[0].hasTag("active")) {
                        elevatorSelector[0].addTag("active");
                        LEVEL_MANAGER.addParallelAction(2, (tick) => {
                            if (tick == 1) {
                                elevatorSelector[0].triggerEvent("spark:make_solid");
                            }
                        });
                        // play sounds
                        world.playSound("sound.spark.m_puzzle.elevator_bump", elevatorSelector[0].location);
                        // set state as two
                        this.subStep = 1;
                        this.save();
                        self.disable();
                    }
                }
            }
        });
        // elevator trigger thing
        let elevatorZone = computeBounds({ x: 5429, y: 96, z: 8804 }, { x: 5479, y: 135, z: 8858 });
        let elevatorLargeZone = computeBounds({ x: 5429, y: 120, z: 8804 }, { x: 5479, y: 0, z: 8858 });
        this.createTrigger(elevatorZone.min, elevatorZone.max, (self) => {
            // if the elevator has the enabled tag
            let elevatorSelector = this.dimension.getEntities({ type: "spark:torren_elevator" });
            if (elevatorSelector.length > 0) {
                let elevator = elevatorSelector[0];
                // if it has the correct ag
                if (!elevator.hasTag("active"))
                    return;
                // if a player is standing within a given zone, start the decent
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, this.elevatorStartZone.min, this.elevatorStartZone.max)) {
                        // if we are here
                        // start the impulse and the move sequence
                        elevator.applyImpulse({ x: 0, y: -0.08, z: 0 });
                        elevator.addTag("moving");
                        // tag all players
                        for (const p of this.dimension.getPlayers()) {
                            if (!p.hasTag("elevator")) {
                                p.addTag("elevator");
                            }
                            p.playSound("sound.spark.sith_elevator");
                        }
                        LEVEL_MANAGER.addParallelAction(200, (tick) => {
                            // force the elevator speed?
                            let elevatorSpeedCheck = this.dimension.getEntities({ type: "spark:torren_elevator", tags: ["moving"] });
                            if (elevatorSpeedCheck.length > 0) {
                                let elevator = elevatorSpeedCheck[0];
                                let velocity = elevator.getVelocity();
                                if (Vector.equals(velocity, Vector.zero)) {
                                    elevator.applyImpulse({ x: 0, y: -0.08, z: 0 });
                                }
                            }
                            // we are moving already
                            if (tick == 100) {
                                // after 5 seconds do fade
                                for (const p of this.dimension.getPlayers()) {
                                    p.fadeOut();
                                }
                            }
                            // after fade, spawn in new platform
                            if (tick == 125) {
                                // despawn current elevator
                                let movingElevatorSelector = this.dimension.getEntities({ type: "spark:torren_elevator", tags: ["moving"] });
                                if (movingElevatorSelector.length > 0) {
                                    let elevator = movingElevatorSelector[0];
                                    elevator.triggerEvent("spark:despawn");
                                }
                                // summon new elevator near the bottom { x:5454.5, y:35.5, z:8833.5}
                                let newElevator = this.dimension.spawnEntity("spark:torren_elevator", { x: 5454.5, y: 23.5, z: 8833.5 });
                                newElevator.applyImpulse({ x: 0, y: -0.08, z: 0 });
                                // get all players, spread them between 5451 37 8830 5457 37 8836
                                let tpX = { x: 5451.5, y: 35.5, z: 8830.5 };
                                let tpY = { x: 5457.5, y: 35.5, z: 8836.5 };
                                for (const player of this.dimension.getPlayers()) {
                                    let x = randomRange(tpX.x, tpY.x);
                                    let z = randomRange(tpX.z, tpY.z);
                                    player.teleport({ x: x, y: 24, z: z }, { rotation: { x: 0, y: 180 } });
                                }
                                // fill bottom 5449 6 8828 5459 6 8838
                                this.dimension.runCommandAsync("fill 5449 6 8828 5459 6 8838 air");
                            }
                            if (tick == 130) {
                                for (const player of this.dimension.getPlayers()) {
                                    player.fadeIn();
                                }
                            }
                        });
                        // final trigger to detect when the elevator is at the bottom
                        this.createTrigger(elevatorLargeZone.min, elevatorLargeZone.max, (self) => {
                            // slow fall stuff
                            let anyElevator = this.dimension.getEntities({ type: "spark:torren_elevator" });
                            for (const player of this.dimension.getPlayers()) {
                                if (anyElevator.length > 0) {
                                    let ePos = anyElevator[0].location;
                                    if (Vector.distance(ePos, player.location) < 12) {
                                        // if the players y is ePos.y+1
                                        let playerY = player.location.y;
                                        if (playerY < (ePos.y + 1.5)) {
                                            player.addEffect("slow_falling", 2, { amplifier: 1, showParticles: false });
                                            continue;
                                        }
                                        player.removeEffect("slow_falling");
                                    }
                                }
                            }
                            let elevatorAtBottom = this.dimension.getEntities({ type: "spark:torren_elevator", location: { x: 5454.5, y: 6, z: 8833.5 }, maxDistance: 0.1 });
                            if (elevatorAtBottom.length > 0) {
                                elevatorAtBottom[0].triggerEvent("spark:make_float");
                                elevatorAtBottom[0].teleport({ x: 5454.5, y: 6, z: 8833.5 });
                                elevatorAtBottom[0].runCommandAsync("fill 5449 6 8828 5459 6 8838 minecraft:barrier");
                                // teleport it so that it stops.
                                self.disable();
                            }
                        });
                        self.disable();
                        this.subStep = 2;
                        break;
                    }
                }
            }
        });
        let crystalPos = { x: 5454.5, y: 19.5, z: 8745.5 };
        // create a trigger here that will detect if players are within the dueling areas while the torren_relic_1 exists
        let backupTeleport = this.createTrigger(Vector.zero, Vector.zero, (self) => {
            let inZones = false;
            for (const player of this.dimension.getPlayers()) {
                for (const zone of this.majorDuelZones) {
                    if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                        inZones = true;
                        break;
                    }
                }
            }
            // teleport back to the relic place
            if (inZones) {
                for (const player of this.dimension.getPlayers()) {
                    for (const zone of this.majorDuelZones) {
                        if (isPointInsideAABB(player.location, zone.bounds.min, zone.bounds.max)) {
                            player.teleport({ x: 5454.5, y: 7, z: 8765.5 }, { facingLocation: { x: 5454.5, y: 8.5, z: 8761.5 } });
                            LEVEL_MANAGER.differSpawn("spark:torren_relic_main", crystalPos, this.dimension, () => {
                                let relicExists = this.dimension.getEntities({ type: "spark:torren_relic_main", maxDistance: 2, location: crystalPos });
                                if (relicExists.length > 0) {
                                    relicExists[0].triggerEvent("spark:despawn");
                                }
                            });
                        }
                    }
                }
            }
        }, true);
        // final stuff
        // spawn in crystal
        let crystalBoundsX = { x: 5440, y: 4, z: 8815 };
        let crystalBoundsY = { x: 5464, y: 24, z: 8843 };
        this.createTrigger(crystalBoundsX, crystalBoundsY, (self) => {
            // differ crystal spawn
            LEVEL_MANAGER.differSpawn("spark:torren_relic_main", crystalPos, world.getDimension("overworld"), () => { });
            // this is at the bottom of the elevator, enable kill check again!
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                if (players[i].hasTag("elevator"))
                    players[i].removeTag("elevator");
            }
            self.disabled = true;
        });
        let crystalRoomBoundsX = { x: 5432, y: 2, z: 8727.53 };
        let crystalRoomBoundsY = { x: 5472, y: 24, z: 8768.65 };
        this.createTrigger(crystalRoomBoundsX, crystalRoomBoundsY, (self) => {
            // need to detect if the relic has a tag, then we play the sequence and teleport to fight room
            // in the fight room we have a skip button or something
            for (const player of this.dimension.getPlayers()) {
                this.setRespawnPoint(player, { x: 5454.5, y: 7, z: 8820.5 });
            }
            let relic = this.dimension.getEntities({ type: "spark:torren_relic_main", families: ["interacted"], location: crystalPos, maxDistance: 2 });
            if (relic.length > 0) {
                this.subStep = 3;
                this.save();
                backupTeleport.disable();
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.sith_relic_interact");
                }
                // queue action
                this.levelManager.queueAction(60, (tick) => {
                    // sound.spark.sith_relic_interact
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 1) {
                            players[i].fadeOut();
                            players[i].playSound("sound.spark.m_puzzle.palpatine_voice_start");
                        }
                        if (tick == 50) {
                            players[i].fadeIn();
                            LEVEL_MANAGER.addParallelAction(21, (tick) => {
                                if (tick != 20)
                                    return;
                                players[i].playSound("sound.spark.sith_fight_begin_final");
                            });
                        }
                    }
                    if (tick == 30) {
                        // despawn relic
                        relic[0].triggerEvent("spark:despawn");
                        let players = this.dimension.getPlayers();
                        for (let i = 0; i < players.length; i++) {
                            let zone = this.majorDuelZones[i];
                            players[i].teleport(zone.pStart, { facingLocation: zone.pFacing });
                            this.resetArena(zone, "spark:vision_darth_sidious", false);
                            // create arena tick here!
                            this.setupArenaTrigger(zone, "spark:vision_darth_sidious", "sound.spark.m_puzzle.palpatine_voice_end");
                        }
                        // play music
                        world.playMusic("sound.spark.music.StarWarsROTSB", { loop: true, fade: 2.0 });
                        this.enableDuelSettings();
                    }
                });
                self.disabled = true;
            }
        });
        // detect death...
        this.createTrigger(Vector.zero, Vector.zero, (self) => {
            // while in this state we will poll for players in the correct zone
            // once all players have the correct tag, remove tag and goto next stage!
            let finishedPlayers = this.dimension.getPlayers({ tags: ["pz_i_win"] });
            let totalPlayers = this.dimension.getPlayers().length;
            if (totalPlayers == 0)
                return;
            if (finishedPlayers.length == totalPlayers) {
                this.levelManager.addParallelAction(140, (tick) => {
                    let players = this.dimension.getPlayers();
                    for (let i = 0; i < players.length; i++) {
                        if (tick == 105) {
                            players[i].enableCutsceneSettings();
                            players[i].fadeOut();
                            players[i].clearPersistentUI();
                        }
                    }
                    if (tick == 80) {
                        this.dimension.runCommandAsync("music stop 3.0");
                    }
                    if (tick == 139) {
                        this.levelManager.addParallelAction(30, (tick) => {
                            let players = this.dimension.getPlayers();
                            for (let i = 0; i < players.length; i++) {
                                if (tick == 25) {
                                    players[i].disableCutsceneSettings();
                                    players[i].setDefaultHotbarLoadout();
                                    players[i].teleport(this.hubReturnLocation, { facingLocation: this.huhReturnFacingLocation });
                                    players[i].fadeIn("sound.spark.return_from_vision");
                                    players[i].removeTag("pz_i_win");
                                }
                            }
                            if (tick == 29) {
                                this.disableDuelSettings();
                                this.createTrigger(this.hubX, this.hubY, (self) => {
                                    let yoda = this.dimension.getEntities({ type: "spark:yoda", location: this.hubYodaLocation, maxDistance: 2 });
                                    if (yoda.length > 0) {
                                        setDialogue(yoda[0], "spark:puzzle.yoda.complete");
                                        self.disable();
                                    }
                                    // if no deaths, trigger achievement in a few ticks
                                    // update deaths on counter
                                    let remoteBoard = world.scoreboard.getObjective("achievement_display");
                                    if (remoteBoard != undefined) {
                                        if (!remoteBoard.hasParticipant("min_puzzle_deaths")) {
                                            remoteBoard.setScore("min_puzzle_deaths", 2000000);
                                        }
                                        let remoteValue = remoteBoard.getScore("min_puzzle_deaths");
                                        if (this.bossRoomDeaths < remoteValue) {
                                            remoteBoard.setScore("min_puzzle_deaths", this.bossRoomDeaths);
                                        }
                                    }
                                });
                                this.hubState = 1;
                                this.state = 999;
                            }
                        });
                    }
                });
                self.disable();
                return;
            }
            // notify all of those with the tag that they need to wait
            if (self.internalCounter % 100 == 0) {
                // spark.ui.puzzle.waiting_for_players
                let waiting = this.dimension.getPlayers({ tags: ["pz_i_win"] });
                for (const player of waiting) {
                    player.setTutorialMessage(13);
                }
            }
            self.internalCounter++;
        }, true);
    }
    // this will need to be processed from a trigger when a player is within the top part!
    t3CubeRespawn() {
        // get all entities including players
        let all = this.dimension.getEntities();
        // loop over t3KillZones
        for (let i = 0; i < this.t3KillZones.length; i++) {
            let zone = this.t3KillZones[i];
            for (let j = 0; j < all.length; j++) {
                let ent = all[j];
                if (!ent.isValid())
                    continue; // we can ignore this one!
                // this might break.
                if (isPointInsideAABB(ent.location, zone[0], zone[1])) {
                    // if this is a player, set tag
                    if (ent.typeId === "minecraft:player") {
                        if (ent.hasTag("elevator"))
                            continue;
                        if (isPointInsideAABB(ent.location, this.elevatorStartZone.min, this.elevatorStartZone.max))
                            continue;
                        if (!ent.hasTag("death")) {
                            ent.addTag("death");
                        }
                        continue;
                    }
                    // if they are a cube, with the tag of cube.
                    if (ent.hasTag("cube")) {
                        let tags = ent.getTags();
                        for (let k = 0; k < tags.length; k++) {
                            if (this.t3KillZonesTagMappings.has(tags[k])) {
                                ent.teleport(this.t3KillZonesTagMappings.get(tags[k]));
                                continue;
                            }
                        }
                    }
                }
            }
        }
    }
    updateHub() {
        if (this.isInHub()) {
            // set players respawn point here
            let players = this.dimension.getPlayers();
            for (let i = 0; i < players.length; i++) {
                // players[i].setSpawnPoint({ dimension: this.dimension, x: 6147.5, y: 61, z: 9348.5 });
                this.setRespawnPoint(players[i], { x: 6147.5, y: 61, z: 9348.5 });
            }
            // we have never gotten to the hub before!
            // make sure to spawn yoda with default stuff
            if (this.hubState == 0) {
                // check to see if yoda is there, if not, summonvvv
                let isYodaInLocation = this.dimension.getEntities({ type: "spark:yoda", location: this.hubYodaLocation, maxDistance: 3 });
                // remove yoda if he exists
                if (isYodaInLocation.length > 0) {
                    for (let i = 0; i < isYodaInLocation.length; i++) {
                        this.removeMob(isYodaInLocation[i]);
                    }
                }
                // let yoda = this.dimension.spawnEntity("spark:yoda", { x: 6147.5, y: 61, z: 9388.5 });
                // yoda.teleport(yoda.location, { facingLocation: { x: 6147.5, y: 61, z: 9357.5 } });
                // yoda.triggerEvent("spark:quest_npc");
                LEVEL_MANAGER.differSpawn("spark:yoda", this.hubYodaLocation, this.dimension, undefined, (e) => {
                    e.teleport(e.location, { facingLocation: { x: 6147.5, y: 61, z: 9357.5 } });
                    // make ticking area
                    if (this.yodaTickingArea == 0) {
                        this.dimension.runCommandAsync(`tickingarea add circle ${e.location.x} ${e.location.y} ${e.location.z} 2 scripting.yoda.hub true`);
                        this.yodaTickingArea = 1;
                    }
                    // force dialogue update here
                    system.runTimeout(() => {
                        setDialogue(e, "spark:puzzle.yoda.at_temples");
                    }, 2);
                }, [], ["spark:disable_lightsaber", "spark:quest_npc"]);
                // summon doors
                LEVEL_MANAGER.differSpawn("spark:invis_door", this.leftDoor, this.dimension);
                LEVEL_MANAGER.differSpawn("spark:invis_door", this.centerDoor, this.dimension);
                LEVEL_MANAGER.differSpawn("spark:invis_door", this.rightDoor, this.dimension);
                // remove tutorial message
                let players = this.dimension.getPlayers();
                for (let i = 0; i < players.length; i++) {
                    let player = players[i];
                    player.setTutorialMessage(0);
                    player.displayLocation(LocationLang.TorrenHub, "sound.spark.enter_custom2");
                    // players[i].setSpawnPoint({ dimension: this.dimension, x: 6233, y: 60, z: 9042 });
                    this.setRespawnPoint(players[i], { x: 6233, y: 60, z: 9042 });
                }
                // idk if this works!
                // system.runTimeout(() => {
                //     setDialogue(yoda, "spark:puzzle.yoda.at_temples");
                // });
                this.hubState = 1;
            }
            // detect when yoda has been spoken to, and summon the thing
            // puzzle.yoda.temple_1.accepted, then summon the entrance to the temple
            // and start a cutscene
            if (this.hubState == 1) {
                let afterTalkQuigon = this.dimension.getEntities({ type: "spark:yoda", tags: ["puzzle.yoda.quigon_story.accepted"], location: { x: 6147, y: 61, z: 9388 }, maxDistance: 3 });
                if (afterTalkQuigon.length > 0) {
                    // remove tag
                    afterTalkQuigon[0].removeTag("puzzle.yoda.quigon_story.accepted");
                    this.leftDoorActive = 1;
                    // set tutorial task
                    for (const player of this.dimension.getPlayers()) {
                        player.setTutorialMessage(6002);
                    }
                    // queue cutscene
                    this.hubState = 999;
                    this.state = 1;
                }
                let afterTalkDooku = this.dimension.getEntities({ type: "spark:yoda", tags: ["puzzle.yoda.dooku_story.accepted"], location: { x: 6147, y: 61, z: 9388 }, maxDistance: 3 });
                if (afterTalkDooku.length > 0) {
                    // remove tag
                    afterTalkDooku[0].removeTag("puzzle.yoda.dooku_story.accepted");
                    this.rightDoorActive = 1;
                    this.leftDoorActive = 0;
                    // set tutorial task
                    for (const player of this.dimension.getPlayers()) {
                        player.setTutorialMessage(6003);
                    }
                    this.hubState = 999;
                    this.state = 1;
                }
                // this doesnt get detected correctly...
                // disable npc after each update or something?
                let afterTalkSith = this.dimension.getEntities({ type: "spark:yoda", tags: ["puzzle.yoda.sith_story.accepted"], location: { x: 6147, y: 61, z: 9388 }, maxDistance: 3 });
                if (afterTalkSith.length > 0) {
                    // remove tag
                    afterTalkSith[0].removeTag("puzzle.yoda.sith_story.accepted");
                    this.centerDoorActive = 1;
                    this.rightDoorActive = 0;
                    // set tutorial task
                    for (const player of this.dimension.getPlayers()) {
                        player.setTutorialMessage(6004);
                    }
                    this.hubState = 999;
                    this.state = 1;
                }
                // final stuff
                let afterTalkTempleEnd = this.dimension.getEntities({ type: "spark:yoda", tags: ["puzzle.yoda.complete.accepted"], location: { x: 6147, y: 61, z: 9388 }, maxDistance: 3 });
                if (afterTalkTempleEnd.length > 0) {
                    // remove tag
                    afterTalkTempleEnd[0].removeTag("puzzle.yoda.complete.accepted");
                    this.centerDoorActive = 0;
                    // announce solved
                    // remove task
                    let announcement = {
                        rawtext: [
                            {
                                text: "hud:announce:§x"
                            },
                            {
                                translate: "puzzle.planet_2.mission_end.announcement.mysteries_solved.announcement1"
                            }
                        ]
                    };
                    for (const player of this.dimension.getPlayers()) {
                        player.setTask(0);
                        player.onScreenDisplay.setActionBar(announcement);
                        player.playSound("sound.spark.success_major");
                    }
                    LEVEL_MANAGER.addParallelAction(2, (tick) => {
                        if (tick != 1)
                            return;
                        for (const player of this.dimension.getPlayers()) {
                            player.onScreenDisplay.setActionBar(announcement);
                        }
                    });
                    // wait to queue cutscene
                    LEVEL_MANAGER.addParallelAction(81, (tick) => {
                        if (tick == 80) {
                            // ch10_c05
                            this.dimension.runCommandAsync("function spark/cutscene/start_ch02_c11");
                            if (this.isFirstPlaythrough == 0) {
                                world.scoreboard.getObjective("CS_trigger").setScore(".cs_corusc_alt", 2);
                                this.isFirstPlaythrough = 1;
                                this.save();
                            }
                            // add scoreboard shit here
                            LEVEL_MANAGER.addParallelAction(561, (tick) => {
                                if (tick == 560) {
                                    for (const player of world.getDimension("overworld").getPlayers({ tags: ["is_host"] })) {
                                        player.runCommandAsync("function spark/achievement/trigger/puzzle");
                                    }
                                }
                            });
                            // pull a scoreboard value from somewhere!
                            LEVEL_MANAGER.addParallelAction(701, (tick) => {
                                if (tick == 700) {
                                    for (const player of world.getDimension("overworld").getPlayers({ tags: ["is_host"] })) {
                                        player.runCommandAsync("execute if score min_puzzle_deaths achievement_display matches 0 run function spark/achievement/trigger/puzzle_post");
                                    }
                                }
                            });
                            this.stop();
                        }
                    });
                }
            }
            if (this.hubState == 999) {
                // the await state, will do wait for players to do stuff
                // will make sure things are in the correct place and respawn them
                // make sure all doors are summoned correctly, do not setup anything else on them
                let doorLeft = this.dimension.getEntities({ type: "spark:invis_door", location: this.leftDoor, maxDistance: 2 });
                let doorRight = this.dimension.getEntities({ type: "spark:invis_door", location: this.rightDoor, maxDistance: 2 });
                let doorCenter = this.dimension.getEntities({ type: "spark:invis_door", location: this.centerDoor, maxDistance: 2 });
                if (doorLeft.length == 0) {
                    LEVEL_MANAGER.differSpawn("spark:invis_door", this.leftDoor, this.dimension);
                }
                if (doorRight.length == 0) {
                    LEVEL_MANAGER.differSpawn("spark:invis_door", this.rightDoor, this.dimension);
                }
                if (doorCenter.length == 0) {
                    LEVEL_MANAGER.differSpawn("spark:invis_door", this.centerDoor, this.dimension);
                }
                // if they exist, and are active, trigger particle effect
                if (doorLeft.length > 0) {
                    if (this.leftDoorActive == 1) {
                        // if we do not have the family of interacted, play effect
                        let active = this.dimension.getEntities({ type: "spark:invis_door", families: ["interacted"], location: this.leftDoor, maxDistance: 2 });
                        if (active.length > 0) {
                            // we have the interact tag, need to trigger a load to the next area
                            this.hubState = -1;
                            // save states
                            this.state = 2;
                            this.save();
                            this.queueFastTransition(this.leftDoorTriggerSendLocation, this.leftDoorTriggerFaceLocation);
                            this.createTempleOneTriggers();
                            // despawn trigger just in case
                            active[0].triggerEvent("spark:despawn");
                            return;
                        }
                        if (active.length == 0) {
                            this.trySpawnParticle("spark:entrance_icon", Vector.add(doorLeft[0].location, this.doorPaticleOffset));
                        }
                    }
                }
                // if they exist, and are active, trigger particle effect
                if (doorRight.length > 0) {
                    if (this.rightDoorActive == 1) {
                        // if we do not have the family of interacted, play effect
                        let active = this.dimension.getEntities({ type: "spark:invis_door", families: ["interacted"], location: this.rightDoor, maxDistance: 2 });
                        if (active.length > 0) {
                            // we have the interact tag, need to trigger a load to the next area
                            this.hubState = -1;
                            this.state = 3;
                            this.save();
                            this.queueFastTransition(this.rightDoorTriggerSendLocation, this.rightDoorTriggerFaceLocation);
                            this.createTempleTwoTriggers();
                            // despawn door
                            active[0].triggerEvent("spark:despawn");
                        }
                        if (active.length == 0) {
                            this.trySpawnParticle("spark:entrance_icon", Vector.add(doorRight[0].location, this.doorPaticleOffset));
                        }
                    }
                }
                // if they exist, and are active, trigger particle effect
                if (doorCenter.length > 0) {
                    if (this.centerDoorActive == 1) {
                        // if we do not have the family of interacted, play effect
                        let active = this.dimension.getEntities({ type: "spark:invis_door", families: ["interacted"], location: this.centerDoor, maxDistance: 2 });
                        if (active.length > 0) {
                            // we have the interact tag, need to trigger a load to the next area
                            this.hubState = -1;
                            this.state = 4;
                            this.save();
                            this.queueFastTransition(this.centerDoorTriggerSendLocation, this.centerDoorTriggerFaceLocation, "sound.spark.enter_sith_temple_major");
                            this.createTempleThreeTriggers();
                            active[0].triggerEvent("spark:despawn");
                        }
                        if (active.length == 0) {
                            this.trySpawnParticle("spark:entrance_icon", Vector.add(doorCenter[0].location, this.doorPaticleOffset));
                        }
                    }
                }
            }
        }
    }
    isInHub() {
        let players = this.dimension.getPlayers();
        // detect if a player is in hubZone
        for (let i = 0; i < players.length; i++) {
            let p = players[i];
            if (isPointInsideAABB(p.location, this.hubX, this.hubY)) {
                return true;
            }
        }
        return false;
    }
    removeMob(e) {
        let loc = e.location;
        loc.y += 100;
        e.teleport(loc);
        e.triggerEvent("spark:despawn");
    }
    trySpawnParticle(name, location) {
        try {
            this.dimension.spawnParticle(name, location, this.particleMap);
        }
        catch {
        }
    }
    queueFastTransition(pos, lookAt, templeSound = "sound.spark.enter_sith_temple_minor") {
        this.levelManager.queueAction(31, (tick) => {
            let players = this.dimension.getPlayers();
            // fade out at start
            if (tick == 1) {
                for (let i = 0; i < players.length; i++) {
                    players[i].fadeOut();
                }
            }
            if (tick == 25) {
                for (let i = 0; i < players.length; i++) {
                    players[i].teleport(pos, { facingLocation: lookAt });
                }
            }
            if (tick == 30) {
                for (let i = 0; i < players.length; i++) {
                    players[i].fadeIn(templeSound);
                }
            }
        });
    }
    processDeaths() {
        let players = this.dimension.getPlayers();
        // if a player enters this for the first time, tag them
        for (let i = 0; i < players.length; i++) {
            let player = players[i];
            if (player.hasTag("death")) {
                // get player value
                if (!this.playerDeathTimer.has(player.id))
                    this.playerDeathTimer.set(player.id, 0);
                let time = this.playerDeathTimer.get(player.id);
                if (time === undefined)
                    time = 0;
                // need to make a way to set a death point for a player
                // depending on where they are in the level.
                if (time == 1) {
                    player.fadeOut();
                }
                if (time == 31) {
                    this.respawnPlayer(player);
                }
                if (time == 40) {
                    player.fadeIn();
                    player.removeTag("death");
                    this.playerDeathTimer.set(player.id, 0);
                    continue;
                }
                // teleport, or have a spawnpoint set...
                time++;
                this.playerDeathTimer.set(player.id, time);
            }
        }
    }
    isCubeOnPlate(plate) {
        let amount = 0;
        for (let x = -1; x < 2; x++) {
            for (let z = -1; z < 2; z++) {
                let searchPos = Vector.add(plate, { x: x, y: 0, z: z });
                try {
                    let block = this.dimension.getBlock(searchPos);
                    if (block == undefined)
                        return false;
                    if (block.permutation.matches("spark:force_box_collision")) {
                        amount++;
                    }
                }
                catch {
                    // nothing needed
                }
            }
        }
        if (amount >= this.maxRequiredBlocksOnPlate) {
            return true;
        }
        return false;
    }
    // ---------------------------------- //
    // --------- t3 soom stuffs --------- //
    // ---------------------------------- //  
    leftRoomStuff() {
        let roomTag = "rm_l";
        let cubeTag = "cube";
        let powerCubePos = { x: 5489.5, y: 106, z: 8833.5 };
        let smallConductCube1 = { x: 5493.5, y: 108, z: 8842.5 };
        let medConductCube1 = { x: 5494.5, y: 108, z: 8824.5 };
        let medConductCube2 = { x: 5511.5, y: 113, z: 8827.5 };
        let endCube = { x: 5528.5, y: 113, z: 8833.5 };
        let lockedDoor = { x: 5522.5, y: 112, z: 8833.5 }; //east
        let resetButtonLocation = { x: 5484.5, y: 107, z: 8836.5 };
        let resetButtonEvent = "spark:set_north";
        LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag], [resetButtonEvent]);
        summonPowerSource(powerCubePos, ["left_pw", roomTag, cubeTag, "power_id_1"]);
        this.t3KillZonesTagMappings.set("power_id_1", powerCubePos);
        summonConductorSmall(smallConductCube1, ["left_con_0", roomTag, cubeTag, "small_con_0", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_0", smallConductCube1);
        summonConductorMedium(medConductCube1, ["left_con_1", roomTag, cubeTag, "med_con_0", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_0", medConductCube1);
        summonConductorMedium(medConductCube2, ["left_con_2", roomTag, cubeTag, "med_con_1", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_1", medConductCube2);
        summonAurebeshObstacle(endCube, "spark:set_type_0", ["aure_0", roomTag, cubeTag, "important"]);
        this.t3KillZonesTagMappings.set("aure_0", endCube);
        // door
        LEVEL_MANAGER.differSpawn("spark:torren_gate_small", lockedDoor, world.getDimension("overworld"), undefined, undefined, [roomTag], ["spark:door_east"]);
        // triggers and such
        let boundsMin = { x: 5477, y: 102, z: 8808 };
        let boundsMax = { x: 5537, y: 149, z: 8859 };
        let powerPosition = { x: 5492.5, y: 106, z: 8833.5 };
        // power lines
        let power2Wall = new LinearWirePath(this.dimension);
        power2Wall.spline = [
            { x: 5493, y: 105, z: 8833 },
            { x: 5504, y: 105, z: 8833 }
        ];
        let powerWall2Pit = new LinearWirePath(this.dimension);
        powerWall2Pit.spline = [
            { x: 5505, y: 111, z: 8833 },
            { x: 5513, y: 111, z: 8833 }
        ];
        let powerPit2Door = new LinearWirePath(this.dimension);
        powerPit2Door.spline = [
            { x: 5516, y: 111, z: 8833 },
            { x: 5521, y: 111, z: 8833 }
        ];
        this.createTrigger(boundsMin, boundsMax, (self) => {
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT3LeftRoom();
                self.disable();
            }
            let powerCubeInPlace = false;
            let wallInPlace = false;
            let pitInPlace = false;
            // remove important tag on everything but the special cubes
            for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                cubes.removeTag("important");
            }
            let powerCubeOnConnector = this.dimension.getEntities({ type: "spark:power_source", location: powerPosition, maxDistance: 0.5 });
            if (powerCubeOnConnector.length > 0) {
                if (isBlockOfType(this.dimension, powerPosition, "spark:force_box_collision")) {
                    powerCubeInPlace = true;
                }
            }
            let wallCounter = 0;
            for (let y = 106; y < 112; y++) {
                let pos = { x: 5504.5, y: y, z: 8833.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            wallCounter++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (wallCounter == 6) {
                wallInPlace = true;
            }
            let pitCounter = 0;
            for (let x = 5514; x < 5516; x++) {
                let pos = { x: x + 0.5, y: 111, z: 8833.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock != undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            pitCounter++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (pitCounter == 2) {
                pitInPlace = true;
            }
            if (powerCubeInPlace && wallInPlace && pitInPlace) {
                let door = this.dimension.getEntities({ type: "spark:torren_gate_small", location: lockedDoor, maxDistance: 2 });
                if (door.length > 0) {
                    door[0].triggerEvent("spark:open_door");
                    self.disabled = true;
                    // remove important tag on everything but the special cubes
                    for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                        cubes.removeTag("important");
                    }
                    this.t3LeftFinished = 1;
                    this.save();
                }
            }
            power2Wall.update(powerCubeInPlace);
            powerWall2Pit.update(powerCubeInPlace && wallInPlace);
            powerPit2Door.update(powerCubeInPlace && wallInPlace && pitInPlace);
        });
    }
    topRoomStuff() {
        let roomTag = "rm_t";
        let cubeTag = "cube";
        let powerCubeSpawn = { x: 5454.5, y: 106, z: 8864.5 };
        let smallCube1 = { x: 5451.5, y: 107, z: 8884.5 };
        let smallCube2 = { x: 5455.5, y: 107, z: 8884.5 };
        let smallCube3 = { x: 5451.5, y: 110, z: 8887.5 };
        let smallCube4 = { x: 5452.5, y: 112, z: 8899.5 };
        let largeCube1 = { x: 5456.5, y: 107, z: 8887.5 };
        let largeCube2 = { x: 5452.5, y: 107, z: 8887.5 };
        let largeCube3 = { x: 5455.5, y: 112, z: 8899.5 };
        let endCubeType1 = { x: 5462.5, y: 112, z: 8912.5 };
        let endCubeType2 = { x: 5446.5, y: 112, z: 8912.5 };
        let doorEndCube1 = { x: 5462.5, y: 111, z: 8906.5 }; // north
        let doorEndCube2 = { x: 5446.5, y: 111, z: 8906.5 }; // north
        let resetButtonLocation = { x: 5451.5, y: 107, z: 8864.5 };
        let resetButtonEvent = "spark:set_east";
        LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag], [resetButtonEvent]);
        summonPowerSource(powerCubeSpawn, ["top_pw", roomTag, cubeTag, "power_id_2"]);
        this.t3KillZonesTagMappings.set("power_id_2", powerCubeSpawn);
        summonConductorSmall(smallCube1, ["top_con_0", roomTag, cubeTag, "small_con_1", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_1", smallCube1);
        summonConductorSmall(smallCube2, ["top_con_1", roomTag, cubeTag, "small_con_2", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_2", smallCube2);
        summonConductorSmall(smallCube3, ["top_con_2", roomTag, cubeTag, "small_con_3", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_3", smallCube3);
        summonConductorSmall(smallCube4, ["top_con_3", roomTag, cubeTag, "small_con_4", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_4", smallCube4);
        summonConductorMedium(largeCube1, ["top_con_4", roomTag, cubeTag, "med_con_2", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_2", largeCube1);
        summonConductorMedium(largeCube2, ["top_con_5", roomTag, cubeTag, "med_con_3", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_3", largeCube2);
        summonConductorMedium(largeCube3, ["top_con_6", roomTag, cubeTag, "med_con_4", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_4", largeCube3);
        summonAurebeshObstacle(endCubeType1, "spark:set_type_1", ["aure_1", roomTag, cubeTag, "important"]);
        this.t3KillZonesTagMappings.set("aure_1", endCubeType1);
        summonAurebeshObstacle(endCubeType2, "spark:set_type_2", ["aure_2", roomTag, cubeTag, "important"]);
        this.t3KillZonesTagMappings.set("aure_2", endCubeType2);
        // doors
        LEVEL_MANAGER.differSpawn("spark:torren_gate_small", doorEndCube1, world.getDimension("overworld"), undefined, undefined, [roomTag], ["spark:door_north"]);
        LEVEL_MANAGER.differSpawn("spark:torren_gate_small", doorEndCube2, world.getDimension("overworld"), undefined, undefined, [roomTag], ["spark:door_north"]);
        // triggers and such
        let boundsMin = { x: 5433, y: 104, z: 8856 };
        let boundsMax = { x: 5485, y: 146, z: 8926 };
        let powerPosition = { x: 5454.5, y: 106, z: 8868.5 };
        // power lines
        let powerT = new LinearWirePath(this.dimension);
        powerT.spline = [
            { x: 5454, y: 105, z: 8869 },
            { x: 5454, y: 105, z: 8873 },
            { x: 5451, y: 105, z: 8873 },
            { x: 5457, y: 105, z: 8873 }
        ];
        let leftLowerLine = new LinearWirePath(this.dimension);
        leftLowerLine.spline = [
            { x: 5460, y: 105, z: 8873 },
            { x: 5462, y: 105, z: 8873 },
            { x: 5462, y: 105, z: 8881 }
        ];
        let leftWallLine = new LinearWirePath(this.dimension);
        leftWallLine.spline = [
            { x: 5462, y: 110, z: 8882 },
            { x: 5462, y: 110, z: 8891 }
        ];
        let leftDoorLine = new LinearWirePath(this.dimension);
        leftDoorLine.spline = [
            { x: 5462, y: 110, z: 8895 },
            { x: 5462, y: 110, z: 8905 }
        ];
        let rightLowerLine = new LinearWirePath(this.dimension);
        rightLowerLine.spline = [
            { x: 5447, y: 105, z: 8873 },
            { x: 5446, y: 105, z: 8873 },
            { x: 5446, y: 105, z: 8881 }
        ];
        let rightWallLine = new LinearWirePath(this.dimension);
        rightWallLine.spline = [
            { x: 5446, y: 110, z: 8882 },
            { x: 5446, y: 110, z: 8891 }
        ];
        let rightDoorLine = new LinearWirePath(this.dimension);
        rightDoorLine.spline = [
            { x: 5446, y: 110, z: 8894 },
            { x: 5446, y: 110, z: 8905 }
        ];
        this.createTrigger(boundsMin, boundsMax, (self) => {
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT3TopRoom();
                self.disable();
            }
            let powerCubeInPlace = false;
            let leftPitInPlace = false;
            let leftWallInPlace = false;
            let leftDoorInPlace = false;
            let rightPitInPlace = false;
            let rightWallInPlace = false;
            let rightDoorInPlace = false;
            let sideComplete = 0;
            for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                cubes.removeTag("important");
            }
            let powerCubeOnConnector = this.dimension.getEntities({ type: "spark:power_source", location: powerPosition, maxDistance: 0.5 });
            if (powerCubeOnConnector.length > 0) {
                if (isBlockOfType(this.dimension, powerPosition, "spark:force_box_collision")) {
                    powerCubeInPlace = true;
                }
            }
            // left stuff
            let leftPitCount = 0;
            for (let x = 5458; x < 5460; x++) {
                let pos = { x: x + 0.5, y: 105, z: 8873.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            leftPitCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (leftPitCount == 2) {
                leftPitInPlace = true;
            }
            let leftWallCount = 0;
            for (let y = 106; y < 111; y++) {
                let pos = { x: 5462.5, y: y, z: 8881.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            leftWallCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (leftWallCount == 5) {
                leftWallInPlace = true;
            }
            let leftDoorCount = 0;
            for (let z = 8892; z < 8895; z++) {
                let pos = { x: 5462.5, y: 110, z: z + 0.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            leftDoorCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (leftDoorCount == 3) {
                leftDoorInPlace = true;
            }
            // right stuff
            let rightPitCount = 0;
            for (let x = 5448; x < 5451; x++) {
                let pos = { x: x + 0.5, y: 105, z: 8873.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            rightPitCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (rightPitCount == 3) {
                rightPitInPlace = true;
            }
            let rightWallCount = 0;
            for (let y = 106; y < 111; y++) {
                let pos = { x: 5446.5, y: y, z: 8881.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            rightWallCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (rightWallCount == 5) {
                rightWallInPlace = true;
            }
            let rightDoorCount = 0;
            for (let z = 8892; z < 8894; z++) {
                let pos = { x: 5446.5, y: 110, z: z + 0.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            rightDoorCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (rightDoorCount == 2) {
                rightDoorInPlace = true;
            }
            if (powerCubeInPlace) {
                // left side
                let leftSide = this.dimension.getEntities({ type: "spark:torren_gate_small", location: doorEndCube1, maxDistance: 0.5 });
                if (leftSide.length > 0) {
                    if (!leftSide[0].hasTag("open")) {
                        if (leftPitInPlace && leftWallInPlace && leftDoorInPlace) {
                            leftSide[0].triggerEvent("spark:open_door");
                        }
                    }
                }
                // if no door, side is finished
                if (leftSide.length == 0) {
                    sideComplete++;
                }
                let rightSide = this.dimension.getEntities({ type: "spark:torren_gate_small", location: doorEndCube2, maxDistance: 0.5 });
                if (rightSide.length > 0) {
                    if (!rightSide[0].hasTag("open")) {
                        if (rightPitInPlace && rightWallInPlace && rightDoorInPlace) {
                            rightSide[0].triggerEvent("spark:open_door");
                        }
                    }
                }
                // if no door, side is finished
                if (rightSide.length == 0) {
                    sideComplete++;
                }
                if (sideComplete == 2) {
                    self.disable();
                    // remove important tag on everything but the special cubes
                    for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                        cubes.removeTag("important");
                    }
                    this.t3TopFinished = 1;
                    this.save();
                }
            }
            // power lines
            powerT.update(powerCubeInPlace);
            leftLowerLine.update(powerCubeInPlace && leftPitInPlace);
            leftWallLine.update(powerCubeInPlace && leftPitInPlace && leftWallInPlace);
            leftDoorLine.update(powerCubeInPlace && leftPitInPlace && leftWallInPlace && leftDoorInPlace);
            rightLowerLine.update(powerCubeInPlace && rightPitInPlace);
            rightWallLine.update(powerCubeInPlace && rightPitInPlace && rightWallInPlace);
            rightDoorLine.update(powerCubeInPlace && rightPitInPlace && rightWallInPlace && rightDoorInPlace);
        });
    }
    rightRoomStuff() {
        let roomTag = "rm_r";
        let cubeTag = "cube";
        let powerCubeSpawn = { x: 5387.5, y: 122, z: 8833.5 };
        let smallCube1 = { x: 5406.5, y: 126, z: 8863.5 };
        let largeCube1 = { x: 5370.5, y: 125, z: 8833.5 };
        let largeCube2 = { x: 5356.5, y: 128, z: 8863.5 };
        let endCube = { x: 5382.5, y: 123, z: 8882.5 };
        let doorEnd = { x: 5382.5, y: 122, z: 8876.5 }; // north
        let resetButtonLocation = { x: 5388.5, y: 123, z: 8842.5 };
        let resetButtonEvent = "spark:set_north";
        LEVEL_MANAGER.differSpawn("spark:torren_button", resetButtonLocation, this.dimension, undefined, undefined, [roomTag], [resetButtonEvent]);
        summonPowerSource(powerCubeSpawn, ["right_pw", roomTag, cubeTag, "power_id_3"]);
        this.t3KillZonesTagMappings.set("power_id_3", powerCubeSpawn);
        summonConductorSmall(smallCube1, ["right_con_0", roomTag, cubeTag, "small_con_5", "conductive"]);
        this.t3KillZonesTagMappings.set("small_con_5", smallCube1);
        summonConductorMedium(largeCube1, ["right_con_1", roomTag, cubeTag, "med_con_4", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_4", largeCube1);
        summonConductorMedium(largeCube2, ["right_con_2", roomTag, cubeTag, "med_con_5", "conductive"]);
        this.t3KillZonesTagMappings.set("med_con_5", largeCube2);
        summonAurebeshObstacle(endCube, "spark:set_type_3", ["aure_3", roomTag, cubeTag, "important"]);
        this.t3KillZonesTagMappings.set("aure_3", endCube);
        // doors
        LEVEL_MANAGER.differSpawn("spark:torren_gate_small", doorEnd, world.getDimension("overworld"), undefined, undefined, [roomTag], ["spark:door_north"]);
        // triggers and such
        let boundsMin = { x: 5347, y: 60, z: 8809 };
        let boundsMax = { x: 5431, y: 152, z: 8887 };
        let powerPosition = { x: 5382.5, y: 122, z: 8833.5 };
        // power lines
        let firstPowerLine = new LinearWirePath(this.dimension);
        firstPowerLine.spline = [
            { x: 5382.5, y: 121, z: 8833.5 },
            { x: 5382.5, y: 121, z: 8843.5 }
        ];
        let secondPowerLine = new LinearWirePath(this.dimension);
        secondPowerLine.spline = [
            { x: 5382.5, y: 121, z: 8846.5 },
            { x: 5382.5, y: 121, z: 8850.5 }
        ];
        let thirdPowerLine = new LinearWirePath(this.dimension);
        thirdPowerLine.spline = [
            { x: 5382.5, y: 121, z: 8854.5 },
            { x: 5382.5, y: 121, z: 8875.5 }
        ];
        let stupidFix = computeBounds({ x: 5384, y: 116, z: 8850 }, { x: 5379, y: 119, z: 8854 });
        this.createTrigger(boundsMin, boundsMax, (self) => {
            // detect reset button status
            let resetButtonSelector = this.dimension.getEntities({ type: "spark:torren_button", location: resetButtonLocation, maxDistance: 1, families: ["interacted"] });
            if (resetButtonSelector.length > 0) {
                for (const player of this.dimension.getPlayers()) {
                    player.playSound("sound.spark.m_puzzle.reset");
                }
                // trigger reset 
                this.resetT3RightRoom();
                self.disable();
            }
            let powerCubeInPlace = false;
            let firstGapInPlace = false;
            let secondGapInPlace = false;
            for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                cubes.removeTag("important");
            }
            let powerCubeOnConnector = this.dimension.getEntities({ type: "spark:power_source", location: powerPosition, maxDistance: 0.5 });
            if (powerCubeOnConnector.length > 0) {
                if (isBlockOfType(this.dimension, powerPosition, "spark:force_box_collision")) {
                    powerCubeInPlace = true;
                }
            }
            // if there is an entity at { x: 5382.5, y: 118, z: 8853 } stupidFix
            for (const cube of this.dimension.getEntities({ tags: [roomTag], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                if (isPointInsideAABB(cube.location, stupidFix.min, stupidFix.max)) {
                    if (!cube.hasTag("important"))
                        cube.addTag("important");
                }
            }
            let firstGapCount = 0;
            for (let z = 8844; z < 8846; z++) {
                let pos = { x: 5382.5, y: 121, z: z + 0.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            firstGapCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (firstGapCount == 2) {
                firstGapInPlace = true;
            }
            let secondGapCount = 0;
            for (let z = 8851; z < 8854; z++) {
                let pos = { x: 5382.5, y: 121, z: z + 0.5 };
                let conductBlock = this.dimension.getBlock(pos);
                if (conductBlock !== undefined) {
                    // get type
                    if (conductBlock.permutation.matches("spark:force_box_collision")) {
                        // get entity at that pos
                        let ent = this.dimension.getEntities({ tags: ["conductive"], location: pos });
                        if (ent.length > 0) {
                            secondGapCount++;
                            // tag that entity as important
                            if (!ent[0].hasTag("important"))
                                ent[0].addTag("important");
                        }
                    }
                }
            }
            if (secondGapCount == 3) {
                secondGapInPlace = true;
            }
            if (powerCubeInPlace) {
                let doorSelect = this.dimension.getEntities({ type: "spark:torren_gate_small", location: doorEnd, maxDistance: 0.5 });
                if (doorSelect.length > 0) {
                    if (firstGapInPlace && secondGapInPlace) {
                        doorSelect[0].triggerEvent("spark:open_door");
                        this.t3RightFinished = 1;
                        this.save();
                        for (const cubes of this.dimension.getEntities({ tags: [roomTag, "important"], excludeTypes: ["spark:aurebesh_obstacle_m"] })) {
                            cubes.removeTag("important");
                        }
                        self.disable();
                    }
                }
            }
            // power lines
            firstPowerLine.update(powerCubeInPlace);
            secondPowerLine.update(powerCubeInPlace && firstGapInPlace);
            thirdPowerLine.update(powerCubeInPlace && firstGapInPlace && secondGapInPlace);
        });
        // respawn point 5392 121 8843 5375 129 8823
        let rightRoomRespawnTrigger = computeBounds({ x: 5392, y: 121, z: 8843 }, { x: 5375, y: 129, z: 8823 });
        this.createTrigger(rightRoomRespawnTrigger.min, rightRoomRespawnTrigger.max, (self) => {
            for (const player of this.dimension.getPlayers()) {
                this.setRespawnPoint(player, { x: 5382.5, y: 122, z: 8833.5 });
            }
        });
    }
    // ------------------------------ //
    // --------- room reset --------- //
    // ------------------------------ //   
    resetT1Room1() {
        let templeZone1Min = { x: 5830, y: -44, z: 8810 };
        let templeZone1Max = { x: 5901, y: 32, z: 8889 };
        let searchBounds = new BlockAreaSize(templeZone1Max.x - templeZone1Min.x, templeZone1Max.y - templeZone1Min.y, templeZone1Max.z - templeZone1Min.z);
        let cubeID = "cb";
        let roomTag = "rm1";
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, templeZone1Min, templeZone1Max)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                // let cubes = this.dimension.getEntities({ tags: [cubeID], location: templeZone1Min, volume: searchBounds })
                let cubes = this.dimension.getEntities({ tags: [cubeID] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        if (isPointInsideAABB(cubes[i].location, templeZone1Min, templeZone1Max)) {
                            cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        }
                    }
                }
                // remove plates
                // let stuff = this.dimension.getEntities({ tags: [roomTag], location: templeZone1Min, volume: searchBounds });
                let stuff = this.dimension.getEntities({ tags: [roomTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        if (isPointInsideAABB(stuff[i].location, templeZone1Min, templeZone1Max)) {
                            stuff[i].triggerEvent("spark:despawn");
                        }
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.setupPuzzle1();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, templeZone1Min, templeZone1Max)) {
                        player.fadeIn();
                    }
                }
            }
        });
        // this.setupPuzzle1();
        // this.setupPuzzle2();
    }
    resetT1Room2() {
        let templeZone2Min = { x: 5830, y: -6, z: 8691 };
        let templeZone2Max = { x: 5918, y: 40, z: 8807 };
        let searchBounds = new BlockAreaSize(templeZone2Max.x - templeZone2Min.x, templeZone2Max.y - templeZone2Min.y, templeZone2Max.z - templeZone2Min.z);
        let cubeID = "cb";
        let roomTag = "rm2";
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, templeZone2Min, templeZone2Max)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                // let cubes = this.dimension.getEntities({ tags: [cubeID], location: templeZone2Min, volume: searchBounds })
                let cubes = this.dimension.getEntities({ tags: [cubeID] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        if (isPointInsideAABB(cubes[i].location, templeZone2Min, templeZone2Max)) {
                            cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        }
                    }
                }
                // remove plates
                // let stuff = this.dimension.getEntities({ tags: [roomTag], location: templeZone2Min, volume: searchBounds });
                let stuff = this.dimension.getEntities({ tags: [roomTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        if (isPointInsideAABB(stuff[i].location, templeZone2Min, templeZone2Max)) {
                            stuff[i].triggerEvent("spark:despawn");
                        }
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.setupPuzzle2();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, templeZone2Min, templeZone2Max)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    resetT2Room1() {
        let p3BoundsMin = { x: 5707, y: -7, z: 8787 };
        let p3BoundsMax = { x: 5778, y: 25, z: 8886 };
        let searchBounds = new BlockAreaSize(p3BoundsMax.x - p3BoundsMin.x, p3BoundsMax.y - p3BoundsMin.y, p3BoundsMax.z - p3BoundsMin.z);
        let roomTag = "rm3";
        let cubeID = "cb";
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, p3BoundsMin, p3BoundsMax)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                // let cubes = this.dimension.getEntities({ tags: [cubeID], location: p3BoundsMin, volume: searchBounds });
                let cubes = this.dimension.getEntities({ tags: [cubeID] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        if (isPointInsideAABB(cubes[i].location, p3BoundsMin, p3BoundsMax)) {
                            cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        }
                    }
                }
                // remove plates
                // let stuff = this.dimension.getEntities({ tags: [roomTag], location: p3BoundsMin, volume: searchBounds });
                let stuff = this.dimension.getEntities({ tags: [roomTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        if (isPointInsideAABB(stuff[i].location, p3BoundsMin, p3BoundsMax)) {
                            stuff[i].triggerEvent("spark:despawn");
                        }
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.setupPuzzle3();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, p3BoundsMin, p3BoundsMax)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    resetT2Room2() {
        let p4BoundsMin = { x: 5714.5, y: -17, z: 8673.5 };
        let p4BoundsMax = { x: 5791.5, y: 12, z: 8796.5 };
        let searchBounds = new BlockAreaSize(p4BoundsMax.x - p4BoundsMin.x, p4BoundsMax.y - p4BoundsMin.y, p4BoundsMax.z - p4BoundsMin.z);
        let roomTag = "rm4";
        let cubeID = "cb";
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, p4BoundsMin, p4BoundsMax)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                // let cubes = this.dimension.getEntities({ tags: [cubeID], location: p4BoundsMin, volume: searchBounds });
                let cubes = this.dimension.getEntities({ tags: [cubeID] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        if (isPointInsideAABB(cubes[i].location, p4BoundsMin, p4BoundsMax)) {
                            cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                        }
                    }
                }
                // remove plates
                // let stuff = this.dimension.getEntities({ tags: [roomTag], location: p3BoundsMin, volume: searchBounds });
                let stuff = this.dimension.getEntities({ tags: [roomTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        if (isPointInsideAABB(stuff[i].location, p4BoundsMin, p4BoundsMax)) {
                            stuff[i].triggerEvent("spark:despawn");
                        }
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.setupPuzzle4();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, p4BoundsMin, p4BoundsMax)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    resetT3LeftRoom() {
        let tag = "rm_l";
        let cubeTag = "cube";
        // triggers and such
        let boundsMin = { x: 5477, y: 102, z: 8808 };
        let boundsMax = { x: 5537, y: 149, z: 8859 };
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                // let cubes = this.dimension.getEntities({ tags: [cubeID], location: p4BoundsMin, volume: searchBounds });
                let cubes = this.dimension.getEntities({ tags: [cubeTag, tag] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                    }
                }
                // remove plates
                let stuff = this.dimension.getEntities({ tags: [tag], excludeTags: [cubeTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        stuff[i].triggerEvent("spark:despawn");
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.leftRoomStuff();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    resetT3TopRoom() {
        let tag = "rm_t";
        let cubeTag = "cube";
        // triggers and such
        let boundsMin = { x: 5433, y: 104, z: 8856 };
        let boundsMax = { x: 5485, y: 146, z: 8926 };
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                let cubes = this.dimension.getEntities({ tags: [cubeTag, tag] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                    }
                }
                // remove plates
                let stuff = this.dimension.getEntities({ tags: [tag], excludeTags: [cubeTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        stuff[i].triggerEvent("spark:despawn");
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.topRoomStuff();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    resetT3RightRoom() {
        let tag = "rm_r";
        let cubeTag = "cube";
        // triggers and such
        let boundsMin = { x: 5347, y: 60, z: 8809 };
        let boundsMax = { x: 5431, y: 152, z: 8887 };
        LEVEL_MANAGER.addParallelAction(41, (tick) => {
            if (tick == 1) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeOut();
                    }
                }
            }
            // remove everything
            if (tick == 30) {
                let cubes = this.dimension.getEntities({ tags: [cubeTag, tag] });
                if (cubes.length > 0) {
                    for (let i = 0; i < cubes.length; i++) {
                        cubes[i].runCommandAsync("execute as @s run function spark/force/entity/box/despawn");
                    }
                }
                // remove plates
                let stuff = this.dimension.getEntities({ tags: [tag], excludeTags: [cubeTag] });
                if (stuff.length > 0) {
                    for (let i = 0; i < stuff.length; i++) {
                        stuff[i].triggerEvent("spark:despawn");
                    }
                }
                LEVEL_MANAGER.addParallelAction(3, (tick) => {
                    if (tick == 2) {
                        this.rightRoomStuff();
                    }
                });
            }
            if (tick == 40) {
                for (const player of this.dimension.getPlayers()) {
                    if (isPointInsideAABB(player.location, boundsMin, boundsMax)) {
                        player.fadeIn();
                    }
                }
            }
        });
    }
    // respawns
    respawnPlayer(p) {
        let id = p.id;
        if (this.playerDeathPoints.has(id)) {
            p.teleport(this.playerDeathPoints.get(id));
            p.addEffect("regeneration", 3, { amplifier: 20, showParticles: false });
            return;
        }
        // else respawn in mission start area...
        this.playerDeathPoints.set(id, { x: 6004, y: -60, z: 9001 });
        p.teleport(this.playerDeathPoints.get(id));
        p.addEffect("regeneration", 3, { amplifier: 20, showParticles: false });
    }
    setRespawnPoint(p, loc) {
        this.playerDeathPoints.set(p.id, loc);
    }
    // --------------------------- //
    // ---------- duels ---------- //
    // --------------------------- //
    setupArenaTrigger(arena, bossID, evaporatingSound = "sound.spark.sith_fight_end", isFinalBoss = false) {
        // get player inside of the area
        // get boss inside of areana
        // if player has the respwan tag, reset arena
        // if boss is dead or something, we have won!
        // we will do the resetting from this trigger
        // will not do the waiting state, that will be done elsewhere!
        this.createTrigger(arena.bounds.min, arena.bounds.max, (self) => {
            let players = this.dimension.getPlayers({ location: arena.bStart, maxDistance: 30 });
            if (players.length > 0) {
                let player = players[0];
                player.addEffect("slowness", 20, { amplifier: 0, showParticles: false });
                // get boss
                let bossSelector = this.dimension.getEntities({ type: bossID, location: arena.bStart, maxDistance: 30 });
                if (bossSelector.length > 0) {
                    let boss = bossSelector[0];
                    if (player.hasTag("pz_i_win")) {
                        player.playSound(evaporatingSound);
                        // disable trigger, we will do this from the other trigger
                        self.disable();
                    }
                    if (boss.hasTag("script_defeated")) {
                        player.addTag("pz_i_win");
                        boss.removeTag("script_defeated");
                    }
                    if (player.hasTag("resetting")) {
                        // the trigger will handle resetting the arena!
                        self.internalCounter = 1;
                        player.removeTag("resetting");
                        // disable boss
                        boss.triggerEvent("spark:sitting");
                        boss.triggerEvent("end_dueling");
                        // end sound
                        if (isFinalBoss) {
                            LEVEL_MANAGER.addParallelAction(61, (tick) => {
                                if (tick != 60)
                                    return;
                                player.playSound("sound.spark.sith_defeated_final");
                            });
                        }
                    }
                }
                if (self.internalCounter > 0) {
                    // if counter is 20, we have full fade
                    if (self.internalCounter == 20) {
                        // cleanup!
                        this.resetArena(arena, bossID, true);
                        // teleport player
                        player.teleport(arena.pStart, { facingLocation: arena.pFacing });
                        self.internalCounter = 0;
                        return;
                    }
                    self.internalCounter++;
                }
            }
        });
    }
    resetArena(arena, boss, fromRoom) {
        // create a trigger that will wait for the center block to be loaded, then will do cleanup
        this.createTrigger(arena.bounds.min, arena.bounds.max, (self) => {
            if (isPositionLoaded(this.dimension, arena.bStart)) {
                // despawn boss
                for (const e of this.dimension.getEntities({ families: ["duel_opponent"], location: arena.bStart, maxDistance: 30 })) {
                    e.triggerEvent("spark:despawn");
                }
                // queue respawn, dont need an event as we are doing a count down to start or something!
                LEVEL_MANAGER.differSpawn(boss, arena.bStart, this.dimension, () => {
                    system.runTimeout(() => {
                        let self = this.dimension.getEntities({ type: boss, location: arena.bStart });
                        if (self.length > 0) {
                            self[0].triggerEvent("start_dueling");
                        }
                    }, 20);
                });
                if (fromRoom) {
                    this.bossRoomDeaths += 1;
                }
                self.disable();
            }
        });
    }
    setupDuelZones() {
        this.minorDuelZones.push({
            bounds: computeBounds({ x: 5889, y: -1, z: 8361 }, { x: 5933, y: 19, z: 8405 }),
            pStart: { x: 5911.5, y: 1, z: 8395.5 },
            pFacing: { x: 5911.5, y: 2, z: 8383.5 },
            bStart: { x: 5911.5, y: 1, z: 8371.5 },
            isFinished: false
        });
        this.minorDuelZones.push({
            bounds: computeBounds({ x: 5800, y: -1, z: 8361 }, { x: 5844, y: 19, z: 8405 }),
            pStart: { x: 5822.5, y: 1, z: 8395.5 },
            pFacing: { x: 5822.5, y: 2, z: 8383.5 },
            bStart: { x: 5822.5, y: 1, z: 8371.5 },
            isFinished: false
        });
        this.minorDuelZones.push({
            bounds: computeBounds({ x: 5711, y: -1, z: 8361 }, { x: 5755, y: 19, z: 8405 }),
            pStart: { x: 5733.5, y: 1, z: 8395.5 },
            pFacing: { x: 5733.5, y: 2, z: 8383.5 },
            bStart: { x: 5733.5, y: 1, z: 8371.5 },
            isFinished: false
        });
        this.minorDuelZones.push({
            bounds: computeBounds({ x: 5622, y: -1, z: 8361 }, { x: 5666, y: 19, z: 8405 }),
            pStart: { x: 5644.5, y: 1, z: 8395.5 },
            pFacing: { x: 5644.5, y: 2, z: 8383.5 },
            bStart: { x: 5644.5, y: 1, z: 8371.5 },
            isFinished: false
        });
        // ehhh 
        this.majorDuelZones.push({
            bounds: computeBounds({ x: 6466, y: -1, z: 7438 }, { x: 6516, y: 19, z: 7488 }),
            pStart: { x: 6490.5, y: 1, z: 7474.5 },
            pFacing: { x: 6490.5, y: 2, z: 7462.5 },
            bStart: { x: 6490.5, y: 1, z: 7450.5 },
            isFinished: false
        });
        this.majorDuelZones.push({
            bounds: computeBounds({ x: 6072, y: -1, z: 7438 }, { x: 6122, y: 19, z: 7488 }),
            pStart: { x: 6096.5, y: 1, z: 7474.5 },
            pFacing: { x: 6096.5, y: 2, z: 7462.5 },
            bStart: { x: 6096.5, y: 1, z: 7450.5 },
            isFinished: false
        });
        this.majorDuelZones.push({
            bounds: computeBounds({ x: 5678, y: -1, z: 7438 }, { x: 5728, y: 19, z: 7488 }),
            pStart: { x: 5702.5, y: 1, z: 7474.5 },
            pFacing: { x: 5702.5, y: 2, z: 7462.5 },
            bStart: { x: 5702.5, y: 1, z: 7450.5 },
            isFinished: false
        });
        this.majorDuelZones.push({
            bounds: computeBounds({ x: 5284, y: -1, z: 7438 }, { x: 5333, y: 19, z: 7488 }),
            pStart: { x: 5308.5, y: 1, z: 7474.5 },
            pFacing: { x: 5308.5, y: 2, z: 7462.5 },
            bStart: { x: 5308.5, y: 1, z: 7450.5 },
            isFinished: false
        });
    }
    enableDuelSettings() {
        this.dimension.runCommandAsync("clear @a spark:push 0 99");
        this.dimension.runCommandAsync("clear @a spark:pull 0 99");
        this.dimension.runCommandAsync("clear @a spark:grab 0 99");
        this.dimension.runCommandAsync("clear @a spark:insight 0 99");
        // this.dimension.runCommandAsync("event entity @a spark:force_movement_off");
        this.dimension.runCommandAsync("camera @a[r=50] clear");
        this.dimension.runCommandAsync("gamerule naturalregeneration false");
    }
    disableDuelSettings() {
        for (const player of this.dimension.getPlayers()) {
            player.setDefaultHotbarLoadout();
        }
        this.dimension.runCommandAsync("gamerule naturalregeneration true");
        this.dimension.runCommandAsync("event entity @a spark:force_movement_on");
        this.dimension.runCommandAsync("effect @a instant_health 1 10 true");
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
                if (!isPointInsideAABB(companion.location, this.droidPen.min, this.droidPen.max)) {
                    let x = randomRange(this.droidPen.min.x, this.droidPen.max.x);
                    let z = randomRange(this.droidPen.min.z, this.droidPen.max.z);
                    companion.teleport({ x: x, y: this.droidPen.center.y, z: z });
                }
            }
        }
    }
    releaseDroids() {
        for (const companion of this.dimension.getEntities({ type: "spark:astromech" })) {
            // if in level bounds
            if (isPointInsideAABB(companion.location, this.levelBounds.min, this.levelBounds.max)) {
                if (companion.hasTag("no_tp")) {
                    companion.removeTag("no_tp");
                }
                companion.triggerEvent("spark:mobile");
            }
        }
        // remove ticking area
        this.dimension.runCommandAsync("tickingarea remove scripting.astromech.pen");
    }
    // ----------------------------- //
    // ---------- culling ---------- //
    // ----------------------------- //
    // better system of doing this
    // detect if a cube and respawn point can/cant be seen
    // then do the required actions!
    _cullCubes() {
        // get all force cubes
        // if they have the culling tag, ignore
        let players = this.dimension.getPlayers();
        for (const cube of this.dimension.getEntities({ tags: ["force_cube"], excludeTags: ["culling", "grab_current"] })) {
            if (cube.typeId == "spark:power_source")
                continue;
            if (isPointInsideAABB(cube.location, this.levelBounds.min, this.levelBounds.max)) {
                // check to see if the cube is not in any players view!
                if (!this._isCubeInView(cube, players)) {
                    // get event to trigger on spawn
                    // look for size_ to get the number
                    let size = this._getSizeOfCubeFromTag(cube, "size_");
                    let event = "spark:size_" + size;
                    // cache the cube
                    let cbData = {
                        type: cube.typeId,
                        location: cube.location,
                        events: [event],
                        tags: cube.getTags()
                    };
                    // add to cache
                    this.culledCubes.push(cbData);
                    // tag this as despawning
                    cube.addTag("culling");
                    // trigger despawn
                    // we shouldn't have to execute as @s
                    cube.runCommandAsync("function spark/force/entity/box/despawn");
                    continue;
                }
                // // check if we are not in view
                // if (this._isCubeNotInView(cube, players)) {
                //     // get event to trigger on spawn
                //     // look for size_ to get the number
                //     let size = this._getSizeOfCubeFromTag(cube, "size_");
                //     let event = "spark:size_" + size;
                //     // cache the cube
                //     let cbData: CubeCullData = {
                //         type: cube.typeId,
                //         location: cube.location,
                //         events: [event],
                //         tags: cube.getTags()
                //     };
                //     // add to cache
                //     this.culledCubes.push(cbData);
                //     // tag this as despawning
                //     cube.addTag("culling");
                //     // trigger despawn
                //     // we shouldn't have to execute as @s
                //     cube.runCommandAsync("function spark/force/entity/box/despawn");
                //     continue;
                // }
            }
        }
    }
    _returnCubes() {
        let players = this.dimension.getPlayers();
        // loop over the cull cubes from the back
        for (let i = this.culledCubes.length - 1; i > -1; i--) {
            let data = this.culledCubes[i];
            // if in view, continue
            if (this._isCullDataInView(data, players)) {
                // trigger differ spawn :D
                // no block checking required, hopefully
                // no differ spawn
                let entity = this.dimension.spawnEntity(data.type, data.location);
                for (const tag of data.tags) {
                    entity.addTag(tag);
                }
                for (const event of data.events) {
                    entity.triggerEvent(event);
                }
                // function
                entity.runCommand("function spark/force/entity/box/on_ground");
                // remove, I think :D
                this.culledCubes.splice(i, 1);
            }
        }
    }
    _isCullDataInView(e, players) {
        for (const player of players) {
            if (isPointInsideAABB(player.location, this.levelBounds.min, this.levelBounds.max)) {
                let distance = Vector.distance(player.location, e.location);
                // if within a set distance, assume we are in view
                if (distance < this.cubeCullingEnforceDistance)
                    return true;
                // spawn cubes in if they are leff than 35 blocks away, and in view!
                if (distance > this.cubeCullingReturnSize)
                    continue;
                let EP = Vector.subtract(player.location, e.location).normalized();
                // things should spawn in slightly off screen.
                if (Vector.dot(EP, player.getViewDirection()) < 0.05) {
                    // we cant be seen (or are very close to)
                    return true;
                }
            }
        }
        return false;
    }
    // new method of doing things
    _isCubeInView(e, players) {
        // if the cube has the 'important' tag, return false
        if (e.hasTag("important"))
            return true;
        let inPlayerViewFrustum = false;
        for (const player of players) {
            if (isPointInsideAABB(player.location, this.levelBounds.min, this.levelBounds.max)) {
                let distance = Vector.distance(player.location, e.location);
                // if within a given distance, cube is always in view!
                if (distance < this.cubeCullingEnforceDistance + 3)
                    return true;
                // if too far, ignore as it wont be rendered.
                if (distance > 90)
                    continue;
                // calculate if in a players view
                let EP = Vector.subtract(player.location, e.location).normalized();
                let dot = Vector.dot(EP, player.getViewDirection());
                if (dot < 0.05) {
                    // set to seen
                    inPlayerViewFrustum = true;
                }
            }
        }
        return inPlayerViewFrustum;
    }
    // old!
    _isCubeNotInView(e, players) {
        // if the cube has the 'important' tag, return false
        if (e.hasTag("important"))
            return false;
        for (const player of players) {
            if (isPointInsideAABB(player.location, this.levelBounds.min, this.levelBounds.max)) {
                // if too far, ignore as it wont be rendered.
                // despawn all cube that are within 90 blocks, and not in view
                let distance = Vector.distance(player.location, e.location);
                if (distance < this.cubeCullingEnforceDistance + 3)
                    return false;
                if (distance > 90)
                    continue;
                let EP = Vector.subtract(player.location, e.location).normalized();
                let dot = Vector.dot(EP, player.getViewDirection());
                if (dot > 0.2) {
                    // we cant be seen (or are very close to)
                    return true;
                }
            }
        }
        return false;
    }
    _getSizeOfCubeFromTag(entity, matchTag) {
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
        // fixed a bug with reading tags.
        if (entity.typeId == "spark:torren_obstacle_l")
            return 5;
        return -1;
    }
    _cullDataHasTag(cd, tag) {
        for (const t of cd.tags) {
            if (t == tag) {
                return true;
            }
        }
        return false;
    }
    // ------------------------------ //
    // ---------- internal ---------- //
    // ------------------------------ //
    checkForOldEntities(uniqueValue) {
        for (const entity of this.dimension.getEntities({ excludeTypes: ["minecraft:player", "spark:astromech", "spark:yoda"] })) {
            if (!entity.isValid())
                continue;
            if (isPointInsideAABB(entity.location, this.levelBounds.min, this.levelBounds.max)) {
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
                        entity.triggerEvent("spark:despawn");
                    }
                }
            }
        }
    }
    cleanup() {
        //throw new Error("Method not implemented.");
        this.resetBoard(`lv_${this.levelName}`);
        let yoda = this.dimension.getEntities({ type: "spark:yoda", location: this.hubYodaLocation, maxDistance: 2 });
        if (yoda.length > 0) {
            yoda[0].triggerEvent("spark:despawn");
        }
        this.dimension.runCommandAsync("tickingarea remove scripting.yoda.hub");
        // reset values
        const hubBounds = computeBounds({ x: 6223, y: 28, z: 9337 }, { x: 6070, y: 109, z: 9475 });
        this.hubX = hubBounds.min;
        this.hubY = hubBounds.max;
        this.state = 0;
        this.subStep = 0;
        this.hubState = 0;
        this.firstEnter = false;
        this.dimension = world.getDimension("overworld");
        this.leftDoorActive = 0;
        this.centerDoorActive = 0;
        this.rightDoorActive = 0;
        this.hubReturnLocation = { x: 6147.5, y: 61, z: 9385.5 };
        this.huhReturnFacingLocation = { x: 6147.5, y: 61, z: 9388.5 };
        this.triggers = [];
        this.playersOnGround = new Map();
        this.killZones = [];
        this.playerDeathTimer = new Map();
        this.puzzleCounter = 0;
        this.playerDeathPoints = new Map();
        this.t3KillZonesTagMappings = new Map();
        this.bossRoomDeaths = 0;
        this.yodaTickingArea = 0;
        this.t3LeftFinished = 0;
        this.t3TopFinished = 0;
        this.t3RightFinished = 0;
        this.isFirstPlaythrough = 0;
        this.minorDuelZones = [];
        this.majorDuelZones = [];
        this.setupDuelZones();
        this.releaseDroids();
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
            if (command[0] == "drip") {
                this.dimension.runCommandAsync("summon spark:planet_2_dripleaf 6315 65 9226.0 180 0");
                // let ent = this.dimension.spawnEntity("spark:planet_2_dripleaf", {x:6315,y:65,z:9226});
                // ent.teleport(ent.location, {rotation:{x:180,y:0}});
            }
            if (command[0] == "test") {
                let powerCube = { x: 5744.5, y: -4, z: 8840.5 };
                summonPowerSource(powerCube, ["cb", "pw_c"]);
                // let ent = this.dimension.spawnEntity("spark:planet_2_dripleaf", {x:6315,y:65,z:9226});
                // ent.teleport(ent.location, {rotation:{x:180,y:0}});
            }
            if (command[0] == "1x1") {
                summonPowerSource({ x: 5744.5, y: -4, z: 8829.5 }, ["cb", "power_cube"]);
            }
            if (command[0] == "goto") {
                if (command[1] == "t1") {
                    this.running = true;
                    this.hubState = -1;
                    this.queueFastTransition(this.leftDoorTriggerSendLocation, this.leftDoorTriggerFaceLocation);
                    this.createTempleOneTriggers();
                    this.pollKillZones();
                }
                if (command[1] == "t2") {
                    this.running = true;
                    this.hubState = -1;
                    this.queueFastTransition(this.rightDoorTriggerSendLocation, this.rightDoorTriggerFaceLocation);
                    this.createTempleTwoTriggers();
                    this.pollKillZones();
                }
                if (command[1] == "t3") {
                    this.running = true;
                    this.hubState = -1;
                    this.queueFastTransition(this.centerDoorTriggerSendLocation, this.centerDoorTriggerFaceLocation, "sound.spark.enter_sith_temple_major");
                    this.createTempleThreeTriggers();
                    this.pollKillZones();
                }
                for (const p of world.getPlayers()) {
                    p.setDefaultHotbarLoadout();
                }
            }
            if (command[0] == "reset") {
                if (command[1] == "p1") {
                    try {
                        this.resetT1Room1();
                    }
                    catch {
                    }
                }
                if (command[1] == "p2") {
                    try {
                        this.resetT1Room2();
                    }
                    catch {
                    }
                }
                if (command[1] == "p3") {
                    try {
                        this.resetT2Room1();
                    }
                    catch {
                    }
                }
                if (command[1] == "p4") {
                    try {
                        this.resetT2Room2();
                    }
                    catch {
                    }
                }
            }
        }
    }
    isActive() {
        return this.running;
    }
    load() {
        let boardName = `lv_${this.levelName}`;
        if (world.scoreboard.getObjective(boardName) == undefined) {
            // we are going to create the board, and we do not need to load anything!
            let board = world.scoreboard.addObjective(boardName, "");
            board.setScore("state", this.state);
            board.setScore("subState", this.subStep);
            board.setScore("hubState", this.hubState);
            board.setScore("lda", this.leftDoorActive);
            board.setScore("cda", this.centerDoorActive);
            board.setScore("rda", this.rightDoorActive);
            board.setScore("eat", this.enteredAnyTemple);
            board.setScore("brd", this.bossRoomDeaths);
            board.setScore("yta", this.yodaTickingArea);
            board.setScore("3lf", this.t3LeftFinished);
            board.setScore("3tf", this.t3TopFinished);
            board.setScore("3rf", this.t3RightFinished);
            board.setScore("first_playthrough", this.isFirstPlaythrough);
            return;
        }
        // boards exists, load the values from here!
        let board = world.scoreboard.getObjective(boardName);
        // so this line it funny to me... we just checked for this on line 26, but in strict mode we have to again...
        if (board != undefined) {
            if (!board.hasParticipant("state"))
                board.setScore("state", this.state);
            this.state = board.getScore("state");
            if (!board.hasParticipant("subState"))
                board.setScore("subState", this.subStep);
            this.subStep = board.getScore("subState");
            if (!board.hasParticipant("hubState"))
                board.setScore("hubState", this.hubState);
            this.hubState = board.getScore("hubState");
            if (!board.hasParticipant("lda"))
                board.setScore("lda", this.leftDoorActive);
            this.leftDoorActive = board.getScore("lda");
            if (!board.hasParticipant("cda"))
                board.setScore("cda", this.centerDoorActive);
            this.centerDoorActive = board.getScore("cda");
            if (!board.hasParticipant("rda"))
                board.setScore("rda", this.rightDoorActive);
            this.rightDoorActive = board.getScore("rda");
            if (!board.hasParticipant("eat"))
                board.setScore("eat", this.enteredAnyTemple);
            this.enteredAnyTemple = board.getScore("eat");
            if (!board.hasParticipant("brd"))
                board.setScore("brd", this.bossRoomDeaths);
            this.bossRoomDeaths = board.getScore("brd");
            if (!board.hasParticipant("yta"))
                board.setScore("yta", this.yodaTickingArea);
            this.yodaTickingArea = board.getScore("yta");
            if (!board.hasParticipant("3lf"))
                board.setScore("3lf", this.t3LeftFinished);
            this.t3LeftFinished = board.getScore("3lf");
            if (!board.hasParticipant("3tf"))
                board.setScore("3tf", this.t3TopFinished);
            this.t3TopFinished = board.getScore("3tf");
            if (!board.hasParticipant("3rf"))
                board.setScore("3rf", this.t3RightFinished);
            this.t3RightFinished = board.getScore("3rf");
            if (!board.hasParticipant("first_playthrough"))
                board.setScore("first_playthrough", this.isFirstPlaythrough);
            this.isFirstPlaythrough = board.getScore("first_playthrough");
        }
        // respond to loading
        // hub handles itself
        switch (this.state) {
            case 0:
                this.loadStartSequence();
                break;
            case 1:
                this.createFreeRoamTriggers();
                this.pollKillZones();
                break;
            case 2:
                this.createTempleOneTriggers();
                this.pollKillZones();
                break;
            case 3:
                this.createTempleTwoTriggers();
                this.pollKillZones();
                break;
            case 4:
                this.createTempleThreeTriggers();
                break;
        }
    }
    update(tick) {
        this._cullCubes();
        this._returnCubes();
        if (this.sequence.isActive()) {
            this.subStep = this.sequence.activeState;
        }
        // detect when any player is in the hub, we will then update based off of that
        this.updateHub();
        this.holdDroids();
        this.processDeaths();
        this.updateTriggers();
        if (this.state == 0) {
            if (this.hubState <= 0) {
                this.sequence.update();
            }
        }
    }
    save() {
        let boardName = `lv_${this.levelName}`;
        if (world.scoreboard.getObjective(boardName) == undefined) {
            // we are going to create the board, and we do not need to load anything!
            let board = world.scoreboard.addObjective(boardName, "");
            board.setScore("state", this.state);
            board.setScore("subState", this.subStep);
            board.setScore("hubState", this.hubState);
            board.setScore("lda", this.leftDoorActive);
            board.setScore("cda", this.centerDoorActive);
            board.setScore("rda", this.rightDoorActive);
            board.setScore("eat", this.enteredAnyTemple);
            board.setScore("brd", this.bossRoomDeaths);
            board.setScore("yta", this.yodaTickingArea);
            board.setScore("3lf", this.t3LeftFinished);
            board.setScore("3tf", this.t3TopFinished);
            board.setScore("3rf", this.t3RightFinished);
            board.setScore("first_playthrough", this.isFirstPlaythrough);
            return;
        }
        let board = world.scoreboard.getObjective(boardName);
        if (board != undefined) {
            // set state
            board.setScore("state", this.state);
            board.setScore("subState", this.subStep);
            board.setScore("hubState", this.hubState);
            board.setScore("lda", this.leftDoorActive);
            board.setScore("cda", this.centerDoorActive);
            board.setScore("rda", this.rightDoorActive);
            board.setScore("eat", this.enteredAnyTemple);
            board.setScore("brd", this.bossRoomDeaths);
            board.setScore("yta", this.yodaTickingArea);
            board.setScore("3lf", this.t3LeftFinished);
            board.setScore("3tf", this.t3TopFinished);
            board.setScore("3rf", this.t3RightFinished);
            board.setScore("first_playthrough", this.isFirstPlaythrough);
        }
    }
}
function summonPressurePlate(loc, tags = []) {
    tags.push("pz_static");
    // differ
    LEVEL_MANAGER.differSpawn("spark:torren_pressure_plate", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let z = -1; z < 2; z++) {
                let b = dim.getBlock({ x: loc.x - x, y: loc.y, z: loc.z - z });
                if (b != undefined) {
                    b.setPermutation(perm);
                }
            }
        }
    }, undefined, tags);
    // if (entityExistsAtPoint("spark:torren_pressure_plate", loc)) return;
    // let dim = world.getDimension("overworld");
    // let perm = BlockPermutation.resolve("minecraft:air");
    // // remove any blocks on plate
    // for (let x = -1; x < 2; x++) {
    //     for (let z = -1; z < 2; z++) {
    //         let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y, z: loc.z - z });
    //         if (b != undefined) {
    //             b.setPermutation(perm);
    //         }
    //     }
    // }
    // let plate: Entity = dim.spawnEntity("spark:torren_pressure_plate", loc);
    // if (tags.length > 0) {
    //     for (let i = 0; i < tags.length; i++) {
    //         plate.addTag(tags[i]);
    //     }
    // }
    // plate.addTag("pz_static");
}
function summonAurebeshObstacle(loc, event, tag = []) {
    tag.push("size_3", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:aurebesh_obstacle_m", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let y = -1; y < 2; y++) {
                for (let z = -1; z < 2; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_3", event]);
    // if (entityExistsAtPoint("spark:aurebesh_obstacle_m", loc)) return;
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     // remove any blocks on plate
    //     for (let x = -1; x < 2; x++) {
    //         for (let y = -1; y < 2; y++) {
    //             for (let z = -1; z < 2; z++) {
    //                 let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //                 if (b != undefined) {
    //                     b.setPermutation(perm);
    //                 }
    //             }
    //         }
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:aurebesh_obstacle_m", loc);
    //     ent.addTag("size_3");
    //     ent.addTag("force_cube");
    //     ent.triggerEvent("spark:size_3");
    //     ent.triggerEvent(event);
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function summonAurebeshObstacleFake(loc, event, tags) {
    // differ
    LEVEL_MANAGER.differSpawn("spark:aurebesh_obstacle_m", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let y = -1; y < 2; y++) {
                for (let z = -1; z < 2; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tags, ["spark:float", event]);
    // if (entityExistsAtPoint("spark:aurebesh_obstacle_m", loc)) return;
    // let dim = world.getDimension("overworld");
    // let perm = BlockPermutation.resolve("minecraft:air");
    // // remove any blocks on plate
    // for (let x = -1; x < 2; x++) {
    //     for (let y = -1; y < 2; y++) {
    //         for (let z = -1; z < 2; z++) {
    //             let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //             if (b != undefined) {
    //                 b.setPermutation(perm);
    //             }
    //         }
    //     }
    // }
    // let ent:Entity = dim.spawnEntity("spark:aurebesh_obstacle_m", loc);
    // ent.triggerEvent(event);
    // ent.triggerEvent("spark:float");
    // if (tags.length > 0) {
    //     for (let i = 0; i < tags.length; i++) {
    //         ent.addTag(tags[i]);
    //     }
    // }
}
function summonConductorMedium(loc, tag = []) {
    tag.push("size_3", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:conductor_obstacle_m", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let y = -1; y < 2; y++) {
                for (let z = -1; z < 2; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_3"]);
    // if (entityExistsAtPoint("spark:conductor_obstacle_m", loc)) return;
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     // remove any blocks on plate
    //     for (let x = -1; x < 2; x++) {
    //         for (let y = -1; y < 2; y++) {
    //             for (let z = -1; z < 2; z++) {
    //                 let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //                 if (b != undefined) {
    //                     b.setPermutation(perm);
    //                 }
    //             }
    //         }
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:conductor_obstacle_m", loc);
    //     ent.addTag("size_3");
    //     ent.addTag("force_cube");
    //     ent.triggerEvent("spark:size_3");
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function summonConductorSmall(loc, tag = []) {
    tag.push("size_2", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:conductor_obstacle_s", loc, world.getDimension("overworld"), () => {
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
    // if (entityExistsAtPoint("spark:conductor_obstacle_s", loc)) return;
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     // remove any blocks on plate
    //     for (let x = -1; x < 2; x++) {
    //         for (let y = -1; y < 2; y++) {
    //             for (let z = -1; z < 2; z++) {
    //                 let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //                 if (b != undefined) {
    //                     b.setPermutation(perm);
    //                 }
    //             }
    //         }
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:conductor_obstacle_s", loc);
    //     ent.addTag("size_2");
    //     ent.triggerEvent("spark:size_2");
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function summonObstacleLarge(loc, tag = []) {
    tag.push("size_5", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:torren_obstacle_l", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -2; x < 3; x++) {
            for (let y = -2; y < 3; y++) {
                for (let z = -2; z < 3; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_5"]);
    // if (entityExistsAtPoint("spark:torren_obstacle_l", loc)) return;
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     // remove any blocks on plate
    //     for (let x = -2; x < 3; x++) {
    //         for (let y = -2; y < 3; y++) {
    //             for (let z = -2; z < 3; z++) {
    //                 let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //                 if (b != undefined) {
    //                     b.setPermutation(perm);
    //                 }
    //             }
    //         }
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:torren_obstacle_l", loc);
    //     ent.addTag("size_5");
    //     ent.addTag("force_cube");
    //     ent.triggerEvent("spark:size_5");
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function summonObstacleMedium(loc, tag = []) {
    tag.push("size_3", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:torren_obstacle_m", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let y = -1; y < 2; y++) {
                for (let z = -1; z < 2; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_3"]);
}
function summonObstacleSmall(loc, tag = []) {
    tag.push("size_2", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:torren_obstacle_s", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        // remove any blocks on plate
        for (let x = -1; x < 2; x++) {
            for (let y = -1; y < 2; y++) {
                for (let z = -1; z < 2; z++) {
                    let b = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
                    if (b != undefined) {
                        b.setPermutation(perm);
                    }
                }
            }
        }
    }, undefined, tag, ["spark:size_2"]);
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     // remove any blocks on plate
    //     for (let x = -1; x < 2; x++) {
    //         for (let y = -1; y < 2; y++) {
    //             for (let z = -1; z < 2; z++) {
    //                 let b: Block | undefined = dim.getBlock({ x: loc.x - x, y: loc.y - y, z: loc.z - z });
    //                 if (b != undefined) {
    //                     b.setPermutation(perm);
    //                 }
    //             }
    //         }
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:torren_obstacle_s", loc);
    //     ent.addTag("size_2");
    //     ent.addTag("force_cube");
    //     ent.triggerEvent("spark:size_2");
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function summonPowerSource(loc, tag = []) {
    tag.push("size_1", "force_cube");
    // differ
    LEVEL_MANAGER.differSpawn("spark:power_source", loc, world.getDimension("overworld"), () => {
        let dim = world.getDimension("overworld");
        let perm = BlockPermutation.resolve("minecraft:air");
        let b = dim.getBlock(loc);
        if (b != undefined) {
            b.setPermutation(perm);
        }
    }, undefined, tag, ["spark:size_1"]);
    // spark:power_source
    // if (entityExistsAtPoint("spark:power_source", loc)) return;
    // try {
    //     let dim = world.getDimension("overworld");
    //     let perm = BlockPermutation.resolve("minecraft:air");
    //     let b: Block | undefined = dim.getBlock(loc);
    //     if (b != undefined) {
    //         b.setPermutation(perm);
    //     }
    //     let ent = world.getDimension("overworld").spawnEntity("spark:power_source", loc);
    //     ent.addTag("size_1");
    //     ent.addTag("force_cube");
    //     ent.triggerEvent("spark:size_1");
    //     if (tag.length > 0) {
    //         for (let i = 0; i < tag.length; i++) {
    //             ent.addTag(tag[i]);
    //         }
    //     }
    // }
    // catch
    // {
    // }
}
function entityExistsAtPoint(id, loc) {
    let ent = world.getDimension("overworld").getEntities({ type: id, location: loc, maxDistance: 1 });
    if (ent.length > 0)
        return true;
    return false;
}
function isBlockOfType(dim, loc, type) {
    try {
        let block = dim.getBlock(loc);
        if (block != undefined) {
            if (block.permutation.matches(type)) {
                return true;
            }
        }
    }
    catch (e) {
    }
    return false;
}
function isEntityAtExactPosition(dim, loc, type) {
    try {
        let ent = dim.getEntities({ type: type, location: loc });
        if (ent.length > 0) {
            return true;
        }
    }
    catch (e) {
    }
    return false;
}
const powerLineMapping = new Map([
    ["spark:torren_cable_horizontal_unlit", "spark:torren_cable_horizontal_lit"],
    ["spark:power_detector_off", "spark:power_detector_on"],
    ["spark:torren_cable_unlit_1", "spark:torren_cable_lit_1"],
    ["spark:torren_cable_unlit_2", "spark:torren_cable_lit_2"],
    ["spark:torren_cable_unlit_3", "spark:torren_cable_lit_3"],
    ["spark:torren_cable_unlit_4", "spark:torren_cable_lit_4"],
    ["spark:torren_cable_t_unlit_1", "spark:torren_cable_t_lit_1"],
    ["spark:torren_cable_t_unlit_2", "spark:torren_cable_t_lit_2"],
    ["spark:torren_cable_t_unlit_3", "spark:torren_cable_t_lit_3"],
    ["spark:torren_cable_t_unlit_4", "spark:torren_cable_t_lit_4"],
    ["spark:torren_cable_unlit", "spark:torren_cable_lit"],
]);
class PlateSoundEmitter {
    constructor(pos, dim) {
        this.normalPlacementSound = "sound.spark.m_puzzle.placement_regular";
        this.correctPlacementSound = "sound.spark.m_puzzle.placement_correct";
        this.pos = pos;
        this.dim = dim;
    }
    update(wasPlaced, isCorrect) {
        if (this.lastState != undefined) {
            if (this.lastState == wasPlaced) {
                return;
            }
        }
        this.lastState = wasPlaced;
        if (wasPlaced == true) {
            if (isCorrect == true) {
                world.playSound(this.correctPlacementSound, this.pos);
            }
            world.playSound(this.normalPlacementSound, this.pos);
            return;
        }
    }
}
class LinearWirePath {
    constructor(dim) {
        this.spline = [];
        this.dim = dim;
        this.lastState = undefined;
    }
    update(light) {
        if (this.lastState != undefined) {
            if (this.lastState == light) {
                return;
            }
        }
        this.lastState = light;
        // for each point in the spline
        for (let i = 0; i < this.spline.length; i++) {
            if (i == this.spline.length - 1)
                return;
            let start = this.spline[i];
            let end = this.spline[i + 1];
            // get the mask for this...
            let length = Vector.distance(end, start);
            let mask = Vector.subtract(end, start);
            let step = Vector.divideScalar(mask, length);
            let playConnected = false;
            for (let j = 0; j < length + 1; j++) {
                // ehh?
                let current = Vector.add(start, Vector.multiplyScalar(step, j));
                // using this point, check each block for its permutation
                // then if it matches, set!
                if (!isPositionLoaded(this.dim, current))
                    return;
                let block = this.dim.getBlock(current);
                if (block != undefined) {
                    let perm = block.permutation;
                    if (light == true) {
                        for (const key of powerLineMapping.keys()) {
                            if (perm.matches(key)) {
                                // if we match, set it to the other perm and break from the foreach
                                block.setPermutation(BlockPermutation.resolve(powerLineMapping.get(key)));
                                break;
                            }
                        }
                        playConnected = true;
                        continue;
                    }
                    // id not light
                    for (const key of powerLineMapping.keys()) {
                        let val = powerLineMapping.get(key);
                        if (perm.matches(val)) {
                            block.setPermutation(BlockPermutation.resolve(key));
                            break;
                        }
                    }
                }
            }
            if (playConnected) {
                // play sound
                world.playSound("sound.spark.m_puzzle.cable_connected", start);
                continue;
            }
            // we goto next anyway!
            world.playSound("sound.spark.m_puzzle.cable_disconnected", start);
        }
    }
}
