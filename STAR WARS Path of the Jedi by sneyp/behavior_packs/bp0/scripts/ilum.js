import { Player, system } from "@minecraft/server";
system.afterEvents.scriptEventReceive.subscribe(event => {
    if (event.id === "spark:ilum_death") {
        let player = event.sourceEntity;
        if (player instanceof Player) {
            const spawnPoint = player.getSpawnPoint();
            if (!spawnPoint)
                return; // TODO: figure out how to handle this
            const ent = spawnPoint.dimension.getEntitiesAtBlockLocation(spawnPoint).find(ent => ent.typeId === "spark:ilum_checkpoint");
            const viewDir = ent?.getViewDirection() ?? player.getViewDirection();
            player.teleport({
                x: spawnPoint.x + 0.5,
                y: spawnPoint.y,
                z: spawnPoint.z + 0.5
            }, {
                "checkForBlocks": true,
                "dimension": spawnPoint.dimension,
                "facingLocation": {
                    x: spawnPoint.x + 0.5 + viewDir.x * 10,
                    y: spawnPoint.y + viewDir.y,
                    z: spawnPoint.z + 0.5 + viewDir.z * 10,
                },
            });
            // LEVEL_MANAGER.addParallelAction(2, (tick:number) =>{
            //     if (tick == 1){
            //         // lol wat.
            //         (player as Player).playSound("sound.spark.player_death_respawn")
            //         //player.playSound("sound.spark.player_death_respawn");
            //     }
            // });
        }
    }
});
