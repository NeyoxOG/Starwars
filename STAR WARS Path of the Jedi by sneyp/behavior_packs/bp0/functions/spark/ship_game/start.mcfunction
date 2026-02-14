#
function spark/ship_game/setup

#
tp @a 1257.50 48.00 7821.5 180 0

event entity @e[type=spark:naboo_security_officer] spark:despawn
event entity @e[type=spark:starfighter] spark:despawn

event entity @e[type=spark:recon_droid_large] spark:despawn
event entity @e[type=spark:recon_droid_medium] spark:despawn
event entity @e[type=spark:recon_droid_small] spark:despawn

schedule on_area_loaded add 1236 47 7801 1281 57 7839 spark/ship_game/cutscene_base

#summon spark:padme_amidala 993.5 55.00 1332.5

#summon spark:starfighter 995.50 48.00 1567.5 200 0
#summon spark:starfighter 1021.50 48.00 1567.5 160 0

time set day

scoreboard objectives setdisplay sidebar

scoreboard players set .game_time ship_game 0

scoreboard players set set area_fatigue 0

tag @a remove ship_area_1
tag @a remove ship_area_2
tag @a remove ship_area_3
tag @a remove ship_area_4
tag @a remove ship_area_5
tag @a remove ship_area_6