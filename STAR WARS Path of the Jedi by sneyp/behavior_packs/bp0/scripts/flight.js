import { lerp, getLength, trimDegree } from './util';
let plane_data = {};
function fly(starfighter) {
    if (starfighter.hasTag('on_ground'))
        return;
    if (!plane_data[starfighter.id]) {
        plane_data[starfighter.id] = {
            previous_direction: null,
            previous_speed: 0.1,
            smoothed_speed: 0.1,
            boost_timeout: 0,
        };
    }
    let player = starfighter.dimension.getPlayers({
        location: starfighter.location,
        maxDistance: 18,
        closest: 1
    })[0];
    if (!player)
        return;
    let data = plane_data[starfighter.id];
    let direction = player.getViewDirection();
    if (!data.previous_direction) {
        data.previous_direction = direction;
    }
    let interpolation = 1.4;
    let target_direction = {
        x: lerp(data.previous_direction.x, direction.x, interpolation),
        y: lerp(data.previous_direction.y, direction.y, 5),
        z: lerp(data.previous_direction.z, direction.z, interpolation),
    };
    target_direction.y *= 1.1;
    let result = starfighter.runCommand('testforblock ~ ~-1 ~ water');
    if (result.successCount) {
        if (target_direction.y < 0.4) {
            target_direction.y = 2;
        }
        else {
            target_direction.y = 0.6;
        }
    }
    data.previous_direction = direction;
    let velocity = starfighter.getVelocity();
    let linear_velocity = getLength(velocity);
    // Pitch
    let pitch = Math.atan2(Math.sqrt(Math.pow(velocity.z, 2) + Math.pow(velocity.x, 2)), velocity.y) / Math.PI * 180 - 90;
    pitch = Math.round(pitch * 0.5);
    if (Math.abs(pitch) > 2) {
        starfighter.runCommand(`event entity @s spark:set_pitch_${pitch < 0 ? 'n' : ''}${Math.min(Math.abs(pitch), 40)}`);
    }
    else {
        starfighter.runCommand(`event entity @s spark:set_pitch_0`);
    }
    // Cam Pitch
    let cam_pitch = Math.atan2(Math.sqrt(Math.pow(direction.z, 2) + Math.pow(direction.x, 2)), direction.y) / Math.PI * 180 - 90;
    cam_pitch = Math.round(cam_pitch * 0.5);
    starfighter.runCommand(`event entity @s spark:set_cam_pitch_${cam_pitch < 0 ? 'n' : ''}${Math.min(Math.abs(cam_pitch), 40)}`);
    // Cam Yaw
    let cam_yaw = trimDegree((Math.atan2(direction.z, direction.x) - Math.atan2(velocity.z, velocity.x)) / Math.PI * 180);
    cam_yaw = Math.round(cam_yaw);
    starfighter.runCommand(`event entity @s spark:set_cam_yaw_${cam_yaw < 0 ? 'n' : ''}${Math.min(Math.abs(cam_yaw), 40)}`);
    let is_accelerating = linear_velocity > data.smoothed_speed * 14;
    if (data.boost_timeout <= 0 && is_accelerating) {
        data.boost_timeout = 30;
        player.runCommand('playsound conduit.activate @s ^ ^ ^15 10000');
    }
    // starfighter.runCommand('say velocity ' + Math.round(linear_velocity * 100) + (is_accelerating ? '+' : '=') + ' ' + Math.round(data.smoothed_speed*100))
    let speed = data.previous_speed;
    if (data.boost_timeout > 10) {
        speed = Math.min(speed + 0.2, 1.5);
    }
    else {
        speed = Math.max(speed - 0.05, 0.1);
    }
    if (data.boost_timeout > 20) {
        player.runCommand('effect @s speed 2 2 true');
    }
    data.previous_speed = speed;
    data.smoothed_speed = lerp(data.smoothed_speed, speed, 0.1);
    data.boost_timeout--;
    //starfighter.runCommand('say speed ' + Math.round(speed*10))
    // Apply linear drag (terminal speed)
    let drag_coefficient = 0.25;
    target_direction.x -= velocity.x * drag_coefficient;
    target_direction.y -= velocity.y * drag_coefficient * 1.3;
    target_direction.z -= velocity.z * drag_coefficient;
    // Accelerate
    let anti_gravity_constant = 0.05;
    let glide_effect = 0.85;
    starfighter.applyImpulse({
        x: target_direction.x * speed,
        y: target_direction.y * speed * glide_effect + anti_gravity_constant,
        z: target_direction.z * speed,
    });
}
function flightTick(overworld) {
    let starfighters = overworld.getEntities({
        type: 'spark:starfighter',
        tags: ['piloted_ship']
    });
    for (let entity of starfighters) {
        fly(entity);
    }
}
export { flightTick };
