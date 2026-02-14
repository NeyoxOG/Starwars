#
#kill @s

#
tellraw @a {"rawtext":[{"text":"§6[CUTSECENE/DIALOG] Tutorial"}]}

#
#event entity @e[type=spark:naboo_security_officer] spark:despawn
execute positioned 1257.50 48.00 7806.5 run dialogue change @e[type=spark:naboo_security_officer,c=1] spark:ship_pilot.naboo_guard.2
execute positioned 1257.50 48.00 7806.5 run dialogue open @e[c=1,type=spark:naboo_security_officer] @a

event entity @e[type=spark:starfighter] spark:despawn

summon spark:starfighter 1270 48 7808 200 0
summon spark:starfighter 1244 48 7808 160 0

scoreboard objectives setdisplay sidebar ship_score
scoreboard players set .value ship_score 0

scoreboard players set .state ship_game 2

scoreboard players set .scene_time ship_game 0