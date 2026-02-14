import { world, } from "@minecraft/server";
function forceTick() {
    const overworld = world.getDimension("overworld");
    let players = world.getAllPlayers();
    //QUERY CHECKS FOR TAGS
    let q_attacker = {
        tags: ["push_attacker"],
    };
    let q_target = {
        tags: ["push_target"],
    };
    let q_attacker_pull = {
        tags: ["pull_attacker"],
    };
    let q_target_pull = {
        tags: ["pull_target"],
    };
    let q_grabbed = {
        tags: ["grab_end"],
    };
    let q_grab_dir = {
        tags: ["grab_dir"],
    };
    let q_grab_loop = {
        tags: ["grab_current"],
    };
    let q_grab_loop_end = {
        tags: ["grab_current_end"],
    };
    let q_grab_user = {
        tags: ["grab_user"],
    };
    let q_grab_user_id = {
        tags: ["grab_user_id"],
    };
    let q_bump = {
        tags: ["bump"],
    };
    //FORCE PUSH
    // PUSH VICTIMS ARE FOUND AT THE RUNTIME OF THE ATTACK BY THE ATTACKER, NO ATTACKER ID REQUIRED
    for (let entity of overworld.getEntities(q_attacker)) {
        const loc_attack = entity.location;
        const look_vec = entity.getViewDirection();
        let org_x = loc_attack.x;
        let org_y = loc_attack.y;
        let org_z = loc_attack.z;
        entity.runCommand("tag @e remove push_target");
        entity.runCommand("execute positioned ^ ^ ^5 run tag @e[family=force,r=8,tag=!kill] add push_target");
        entity.runCommand("execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove push_target");
        entity.runCommand("execute as @e[tag=push_target,tag=solid,tag=force_cube] at @s run function spark/force/entity/box/off_ground");
        entity.runCommand("execute as @e[tag=push_target,tag=solid,tag=force_cube] at @s run function spark/force/entity/box/unsolid");
        entity.runCommand("tag @e[tag=kill] remove push_target");
        entity.runCommand("execute positioned ^ ^ ^5 run tag @e[family=force,r=8,tag=!kill] add push_target");
        entity.runCommand("execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove push_target");
        entity.runCommand("scoreboard players set @e[tag=push_target] collide_time 20");
        let power_base = 1.1;
        let damage = 3;
        let myTags = entity.getTags();
        if (contains(myTags, "weak_1")) {
            power_base = 0.9;
            damage = 2;
        }
        if (contains(myTags, "weak_2")) {
            power_base = 0.7;
            damage = 1;
        }
        if (contains(myTags, "weak_3")) {
            power_base = 0.4;
            damage = 0;
        }
        entity.runCommand("damage @e[tag=push_target,tag=!force_cube,tag=!force_proof] " + damage + " entity_explosion");
        for (let entity of overworld.getEntities(q_target)) {
            let myTags = entity.getTags();
            let knockback = loc_attack;
            knockback.x = org_x;
            knockback.y = org_y;
            knockback.z = org_z;
            // WEIGHT SET
            let weight = 1;
            let power = 1.1;
            let power_y = 0.7;
            power_y *= power_base / power;
            if (power_y < 0.4)
                power_y = 0.4;
            power = power_base;
            // CONTROLS FOR KNOCKBACK
            if (contains(myTags, "size_2")) {
                power *= 0.9;
            }
            if (contains(myTags, "size_3")) {
                power *= 0.65;
            }
            if (contains(myTags, "size_5")) {
                power *= 0.45;
            }
            //entity.runCommand("say power: " + power + " power_base: " + power_base);
            knockback.x = entity.location.x - loc_attack.x;
            knockback.y = entity.location.y - loc_attack.y;
            knockback.z = entity.location.z - loc_attack.z;
            var hor_length = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.z, 2), 0.5);
            // Y KNOCKBACK IS CONSISTANT
            knockback.x = (knockback.x / hor_length) * power + look_vec.x / 2;
            knockback.z = (knockback.z / hor_length) * power + look_vec.z / 2;
            knockback.y = power_y;
            // WEIGHT
            knockback.x /= weight;
            knockback.y /= weight;
            knockback.z /= weight;
            entity.applyImpulse(knockback);
            entity.runCommand("tag @s remove push_target");
            entity.runCommand("event entity @s spark:set_force_effect_none");
        }
        entity.runCommand("tag @s remove push_attacker");
    }
    for (let entity of overworld.getEntities(q_grabbed)) {
        let myTags = entity.getTags();
        const look_vec = entity.getViewDirection();
        const loc_grabbed = entity.location;
        let knockback = look_vec;
        knockback.x = 0;
        knockback.y = 0.02;
        knockback.z = 0;
        entity.runCommand("execute at @s run tag @e[r=0.5] remove grab_dir");
        for (let entity of overworld.getEntities(q_grab_dir)) {
            knockback.x = entity.location.x - loc_grabbed.x;
            knockback.y = entity.location.y - loc_grabbed.y;
            knockback.z = entity.location.z - loc_grabbed.z;
            let mag = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.y, 2) + Math.pow(knockback.z, 2), 0.5);
            if (contains(myTags, "size_1")) {
                mag *= 1.1;
            }
            if (contains(myTags, "size_2")) {
                mag *= 1.5;
            }
            if (contains(myTags, "size_3")) {
                mag *= 2;
            }
            if (contains(myTags, "size_5")) {
                mag *= 3;
            }
            knockback.x /= mag;
            knockback.y /= mag;
            knockback.z /= mag;
        }
        if (knockback.y < 0.02)
            knockback.y = 0.02;
        //entity.runCommand("execute as @e[tag=kill,type=!spark:marker_box] at @s run summon cow");
        entity.runCommand("tag @s remove grab_end");
        entity.applyImpulse(knockback);
    }
    for (let entity of overworld.getEntities(q_grab_loop_end)) {
        entity.removeTag("grab_current_end");
        let myTags = entity.getTags();
        if (!contains(myTags, "grab_current")) {
            let vel = entity.getVelocity();
            let vel_mag = Math.pow(Math.pow(vel.x, 2) + Math.pow(vel.y, 2) + Math.pow(vel.z, 2), 0.5);
            if (contains(myTags, "grab_current_far")) {
                entity.removeTag("grab_current_far");
                entity.clearVelocity();
                if (vel_mag > 1.0) {
                    vel.x /= vel_mag / 1.0;
                    vel.y /= vel_mag / 1.0;
                    vel.z /= vel_mag / 1.0;
                    entity.applyImpulse(vel);
                }
            }
            else {
                entity.clearVelocity();
                if (vel_mag > 0.4) {
                    vel.x /= vel_mag / 0.4;
                    vel.y /= vel_mag / 0.4;
                    vel.z /= vel_mag / 0.4;
                    entity.applyImpulse(vel);
                }
            }
            if (contains(myTags, "size_1")) {
                entity.clearVelocity();
            }
        }
    }
    for (let entity of overworld.getEntities(q_grab_loop)) {
        let freeze = false;
        let found_user = false;
        let facing = false;
        let too_close = false;
        let ent_store = entity;
        let myTags = entity.getTags();
        const look_vec = entity.getViewDirection();
        const loc_grabbed = entity.location;
        let face_loc = look_vec;
        let knockback = look_vec;
        let vel = entity.getVelocity();
        let vel_mag = Math.pow(Math.pow(vel.x, 2) + Math.pow(vel.y, 2) + Math.pow(vel.z, 2), 0.5);
        if (vel_mag > 1.05) {
            entity.clearVelocity();
            vel.x /= vel_mag / 1.05;
            vel.y /= vel_mag / 1.05;
            vel.z /= vel_mag / 1.05;
            entity.applyImpulse(vel);
        }
        let x_dif = 0;
        let y_dif = 0;
        let z_dif = 0;
        let box_dist = 0;
        knockback.x = 0;
        knockback.y = 0.02;
        knockback.z = 0;
        let dist = 0;
        for (let i = 0; i < players.length; i++) {
            players[i].removeTag("grab_user_id");
        }
        entity.addTag("current_box");
        entity.runCommand("execute as @a[tag=grab_user] at @s if score @s ID = @e[tag=current_box,c=1] ID.attacker run tag @s add grab_user_id");
        entity.removeTag("current_box");
        for (let entity of overworld.getEntities(q_grab_user_id)) {
            found_user = true;
            let go_to_loc = entity.location;
            let dist_to_goal = 0;
            let block = false;
            let stop = false;
            let grid = false;
            let good_enough_lol = 0.25;
            let face_extra = 0;
            box_dist = vec_mag_2(loc_grabbed, entity.location);
            if (contains(myTags, "size_1")) {
                grid = true;
                face_extra = 0.3;
            }
            if (contains(myTags, "size_2")) {
                face_extra = 0.65;
            }
            if (contains(myTags, "size_3")) {
                face_extra = 1.15;
            }
            if (contains(myTags, "size_5")) {
                face_extra = 2.15;
            }
            if (vel_mag < 0.1)
                grid = true;
            face_loc = entity.location;
            let look_vec2 = entity.getViewDirection();
            const hitResult = entity.getBlockFromViewDirection({
                maxDistance: 8.5,
                includeLiquidBlocks: false
            });
            if (hitResult) {
                let corner = false;
                let face = hitResult.face;
                let x = hitResult.block.location.x + hitResult.faceLocation.x - 0.5;
                let y = hitResult.block.location.y + hitResult.faceLocation.y + 0.25;
                let z = hitResult.block.location.z + hitResult.faceLocation.z - 0.5;
                if (grid) {
                    x = Math.round(x) + 0.5;
                    y = Math.round(y) + 0.5;
                    z = Math.round(z) + 0.5;
                }
                go_to_loc.x = x;
                go_to_loc.y = y;
                go_to_loc.z = z;
                //if((face == "East" || face == "West" || face == "North" || face == "South") && go_to_loc.y - loc_grabbed.y < -1  && Math.abs(go_to_loc.x - loc_grabbed.x) > 1.2  && Math.abs(go_to_loc.z - loc_grabbed.z) > 1.2 && hitResult.faceLocation.y > 0.8) corner = true;
                if (!corner && face == "East")
                    go_to_loc.x += 0.1 + face_extra;
                if (!corner && face == "West")
                    go_to_loc.x -= 0.1 + face_extra;
                if (!corner && face == "South")
                    go_to_loc.z += 0.1 + face_extra;
                if (!corner && face == "North")
                    go_to_loc.z -= 0.1 + face_extra;
                if (!corner && face == "East" && (Math.abs(go_to_loc.z - loc_grabbed.z) > 0.8 || Math.abs(go_to_loc.y - loc_grabbed.y) > 1.3))
                    go_to_loc.x += 0.25;
                if (!corner && face == "West" && (Math.abs(go_to_loc.z - loc_grabbed.z) > 0.8 || Math.abs(go_to_loc.y - loc_grabbed.y) > 1.3))
                    go_to_loc.x -= 0.45;
                if (!corner && face == "South" && (Math.abs(go_to_loc.x - loc_grabbed.x) > 0.8 || Math.abs(go_to_loc.y - loc_grabbed.y) > 1.3))
                    go_to_loc.z += 0.25;
                if (!corner && face == "North" && (Math.abs(go_to_loc.x - loc_grabbed.x) > 0.8 || Math.abs(go_to_loc.y - loc_grabbed.y) > 1.3))
                    go_to_loc.z -= 0.45;
                knockback.x = go_to_loc.x - loc_grabbed.x;
                knockback.y = go_to_loc.y - loc_grabbed.y;
                knockback.z = go_to_loc.z - loc_grabbed.z;
                //entity.runCommand("say " + x + " " + y + " " + z);
                facing = true;
                block = true;
            }
            else {
                go_to_loc.x += look_vec2.x * 7.6;
                go_to_loc.y += look_vec2.y * 7.6;
                go_to_loc.z += look_vec2.z * 7.6;
                go_to_loc.y += 2.2;
                knockback.x = go_to_loc.x - loc_grabbed.x;
                knockback.y = go_to_loc.y - loc_grabbed.y;
                knockback.z = go_to_loc.z - loc_grabbed.z;
            }
            dist_to_goal = vec_mag_2(go_to_loc, entity.location);
            x_dif = knockback.x;
            y_dif = knockback.y;
            z_dif = knockback.z;
            let mag = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.y, 2) + Math.pow(knockback.z, 2), 0.5);
            dist = mag;
            if (mag > 3)
                mag = 3;
            if (vel_mag > 1.5)
                mag = 1;
            if (!contains(myTags, "size_2") && !contains(myTags, "size_3") && !contains(myTags, "size_5")) {
                mag *= 1.5;
                good_enough_lol = 0.3;
            }
            if (contains(myTags, "size_2")) {
                mag *= 1.7;
                good_enough_lol = 0.8;
            }
            if (contains(myTags, "size_3")) {
                mag *= 2;
                good_enough_lol = 0.8;
                if (box_dist < 2.5 && dist_to_goal < 2.5)
                    too_close = true;
            }
            if (contains(myTags, "size_5")) {
                mag *= 4;
                good_enough_lol = 0.8;
                if (box_dist < 3.5 && dist_to_goal < 3.5)
                    too_close = true;
                mag *= 2;
            }
            if (dist < 1.2 && (y_dif < 1 || vel_mag > 0.4)) {
                ent_store.clearVelocity();
                facing = true;
                if (knockback.x > 0.2)
                    knockback.x = 0.2;
                if (knockback.y > 0.2)
                    knockback.y = 0.2;
                if (knockback.z > 0.2)
                    knockback.z = 0.2;
                if (knockback.x < -0.2)
                    knockback.x = -0.2;
                if (knockback.y < -0.2)
                    knockback.y = -0.2;
                if (knockback.z < -0.2)
                    knockback.z = -0.2;
            }
            if (dist < good_enough_lol) {
                ent_store.clearVelocity();
                facing = true;
                stop = true;
                knockback.x = 0;
                knockback.y = 0;
                knockback.z = 0;
                freeze = ent_store.tryTeleport({ x: go_to_loc.x, y: go_to_loc.y, z: go_to_loc.z }, { checkForBlocks: true });
            }
            if (dist < 3 && vel_mag > 1.0 && y_dif < 1) {
                mag *= 2;
                ent_store.clearVelocity();
                facing = true;
            }
            if (dist > 6.9 && vel_mag > 0.5) {
                mag *= 2;
                ent_store.clearVelocity();
                facing = true;
            }
            if (block)
                mag /= 3;
            if (vel_mag > 1.3)
                mag = 100;
            knockback.x /= mag;
            knockback.y /= mag / 2;
            knockback.z /= mag;
            if (knockback.y > 0.2)
                knockback.y = 0.15;
            //entity.runCommand("say " + vel_mag);
            //entity.runCommand("say " + knockback.x + " " + knockback.y + " " + knockback.z);
        }
        if (found_user) {
            //entity.runCommand("execute as @e[tag=kill,type=!spark:marker_box] at @s run summon cow");
            entity.removeTag("grab_current_far");
            if (dist > 2.0)
                entity.addTag("grab_current_far");
            entity.addTag("grab_current_end");
            //entity.setRotation({ x: 45, y: 0 });
            if (facing) {
                entity.teleport({
                    x: entity.location.x,
                    y: entity.location.y,
                    z: entity.location.z
                }, {
                    "checkForBlocks": true,
                    "facingLocation": {
                        x: face_loc.x,
                        y: face_loc.y,
                        z: face_loc.z,
                    },
                });
            }
            let final_knock_vec = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.y, 2) + Math.pow(knockback.z, 2), 0.5);
            //if(final_knock_vec == 0) final_knock_vec = 1;
            if (x_dif != 0 && vel.x == 0 && dist > 1.4) {
                let less_vec = Math.pow(Math.pow(knockback.y, 2) + Math.pow(knockback.z, 2), 0.5);
                if (final_knock_vec > 0 && less_vec > 0) {
                    knockback.y /= less_vec / final_knock_vec;
                    knockback.z /= less_vec / final_knock_vec;
                }
                knockback.y += Math.sign(y_dif) / 6;
                knockback.x *= 0;
                entity.applyImpulse({ x: Math.sign(x_dif) / 10, y: 0, z: 0 });
            }
            if (y_dif != 0 && vel.y == 0 && dist > 0.9) {
                let less_vec = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.z, 2), 0.5);
                if (final_knock_vec > 0 && less_vec > 0) {
                    knockback.x /= less_vec / final_knock_vec;
                    knockback.z /= less_vec / final_knock_vec;
                }
                knockback.y *= 0;
                entity.applyImpulse({ x: 0, y: Math.sign(y_dif) / 10, z: 0 });
            }
            if (z_dif != 0 && vel.z == 0 && dist > 1.4) {
                let less_vec = Math.pow(Math.pow(knockback.y, 2) + Math.pow(knockback.x, 2), 0.5);
                if (final_knock_vec > 0 && less_vec > 0) {
                    knockback.y /= less_vec / final_knock_vec;
                    knockback.x /= less_vec / final_knock_vec;
                }
                knockback.y += Math.sign(y_dif) / 6;
                knockback.z *= 0;
                entity.applyImpulse({ x: 0, y: 0, z: Math.sign(z_dif) / 10 });
            }
            var hor_length = Math.pow(Math.pow(x_dif, 2) + Math.pow(z_dif, 2), 0.5);
            if (hor_length < 1.8 && !contains(myTags, "size_1")) {
                knockback.x /= 1.2;
                knockback.z /= 1.2;
            }
            if (hor_length < 1.0 && !contains(myTags, "size_1")) {
                knockback.x = 0;
                knockback.z = 0;
            }
            if (hor_length < 0.6 && contains(myTags, "size_1")) {
                knockback.x = 0;
                knockback.z = 0;
            }
            if (knockback.x > 0.7)
                knockback.x = 0.7;
            if (knockback.y > 0.7)
                knockback.y = 0.7;
            if (knockback.z > 0.7)
                knockback.z = 0.7;
            if (knockback.x < -0.7)
                knockback.x = -0.7;
            if (knockback.y < -0.7)
                knockback.y = -0.7;
            if (knockback.z < -0.7)
                knockback.z = -0.7;
            if (x_dif > 0 && knockback.x < 0)
                knockback.x *= -1;
            if (x_dif < 0 && knockback.x > 0)
                knockback.x *= -1;
            if (y_dif > 0 && knockback.y < 0)
                knockback.y *= -1;
            if (y_dif < 0 && knockback.y > 0)
                knockback.y *= -1;
            if (z_dif > 0 && knockback.z < 0)
                knockback.z *= -1;
            if (z_dif < 0 && knockback.z > 0)
                knockback.z *= -1;
            if (Math.abs(knockback.x) < 0.001 && Math.abs(x_dif) > 0.04)
                knockback.x = Math.sign(x_dif) / 15;
            if (Math.abs(knockback.z) < 0.001 && Math.abs(z_dif) > 0.04)
                knockback.z = Math.sign(z_dif) / 15;
            if (Math.abs(y_dif) < 0.25)
                knockback.y = 0.05;
            //if((x_dif != 0 && vel.x == 0) || (y_dif != 0 && vel.y == 0) || (z_dif != 0 && vel.z == 0) && dist > 0.9)
            //    entity.runCommand("say " + knockback.x + " " + knockback.y + " " + knockback.z + " vel " + dist+ " dist " + dist);
            if (!Number.isNaN(knockback.x) && !Number.isNaN(knockback.y) && !Number.isNaN(knockback.z) && !too_close && !freeze) {
                entity.applyImpulse(knockback);
            }
        }
    }
    for (let entity of overworld.getEntities(q_bump)) {
        const look_vec = entity.getViewDirection();
        let knockback = look_vec;
        knockback.x = 0;
        knockback.y = 0.02;
        knockback.z = 0;
        entity.runCommand("scoreboard players set @s fall_time 0");
        entity.runCommand("tag @s remove bump");
        entity.applyImpulse(knockback);
    }
    for (let entity of overworld.getEntities(q_attacker_pull)) {
        const loc_attack = entity.location;
        const look_vec = entity.getViewDirection();
        let org_x = loc_attack.x;
        let org_y = loc_attack.y;
        let org_z = loc_attack.z;
        entity.runCommand("tag @e remove pull_target");
        entity.runCommand("tag @e[family=force,r=10,tag=!kill,tag=grabbed_prev] add pull_target");
        entity.runCommand("execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove pull_target");
        entity.runCommand("execute as @e[tag=pull_target,tag=solid,tag=force_cube] at @s run function spark/force/entity/box/off_ground");
        entity.runCommand("execute as @e[tag=pull_target,tag=solid,tag=force_cube] at @s run function spark/force/entity/box/unsolid");
        entity.runCommand("tag @e[tag=kill] remove pull_target");
        entity.runCommand("tag @e[family=force,r=10,tag=!kill,tag=grabbed_prev] add pull_target");
        entity.runCommand("execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove pull_target");
        entity.runCommand("scoreboard players set @e[tag=pull_target] collide_time 20");
        entity.runCommand("tag @e[tag=grabbed_prev] remove grabbed_prev");
        let power_base = 1.1;
        let damage = 7;
        let myTags = entity.getTags();
        if (contains(myTags, "weak_1")) {
            power_base = 0.9;
        }
        if (contains(myTags, "weak_2")) {
            power_base = 0.9;
        }
        if (contains(myTags, "weak_3")) {
            power_base = 0.9;
        }
        entity.runCommand("damage @e[tag=pull_target,tag=!force_cube,tag=!force_proof] " + damage + " entity_explosion");
        for (let entity of overworld.getEntities(q_target_pull)) {
            let myTags = entity.getTags();
            let knockback = loc_attack;
            // WEIGHT SET
            let weight = 1;
            let power = 1.1;
            let power_y = 0.7;
            let max_hor = 2;
            power_y *= power_base / power;
            if (power_y < 0.4)
                power_y = 0.4;
            power = power_base;
            // CONTROLS FOR KNOCKBACK
            if (!contains(myTags, "size_2") && !contains(myTags, "size_3") && !contains(myTags, "size_5")) {
                max_hor = 0.6;
                power *= 0.6;
                org_x += look_vec.x * 1.5;
                org_y += look_vec.y * 1.5;
                org_z += look_vec.z * 1.5;
            }
            if (contains(myTags, "size_2")) {
                power *= 0.6;
                max_hor = 1.3;
                org_x += look_vec.x * 2.5;
                org_y += look_vec.y * 2.5;
                org_z += look_vec.z * 2.5;
            }
            if (contains(myTags, "size_3")) {
                power *= 0.65;
                org_x += look_vec.x * 3.5;
                org_y += look_vec.y * 3.5;
                org_z += look_vec.z * 3.5;
            }
            if (contains(myTags, "size_5")) {
                power *= 0.65;
                org_x += look_vec.x * 4.5;
                org_y += look_vec.y * 4.5;
                org_z += look_vec.z * 4.5;
            }
            power *= -1;
            //
            knockback.x = org_x;
            knockback.y = org_y;
            knockback.z = org_z;
            //entity.runCommand("say power: " + power + " power_base: " + power_base);
            knockback.x = entity.location.x - loc_attack.x;
            knockback.y = entity.location.y - loc_attack.y;
            knockback.z = entity.location.z - loc_attack.z;
            var hor_length = Math.pow(Math.pow(knockback.x, 2) + Math.pow(knockback.z, 2), 0.5);
            power *= hor_length / 5;
            if (hor_length < max_hor) {
                power /= 2;
            }
            // Y KNOCKBACK IS CONSISTANT
            knockback.x = (knockback.x / hor_length) * power;
            knockback.z = (knockback.z / hor_length) * power;
            knockback.y = power_y;
            // WEIGHT
            knockback.x /= weight;
            knockback.y /= weight;
            knockback.z /= weight;
            entity.applyImpulse(knockback);
            entity.runCommand("tag @s remove pull_target");
            entity.runCommand("event entity @s spark:set_force_effect_none");
        }
        entity.runCommand("tag @s remove pull_attacker");
    }
}
export { forceTick };
function contains(a, obj) {
    var i = a.length;
    while (i--) {
        if (a[i] === obj) {
            return true;
        }
    }
    return false;
}
function vec_mag_2(a, b) {
    var i = 0;
    i = Math.pow(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2) + Math.pow(a.z - b.z, 2), 0.5);
    return i;
}
//# sourceMappingURL=force.js.map
