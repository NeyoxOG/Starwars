import { world } from "@minecraft/server";
/**
 * Lerps between two numbers using an alpha value between 0 and 1, or beyond
 */
const lerp = function (start, end, lerp) {
    return start + (end - start) * lerp;
};
/**
 * Clamps the input value to between the two numbers
 */
const clamp = function (value, min, max) {
    return Math.max(Math.min(value, max), min);
};
/**
 * Returns the length of a vector
 */
const getLength = function (vector) {
    return Math.sqrt(Math.pow(vector.x, 2) +
        Math.pow(vector.y, 2) +
        Math.pow(vector.z, 2));
};
const setDialogue = function (e, sceneTag, addQuestTag = true, entityTag = "") {
    e.runCommandAsync(`dialogue change @s ${sceneTag} @a`);
    if (addQuestTag) {
        if (!e.hasTag("has_quest"))
            e.addTag("has_quest");
    }
    if (entityTag != "") {
        if (!e.hasTag(entityTag)) {
            e.addTag(entityTag);
        }
    }
};
const resetBoard = function (board) {
    let levelBoard = world.scoreboard.getObjective(board);
    if (levelBoard != undefined) {
        let parts = levelBoard.getParticipants();
        for (let i = parts.length - 1; i > -1; i--) {
            levelBoard.removeParticipant(parts[i]);
        }
    }
};
const tagContains = function (entity, match) {
    for (const tag of entity.getTags()) {
        if (tag.includes(match))
            return true;
    }
    return false;
};
const getTagThatContains = function (entity, match) {
    for (const tag of entity.getTags()) {
        if (tag.includes(match))
            return tag;
    }
    return undefined;
};
/**
 * Adds two vectors together
 */
const add = function (a, b) {
    // each value in b - each value in a
    return { x: b.x + a.x, y: b.y + a.y, z: b.z + a.z };
};
/**
 * multiplies two vectors together
 */
const multiply = function (a, b) {
    return { x: a.x * b.x, y: a.y * b.y, z: a.z * b.z };
};
/**
 * subtracts two vectors together
 */
const subtract = function (a, b) {
    // each value in b - each value in a
    return { x: b.x - a.x, y: b.y - a.y, z: b.z - a.z };
};
const dot = function (a, b) {
    return a.x * b.x + a.y * b.y + a.z * b.z;
};
const randomRange = function (min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
};
const trimDegree = function (input) {
    return (input + 180 * 15) % 360 - 180;
};
export { lerp, clamp, getLength, add, multiply, subtract, dot, randomRange, trimDegree, setDialogue, resetBoard, tagContains, getTagThatContains };
