import { world, system } from "@minecraft/server";
import { forceTick } from "./force";
import * as extensions from "./extensions";
import * as engine from "./engine";
import { archiveTick } from "./archive";
import { DroidModificationRoom } from "./droid_modifiction_room";
import playerMovementTick from "./player_movement";
import "./blackbox";
import "./elevator";
import "./ilum";
import { tickDueling } from "./dueling";
const overworld = world.getDimension("overworld");
function init() {
    // init extensions for player
    extensions.init();
    engine.init();
}
function mainTick() {
    // flight
    // flightTick(overworld);
    // shipgameTick(world);
    forceTick();
    playerMovementTick(overworld);
    archiveTick(world);
    engine.update();
    DroidModificationRoom.tick();
    tickDueling();
    system.run(mainTick);
}
system.run(init);
system.run(mainTick);
