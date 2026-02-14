import { world, } from "@minecraft/server";
import { computeBounds, isPointInsideAABB } from "./AABB";
// the bounds of the robe area in the archive
// only players inside this area will be able affected by the
const archiveBoundsMin = {
    x: 8954,
    y: 26,
    z: 9141,
};
const archiveBoundsMax = {
    x: 8994,
    y: 36,
    z: 9177,
};
const displayBounds = computeBounds({
    x: 8915,
    y: 38,
    z: 9146
}, {
    x: 8888,
    y: 18,
    z: 9171
});
const displayStandMappings = new Map([
    ["Lightsaber_Duelling", 1],
    ["Escape_the_Battleship", 2],
    ["Monster_Battle_Arena", 3],
    ["Droid_Survival", 4],
    ["Ancient_Puzzle", 5]
]);
// always try and add it, if it alrady exists we can igrnore the error, from what I can tell there is no error free way
// of checking to see if an objective exists syncronously
try {
    world.scoreboard.addObjective("SS_ui_robe_hover", "SS_ui_robe_hover");
    world.scoreboard.addObjective("SS_ui_display_hover", "SS_ui_display_hover");
}
catch (e) { }
// there is no point redefining this reference so we keep it in the module scope.
const SS_ui_robe_hover = world.scoreboard.getObjective("SS_ui_robe_hover");
const SS_ui_display_hover = world.scoreboard.getObjective("SS_ui_display_hover");
export function getOrCreateObjective(name) {
    return (world.scoreboard.getObjective(name) ||
        world.scoreboard.addObjective(name, ""));
}
export function getScoreSafe(objective, name, defaultValue) {
    if (objective.hasParticipant(name))
        return objective.getScore(name) || defaultValue;
    return defaultValue;
}
function updateDisplayScores() {
    const AchievementDisplay = getOrCreateObjective("achievement_display");
    const monsterBattle = getOrCreateObjective(".monster_battle");
    const escape = getOrCreateObjective("lv_escape_level_achievements");
    const droidSurvival = getOrCreateObjective("droid_survival");
    const dueling = getOrCreateObjective("dueling_rank");
    AchievementDisplay.setScore("dueling", 10 - getScoreSafe(dueling, ".global", 0));
    AchievementDisplay.setScore("monster", getScoreSafe(monsterBattle, ".monster_1_complete", 0) +
        getScoreSafe(monsterBattle, ".monster_2_complete", 0));
    const time = getScoreSafe(escape, "fastest_time", -1);
    if (time > -1) {
        const escapeTime = Math.ceil(time / 20);
        const m = Math.floor(escapeTime / 60);
        const s = escapeTime % 60;
        AchievementDisplay.setScore("escape_m", m);
        AchievementDisplay.setScore("escape_s0", Math.floor(s / 10));
        AchievementDisplay.setScore("escape_s1", s % 10);
    }
    const highestKills = getScoreSafe(droidSurvival, ".highest_kills", 0); //droidSurvival.getScore(".highest_kills") || 0;
    AchievementDisplay.setScore("droid", highestKills);
}
export const archiveTick = (world) => {
    for (const player of world.getAllPlayers()) {
        let wasScoreZero = true;
        if (SS_ui_robe_hover.getScore(player) !== 0) {
            // reset the score if the player is not in the archive and not looking at a pedastal
            wasScoreZero = false;
            SS_ui_robe_hover.setScore(player, 0);
        }
        if (SS_ui_display_hover.getScore(player) !== 0) {
            SS_ui_display_hover.setScore(player, 0);
        }
        if (isPointInsideAABB(player.location, archiveBoundsMin, archiveBoundsMax)) {
            // don't crash the tick function if we are unable to use the onScreenDisplay
            if (player.onScreenDisplay.isValid()) {
                let entities = player.getEntitiesFromViewDirection({
                    maxDistance: 5
                });
                for (const { entity } of entities) {
                    if (entity.typeId === "spark:reward_cloak_pedestal") {
                        const id = entity.getComponent("minecraft:variant");
                        updateDisplayScores();
                        SS_ui_robe_hover.setScore(player, id.value + 1);
                        break;
                    }
                }
            }
        }
        // displayBounds
        if (isPointInsideAABB(player.location, displayBounds.min, displayBounds.max)) {
            if (player.onScreenDisplay.isValid()) {
                let entities = player.dimension.getEntities({ location: player.location, maxDistance: 5 });
                for (const entity of entities) {
                    // archive display_small
                    if (entity.typeId == "spark:display_small") {
                        // if not active, skip
                        if (!entity.hasTag("is_achieved")) {
                            continue;
                        }
                        for (const tag of entity.getTags()) {
                            if (displayStandMappings.has(tag)) {
                                SS_ui_display_hover.setScore(player, displayStandMappings.get(tag));
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
};
