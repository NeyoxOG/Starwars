import { system, world } from "@minecraft/server";
import * as engine from "./engine";
import { SequenceManger } from "./sequence";
import { isPointInsideAABB } from "./AABB";
export class LevelManager {
    constructor() {
        this.saveFrequency = 40;
        this.uniqueLevelTag = 1;
        this.levels = new Map();
        this.queuedActions = [];
        this.differedSpawns = [];
        this.differedCommands = [];
        this.parallelActions = [];
        this.uniqueLevelString = "";
        this.updateUniqueTag();
        // special board for level tag stuff
        if (world.scoreboard.getObjective("unique_level_tag") == undefined) {
            world.scoreboard.addObjective("unique_level_tag", "");
        }
        let board = world.scoreboard.getObjective("unique_level_tag");
        if (board != undefined) {
            if (!board.hasParticipant(".value")) {
                board.setScore(".value", this.uniqueLevelTag);
            }
            this.uniqueLevelTag = board.getScore(".value");
        }
    }
    /**
     *
     * @param length
     * @param action
     */
    addParallelAction(length, action) {
        this.parallelActions.push(new QueuedAction(length, action));
    }
    /**
     * Sends a command string to a level
     * @param levelName
     * The name of the level
     * @param command
     * The split sub commands of the main command string
     * @throws
     * This function throws errors
     */
    dispatchScriptMessage(levelName, command) {
        if (this.levels.has(levelName)) {
            this.levels.get(levelName)?.handleScriptEvent(command);
            return;
        }
        // if failed, throw
        throw new Error("name not found in levels, aborting!");
    }
    /**
     * Waits to execute a command when a location is loaded
     * @param cmd
     * The command to execute
     * @param dim
     * The dimensions to check for a loaded position
     * @param pos
     * The position to ensure is loaded
     */
    differCommand(cmd, pos, dim) {
        this.differedCommands.push({
            cmd: cmd,
            dim: dim,
            loc: pos
        });
    }
    /**
     * Waits to change an entities dialogue at a givne location
     * @param entity
     * The entity to run the command on
     * @param dialogue
     * The dialogue id to use
     * @param pos
     * The position to check to ensure the entity is valid.
     */
    differDialogueChange(entity, dialogue, pos, dim) {
        let command = `dialogue change @e[type=${entity},r=5,x=${pos.x},y=${pos.y},z=${pos.z}] ${dialogue} @a`;
        this.differCommand(command, pos, dim);
    }
    /**
     * Waits to spawn an entity when the spawn location is loaded
     */
    differSpawn(type, pos, dim, preSpawn, onSpawn, tags = [], events = []) {
        this.differedSpawns.push({
            type: type,
            pos: pos,
            dimension: dim,
            tags: tags,
            events: events,
            afterSpawn: onSpawn,
            preSpawn: preSpawn
        });
    }
    /**
     * If the LevelManager has a registered level
     * @param name
     * The name of the level
     */
    hasLevel(name) {
        if (this.levels.has(name))
            return true;
        return false;
    }
    /**
     * Creates an action that will run along side current levels
     * @param length
     * The time, in ticks, the action will last
     * @param action
     * The function to be triggered every tick, until end of action
     */
    queueAction(length, action) {
        this.queuedActions.push(new QueuedAction(length, action));
    }
    /**
     * Registers the level
     * @param l
     * The level object
     * @throws
     * This will throw an error if two levels with the same name exist!
     */
    registerLevel(l) {
        if (this.levels.has(l.levelName)) {
            throw new Error(`LEVEL_MANAGER.levels cannot have a duplicate key: ${l.levelName}`);
        }
        this.levels.set(l.levelName, l);
    }
    update() {
        let tick = system.currentTick;
        // process parallel actions
        if (this.parallelActions.length > 0) {
            for (const par of this.parallelActions) {
                par.update();
            }
            // check all for 
            for (let i = this.parallelActions.length - 1; i >= 0; i--) {
                if (this.parallelActions[i].canDistroy()) {
                    this.parallelActions.splice(i, 1);
                }
            }
        }
        // process actions
        if (this.queuedActions.length > 0) {
            let act = this.queuedActions[0];
            act.update();
            // check all for 
            for (let i = this.queuedActions.length - 1; i >= 0; i--) {
                if (this.queuedActions[i].canDistroy()) {
                    this.queuedActions.splice(i, 1);
                }
            }
        }
        // differed actions
        if (this.differedSpawns.length > 0) {
            for (let i = this.differedSpawns.length - 1; i > -1; i--) {
                let spawn = this.differedSpawns[i];
                if (isPositionLoaded(spawn.dimension, spawn.pos)) {
                    if (spawn.preSpawn != undefined) {
                        spawn.preSpawn();
                    }
                    let entity = spawn.dimension.spawnEntity(spawn.type, spawn.pos);
                    if (spawn.tags.length > 0) {
                        for (let t = 0; t < spawn.tags.length; t++) {
                            entity.addTag(spawn.tags[t]);
                        }
                    }
                    entity.addTag(this.uniqueLevelString);
                    if (spawn.events.length > 0) {
                        for (let t = 0; t < spawn.events.length; t++) {
                            entity.triggerEvent(spawn.events[t]);
                        }
                    }
                    if (spawn.afterSpawn != undefined) {
                        spawn.afterSpawn(entity);
                    }
                    this.differedSpawns.splice(i, 1);
                }
            }
        }
        if (this.differedCommands.length > 0) {
            // 20 per tick at this point
            let limit = this.differedCommands.length - 21;
            if (limit < -1)
                limit = -1;
            for (let i = this.differedCommands.length - 1; i > limit; i--) {
                let spawn = this.differedCommands[i];
                if (isPositionLoaded(spawn.dim, spawn.loc)) {
                    spawn.dim.runCommandAsync(spawn.cmd);
                    this.differedCommands.splice(i, 1);
                }
            }
        }
        for (let value of this.levels.values()) {
            if (value.isActive()) {
                value.checkForOldEntities(this.uniqueLevelString);
                value.update(tick);
                if (tick % this.saveFrequency == 0) {
                    value.save();
                }
            }
        }
    }
    updateUniqueTag() {
        // update value
        // increment the unique score thing
        let board = world.scoreboard.getObjective("unique_level_tag");
        if (board != undefined) {
            let score = board.getScore(".value");
            this.uniqueLevelTag = score;
            this.uniqueLevelString = `unique_pf_${this.uniqueLevelTag}`;
        }
    }
}
export class Level {
    /**
     * @remarks
     * Create a new level with a given name, will register to {@link engine.LEVEL_MANAGER}
     * @param levelName
     * The name of the level, must be unique
     * @throws
     * This will throw an error if two levels with the same name exist!
     */
    constructor(levelName) {
        this.levelBoundsX = undefined;
        this.levelBoundsY = undefined;
        this.levelManager = engine.LEVEL_MANAGER;
        this.levelName = levelName;
        this.running = false;
        this.triggers = [];
        let boardName = `lv_${this.levelName}`;
        if (world.scoreboard.getObjective(boardName) == undefined) {
            world.scoreboard.addObjective(boardName, "");
        }
        this.sequence = new SequenceManger(world.scoreboard.getObjective(boardName));
        // register to engine
        engine.LEVEL_MANAGER.registerLevel(this);
        // default dimension
        this.dimension = world.getDimension("overworld");
    }
    createTrigger(boundsX, boundsY, func, alwaysActive) {
        let trig = new Trigger(boundsX, boundsY, this.dimension);
        trig.triggerFunction = func;
        if (alwaysActive != undefined) {
            trig.alwaysActive = alwaysActive;
        }
        this.triggers.push(trig);
        return trig;
    }
    updateTriggers() {
        // update triggers
        for (let i = 0; i < this.triggers.length; i++) {
            this.triggers[i].update();
        }
    }
    /**
     * @remarks
     * Sets running to false, but doesnt call cleanup.
     */
    pause() {
        this.running = false;
    }
    setBounds(minX, minY, minZ, maxX, maxY, maxZ) {
        this.levelBoundsX = { x: minX, y: minY, z: minZ };
        this.levelBoundsY = { x: maxX, y: maxY, z: maxZ };
    }
    /**
     * @remarks
     * Sets the dimension this level will operate in
     *
     * @param dim
     * The Dimension object from {@link world.scoreboard}
     */
    setDimension(dim) {
        this.dimension = dim;
    }
    /**
     * @remarks
     * Sets running to true
     */
    start() {
        this.running = true;
        // set running status in engine board
        const boardName = "active_state";
        if (world.scoreboard.getObjective(boardName) != undefined) {
            world.scoreboard.getObjective(boardName).setScore(this.levelName, 1);
        }
        // increment the unique score thing
        let board = world.scoreboard.getObjective("unique_level_tag");
        if (board != undefined) {
            let score = board.getScore(".value");
            score++;
            board.setScore(".value", score);
        }
        engine.LEVEL_MANAGER.updateUniqueTag();
    }
    /**
     * @remarks
     * Sets running to false, and called cleanup
     */
    stop() {
        this.running = false;
        this.cleanup();
        // set running status in engine board
        const boardName = "active_state";
        if (world.scoreboard.getObjective(boardName) != undefined) {
            world.scoreboard.getObjective(boardName).setScore(this.levelName, 0);
        }
        // wipe triggers
        this.triggers = [];
    }
}
export class Trigger {
    constructor(boundsX, boundsY, dim) {
        this.boundsX = boundsX;
        this.boundsY = boundsY;
        this.triggerDimension = dim;
        this.alwaysActive = false;
        this.disabled = false;
        this.triggerFunction = (self) => { };
        this.internalCounter = 0;
    }
    disable() {
        this.disabled = true;
    }
    update() {
        if (this.disabled)
            return;
        if (this.alwaysActive) {
            this.triggerFunction(this);
            return;
        }
        let players = this.triggerDimension.getPlayers();
        for (let i = 0; i < players.length; i++) {
            if (isPointInsideAABB(players[i].location, this.boundsX, this.boundsY)) {
                this.triggerFunction(this);
                break;
            }
        }
    }
}
class QueuedAction {
    constructor(length, action) {
        this.length = length;
        this.action = action;
        this.currentTick = 0;
    }
    canDistroy() {
        if (this.currentTick >= this.length)
            return true;
        return false;
    }
    update() {
        this.action(this.currentTick);
        this.currentTick++;
    }
}
export function isPositionLoaded(dim, pos) {
    try {
        if (dim.getBlock(pos).isValid()) {
            return true;
        }
    }
    catch (e) {
        return false;
    }
    return false;
}
