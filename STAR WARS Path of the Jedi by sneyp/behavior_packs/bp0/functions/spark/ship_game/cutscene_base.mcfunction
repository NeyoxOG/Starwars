#
tellraw @a {"rawtext":[{"text":"§6[CUTSECENE/DIALOG] Spawn in base"}]}

scoreboard players set .state ship_game 1

event entity @e[type=spark:jar_jar_binks] spark:despawn
event entity @e[type=spark:naboo_security_officer] spark:despawn
#kill @e[type=spark:naboo_security_officer]

event entity @e[type=spark:starfighter] spark:despawn
#kill @e[type=spark:starfighter]
summon spark:naboo_security_officer 1257.50 48.00 7806.5 0 0 spark:quest_npc

event entity @e[type=spark:recon_droid_large] spark:despawn
event entity @e[type=spark:recon_droid_medium] spark:despawn
event entity @e[type=spark:recon_droid_small] spark:despawn

titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"spark.ui.location.naboo", "with": [ "\n" ] }]}

scoreboard players set .scene_time ship_game 0