import { system, world } from "@minecraft/server";
import { computeBounds, isPointInsideAABB } from "./AABB";
import { getOrCreateObjective, getScoreSafe } from "./archive";
import "./extensions";
const templeWarpAABB = [
    computeBounds({ x: 3243, y: 46, z: -145 }, { x: 3517, y: 20, z: 172 }),
    computeBounds({ x: 3323, y: 51, z: 11 }, { x: 3370, y: 75, z: -18 }),
    computeBounds({ x: 3262, y: 47, z: 20 }, { x: 3228, y: 67, z: -31 })
];
const current = new Set();
export function tickDueling() {
    const duelingscore = getOrCreateObjective("dueling_story");
    const isActive = getScoreSafe(duelingscore, ".state", 0);
    if (isActive === 1) {
        const players = world.getAllPlayers();
        for (const player of players) {
            if (!current.has(player.id) &&
                templeWarpAABB.find((aabb) => isPointInsideAABB(player.location, aabb.min, aabb.max))) {
                player.fadeOut();
                current.add(player.id);
                system.runTimeout(() => {
                    if (player.isValid()) {
                        player.teleport({ x: 3302.5, y: 51.0, z: 0.5 }, {
                            rotation: { x: 0, y: 90 },
                        });
                        player.fadeIn();
                        current.delete(player.id);
                    }
                }, 20);
            }
        }
    }
}
