import { system, world, } from "@minecraft/server";
import { computeBounds, isPointInsideAABB } from "./AABB";
export var DroidModificationRoom;
(function (DroidModificationRoom) {
    const dockingPoints = [
        {
            x: 8841.5,
            y: 26,
            z: 8912.5,
            r: -90,
            id: 1
        },
        {
            x: 8853.5,
            y: 26,
            z: 8912.5,
            r: 90,
            id: 2
        },
        {
            x: 8841.5,
            y: 26,
            z: 8908.5,
            r: -90,
            id: 3
        },
        {
            x: 8853.5,
            y: 26,
            z: 8908.5,
            r: 90,
            id: 4
        },
    ];
    const aabb = computeBounds({
        x: 8833,
        y: 40,
        z: 8887,
    }, {
        x: 8857,
        y: 22,
        z: 8922,
    });
    const availableDroidBays = [1, 2, 3, 4];
    const assignedDroidBays = new Map();
    const assignedDroids = new Map();
    const knownPlayers = new Set();
    let playerId = world.scoreboard.getObjective("player_id");
    let petId = world.scoreboard.getObjective("pet_id");
    if (!playerId)
        playerId = world.scoreboard.addObjective("player_id", "player_id");
    if (!petId)
        petId = world.scoreboard.addObjective("pet_id", "pet_id");
    const overworld = world.getDimension("overworld");
    system.afterEvents.scriptEventReceive.subscribe((event) => {
        if (event.id === "spark:end_goto") {
            const mech = event.sourceEntity;
            let location = mech.location;
            let nearestPoint = dockingPoints.reduce((a, v) => {
                const dist = Math.sqrt(Math.pow(v.x - location.x, 2) + Math.pow(v.z - location.z, 2));
                if (dist < a.dist) {
                    return { dist, point: v };
                }
                return a;
            }, { dist: Infinity, point: dockingPoints[0] });
            const bay = nearestPoint.point.id;
            const [target] = overworld.getEntities({
                type: "spark:breadcrumb_" + bay,
                location: mech.location,
                maxDistance: 10,
            });
            if (target) {
                let location = target.location;
                overworld.spawnEntity("spark:breadcrumb_" + bay, location);
                target.triggerEvent("spark:despawn");
            }
            function teleportMech() {
                if (mech.isValid() && mech.hasTag("no_tp")) {
                    mech.teleport(nearestPoint.point, {
                        rotation: { x: 0, y: nearestPoint.point.r },
                        "keepVelocity": false,
                    });
                    system.run(teleportMech);
                }
            }
            teleportMech();
            // mech.triggerEvent("spark:reset_goto");
        }
    });
    function onPlayerEnter(player) {
        // since the map is limited to 4 players we can garantee there is a slot available
        const slot = availableDroidBays.sort().shift();
        assignedDroidBays.set(player, slot);
        const id = playerId.getScore(player);
        const pet = overworld.getEntities({
            scoreOptions: [
                {
                    objective: "pet_id",
                    minScore: id,
                    maxScore: id,
                },
            ],
        });
        if (pet.length === 0)
            throw new Error("No pet found for player " + player.name);
        const petEntity = pet[0];
        assignedDroids.set(player, petEntity);
        petEntity.triggerEvent("spark:goto" + slot);
        petEntity.triggerEvent("spark:disable_follow");
        petEntity.addTag("no_tp");
    }
    function onPlayerLeave(player) {
        const droid = assignedDroids.get(player);
        const bay = assignedDroidBays.get(player);
        availableDroidBays.push(bay);
        if (droid && droid.isValid()) {
            const [target] = overworld.getEntities({
                type: "spark:breadcrumb_" + bay,
                location: droid.location,
                maxDistance: 10,
            });
            if (target) {
                let location = target.location;
                overworld.spawnEntity("spark:breadcrumb_" + bay, location);
                target.triggerEvent("spark:despawn");
            }
            droid.removeTag("no_tp");
            droid.triggerEvent("spark:reset_goto");
            droid.triggerEvent("spark:enable_follow");
            droid.triggerEvent("spark:enable_movement");
        }
        assignedDroids.delete(player);
    }
    DroidModificationRoom.tick = () => {
        const overworld = world.getDimension("overworld");
        // let players = overworld.getPlayers({
        //   location: aabb.min,
        //   volume: volume,
        // });
        let players = overworld.getPlayers();
        // remove from list if not in bounds
        for (let i = players.length - 1; i > -1; i--) {
            if (!isPointInsideAABB(players[i].location, aabb.min, aabb.max)) {
                players.splice(i, 1);
            }
        }
        const allPlayers = new Set(players.concat(...knownPlayers));
        for (const player of allPlayers) {
            if (!player.isValid()) {
                knownPlayers.delete(player);
                continue;
            }
            if (knownPlayers.has(player) && players.indexOf(player) == -1) {
                // the player has left the area
                player.setDefaultHotbarLoadout();
                onPlayerLeave(player);
                knownPlayers.delete(player);
            }
            else if (!knownPlayers.has(player)) {
                onPlayerEnter(player);
                player.runCommandAsync("function spark/lightsaber/give_lightsaber");
                player.runCommandAsync('replaceitem entity @s slot.hotbar 1 spark:paint_tool 1 0 {"minecraft:item_lock":{ "mode": "lock_in_slot" }, "minecraft:keep_on_death":{}}');
                player.runCommandAsync('replaceitem entity @s slot.hotbar 2 spark:head_tool 1 0 {"minecraft:item_lock":{ "mode": "lock_in_slot" }, "minecraft:keep_on_death":{}}');
                player.runCommandAsync('replaceitem entity @s slot.hotbar 3 spark:pattern_tool 1 0 {"minecraft:item_lock":{ "mode": "lock_in_slot" }, "minecraft:keep_on_death":{}}');
                // play sound
                player.playSound("sound.spark.droid_pickup_cell");
                knownPlayers.add(player);
            }
        }
    };
})(DroidModificationRoom || (DroidModificationRoom = {}));
