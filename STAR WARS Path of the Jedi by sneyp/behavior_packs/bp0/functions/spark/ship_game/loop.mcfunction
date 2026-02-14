# kill and tag shots properly
tag @e[type=spark:starfighter_blaster_shot,tag=!old] add shot
tag @e[type=spark:starfighter_blaster_shot] add old
scoreboard players add @e[type=spark:starfighter_blaster_shot] t1 1
kill @e[type=spark:starfighter_blaster_shot,scores={t1=200}]

tag @e[type=spark:starfighter_blaster_torpedo,tag=!old] add shot
tag @e[type=spark:starfighter_blaster_torpedo] add old
scoreboard players add @e[type=spark:starfighter_blaster_torpedo] t1 1
kill @e[type=spark:starfighter_blaster_torpedo,scores={t1=200}]

#
execute as @e[type=spark:padme_amidala,family=cargo] run tp @a 1257.50 48.00 7821.5 180 0
execute as @e[type=spark:padme_amidala,family=cargo] run schedule on_area_loaded add 1044 49 1614 969 56 1541 spark/ship_game/cutscene_base
execute as @e[type=spark:padme_amidala,family=cargo] run kill @e[type=spark:padme_amidala,family=cargo]

#
execute as @e[type=spark:naboo_security_officer,family=cargo] run tp @a 1257.50 48.00 7821.5 180 0
execute as @e[type=spark:naboo_security_officer,family=cargo] run schedule on_area_loaded add 1236 47 7801 1281 57 7839 spark/ship_game/cutscene_tutorial

#
execute as @e[family=ship_droid] run function spark/ship_game/droid/loop

#
#execute as @e[x=1000,z=1460,y=60,type=spark:starfighter,rm=400] at @s run title @p title RETURN!
tag @e[x=1265,z=7598,y=60,type=spark:starfighter,rm=650] add bump_return
tag @e[x=1265,z=7598,y=60,type=spark:starfighter,rm=600] add bump_return_2

#
scoreboard players set @a[x=1863,y=60,z=8068,r=110,tag=!ship_area_1] area_fatigue 0
tag @a[x=1863,y=60,z=8068,r=110,tag=!ship_area_1] add ship_area_1

scoreboard players set @a[x=1659,y=60,z=7900,r=110,tag=!ship_area_2] area_fatigue 0
tag @a[x=1659,y=60,z=7900,r=110,tag=!ship_area_2] add ship_area_2

scoreboard players set @a[x=1608,y=60,z=7614,r=110,tag=!ship_area_3] area_fatigue 0
tag @a[x=1608,y=60,z=7614,r=110,tag=!ship_area_3] add ship_area_3

scoreboard players set @a[x=1651,y=60,z=7381,r=110,tag=!ship_area_4] area_fatigue 0
tag @a[x=1651,y=60,z=7381,r=110,tag=!ship_area_4] add ship_area_4

scoreboard players set @a[x=1423,y=60,z=7344,r=180,tag=!ship_area_5] area_fatigue 0
tag @a[x=1423,y=60,z=7344,r=180,tag=!ship_area_5] add ship_area_5

scoreboard players set @a[x=1200,y=70,z=7484,r=120,tag=!ship_area_6] area_fatigue 0
tag @a[x=1200,y=70,z=7484,r=120,tag=!ship_area_6] add ship_area_6

#
scoreboard players add .scene_time ship_game 1
execute if score .state ship_game matches 5 run scoreboard players add .game_time ship_game 1
execute if score .game_time ship_game matches 2400.. run scoreboard players add .state ship_game 1
execute if score .game_time ship_game matches 1800 run tellraw @a {"rawtext":[{"text":"30 Seconds!"}]}
execute if score .game_time ship_game matches 2400.. run tellraw @a {"rawtext":[{"text":"Score: "},{"score":{"name":".value","objective":"ship_score"}}]}
execute if score .game_time ship_game matches 2400.. run tp @a 1257.50 48.00 7821.5 180 0
execute if score .game_time ship_game matches 2400.. run schedule on_area_loaded add 1236 47 7801 1281 57 7839 spark/ship_game/cutscene_return
execute if score .game_time ship_game matches 2400.. run scoreboard players set .game_time ship_game 0

#
execute if score .state ship_game matches 1 if score .scene_time ship_game matches 3 positioned 1257.50 48.00 7806.5 run dialogue change @e[type=spark:naboo_security_officer,c=1] spark:ship_pilot.naboo_guard.1
execute if score .state ship_game matches 6 if score .scene_time ship_game matches 3 positioned 1257.50 48.00 7806.5 run dialogue change @e[type=spark:jar_jar_binks,c=1] spark:ship_pilot.jarjar.1
