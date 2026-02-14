#
tag @e[type=spark:box] add old_spawn
summon spark:box ~ ~ ~ 0 0 spark:size_2
tag @e[type=spark:box,tag=!old_spawn] add size_2
tag @e[type=spark:box,tag=!old_spawn] add force_cube

scoreboard players add @e[type=spark:box,tag=!old_spawn] collide_time 0
scoreboard players add @e[type=spark:box,tag=!old_spawn] force_time 0
scoreboard players add @e[type=spark:box,tag=!old_spawn] ID.attacker 0