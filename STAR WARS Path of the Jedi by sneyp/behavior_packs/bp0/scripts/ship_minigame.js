let spawn_loc;
function shipgameTick(world) {
    const overworld = world.getDimension("overworld");
    let players = world.getAllPlayers();
    //QUERY CHECKS FOR TAGS
    let q_bump_start = {
        tags: ["bump_start"],
    };
    let q_shot = {
        tags: ["shot"],
    };
    let q_bump_return = {
        tags: ["bump_return"],
    };
    let q_bump_return_2 = {
        tags: ["bump_return_2"],
    };
    for (let entity of overworld.getEntities(q_bump_start)) {
        spawn_loc = entity.getViewDirection();
        spawn_loc.x = entity.location.x;
        spawn_loc.y = entity.location.y;
        spawn_loc.z = entity.location.z;
        const look_vec = entity.getViewDirection();
        let knockback = look_vec;
        knockback.x = 0;
        knockback.y = 0.1;
        knockback.z = 0;
        entity.runCommand("scoreboard players set .state ship_game 5");
        entity.runCommand("tag @s remove bump_start");
        entity.applyImpulse(knockback);
    }
    for (let entity of overworld.getEntities(q_shot)) {
        //let dist_spawn = distance(entity.location, spawn_loc);
        //entity.runCommand("say " + dist_spawn);
        const look_vec = players[0].getViewDirection();
        let knockback = look_vec;
        knockback.y -= -0.1;
        knockback.x *= 4;
        knockback.y *= 4;
        knockback.z *= 4;
        entity.runCommand("tag @s remove shot");
        entity.clearVelocity();
        entity.applyImpulse(knockback);
    }
    for (let entity of overworld.getEntities(q_bump_return)) {
        const look_vec = entity.getViewDirection();
        let knockback = look_vec;
        knockback.x = 1267 - entity.location.x;
        knockback.z = 7698 - entity.location.z;
        let dist = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.z, 2), 0.5);
        knockback.x /= dist;
        knockback.z /= dist;
        entity.runCommand("tag @s remove bump_return");
        entity.runCommand("tag @s remove bump_return_2");
        entity.applyImpulse(knockback);
    }
    for (let entity of overworld.getEntities(q_bump_return_2)) {
        const look_vec = entity.getViewDirection();
        let knockback = look_vec;
        knockback.x = 1267 - entity.location.x;
        knockback.z = 7698 - entity.location.z;
        let dist = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.z, 2), 0.5);
        knockback.x /= dist;
        knockback.z /= dist;
        knockback.x /= 10;
        knockback.z /= 10;
        entity.runCommand("tag @s remove bump_return_2");
        entity.applyImpulse(knockback);
    }
}
export { shipgameTick };
function distance(a, b) {
    return Math.pow(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2) + Math.pow(a.z - b.z, 2), 0.5);
}
//# sourceMappingURL=ship_minigame.js.map
