import { system, world } from "@minecraft/server";
import { computeBounds, isPointInsideAABB } from "./AABB";
const bounds = computeBounds({
    x: -10,
    y: -10,
    z: -10,
}, {
    x: 10,
    y: 10,
    z: 10,
});
let hasPlayedMusicThisPlaysession = false;
world.afterEvents.playerSpawn.subscribe((event) => {
    if (isPointInsideAABB(event.player.location, bounds.min, bounds.max) &&
        !event.player.hasTag("blackbox_spawned")) {
        if (!hasPlayedMusicThisPlaysession) {
            // event.player.dimension.runCommandAsync('music play sound.spark.ambience_start_room 1.0 0.1 loop');
            system.runTimeout(() => {
                world.playMusic("sound.spark.ambience_start_room", { volume: 1.0, fade: 0.1, loop: true });
            }, 100);
            hasPlayedMusicThisPlaysession = true;
        }
        if (event.initialSpawn) {
            event.player.addTag("blackbox_spawned");
            event.player.teleport({
                x: 4.54,
                y: 0,
                z: -1.22,
            }, {
                rotation: {
                    x: 0,
                    y: 81.9,
                },
            });
        }
    }
});
