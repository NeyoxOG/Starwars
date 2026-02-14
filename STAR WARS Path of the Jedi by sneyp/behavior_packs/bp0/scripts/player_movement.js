import { world } from "@minecraft/server";
let time_last_tick = Date.now();
let smooth_tps = 20;
let timer = 0;
export default function playerMovementTick(overworld) {
    let time = Date.now();
    let TPS = Math.min(1000 / (time - time_last_tick), 21) || 20;
    smooth_tps = isNaN(smooth_tps) ? 0 : smooth_tps;
    smooth_tps = smooth_tps + (TPS - smooth_tps) * 0.08;
    time_last_tick = time;
    timer++;
    if (timer > 15) {
        timer = 0;
        if (!Number.isNaN(smooth_tps))
            world.scoreboard.getObjective("timer").setScore("tps", Math.round(smooth_tps));
    }
    let jumping_players = overworld.getPlayers({
        tags: ['double_jump']
    });
    for (let player of jumping_players) {
        let direction = player.getViewDirection();
        player.applyKnockback(direction.x, direction.z, smooth_tps < 17 ? 1.5 : 1.35, 0.62);
        player.removeTag('double_jump');
    }
}
