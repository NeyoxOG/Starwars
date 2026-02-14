# © Spark Universe, 2023
# authors: ChainsawNinja
# description: main box loop
# called by: loop

#
#execute at @s[tag=solid] run tp @s[rym=-180,ry=-135] ~ ~ ~ -180
#execute at @s[tag=solid] run tp @s[rym=-135,ry=-45] ~ ~ ~ -90
#execute at @s[tag=solid] run tp @s[rym=-45,ry=45] ~ ~ ~ 0
#execute at @s[tag=solid] run tp @s[rym=45,ry=-135] ~ ~ ~ 90
#execute at @s[tag=solid] run tp @s[rym=135,ry=180] ~ ~ ~ 180

#
tag @s[family=off_ground,tag=!solid] add off_ground
tag @s[family=!off_ground,tag=!solid] remove off_ground

#execute as @s[family=off_ground,tag=!off_ground_t] at @s run function spark/force/entity/box/off_ground
execute as @s[family=!off_ground,tag=off_ground_t,tag=!solid,tag=!destroyed] at @s run function spark/force/entity/box/on_ground

tag @s[tag=off_ground,tag=!solid] add off_ground_t
tag @s[tag=!off_ground,tag=!solid] remove off_ground_t

#
execute as @s[tag=size_1,tag=solid,tag=!grabbed,scores={collide_time=..0,check_time=1..}] at @s if block ~ ~ ~ air run tag @s add unsolid
execute as @s[tag=size_2,tag=solid,tag=!grabbed,scores={collide_time=..0,check_time=1..}] at @s if block ~-0.5 ~-0.5 ~-0.5 air if block ~0.5 ~-0.5 ~-0.5 air if block ~-0.5 ~-0.5 ~0.5 air if block ~0.5 ~-0.5 ~0.5 air run tag @s add unsolid
execute as @s[tag=size_2,tag=solid,tag=!grabbed,scores={collide_time=..0,check_time=1..}] at @s if block ~-0.5 ~-0.5 ~-0.5 water if block ~0.5 ~-0.5 ~-0.5 water if block ~-0.5 ~-0.5 ~0.5 water if block ~0.5 ~-0.5 ~0.5 water run tag @s add unsolid
execute as @s[tag=size_3,tag=solid,tag=!grabbed,scores={collide_time=..0,check_time=1..}] at @s if block ~-1.0 ~-0.5 ~-1.0 air if block ~1.0 ~-0.5 ~-1.0 air if block ~-1.0 ~-0.5 ~1.0 air if block ~1.0 ~-0.5 ~1.0 air if block ~ ~-0.5 ~ air if block ~1.0 ~-0.5 ~ air if block ~-1.0 ~-0.5 ~ air if block ~ ~-0.5 ~1.0 air if block ~ ~-0.5 ~-1.0 air run tag @s add unsolid
execute as @s[tag=size_5,tag=solid,tag=!grabbed,scores={collide_time=..0,check_time=1..}] at @s if block ~2.0 ~-0.5 ~1.0 air if block ~2.0 ~-0.5 ~-1.0 air if block ~-2.0 ~-0.5 ~1.0 air if block ~-2.0 ~-0.5 ~-1.0 air if block ~1.0 ~-0.5 ~2.0 air if block ~1.0 ~-0.5 ~-2.0 air if block ~-1.0 ~-0.5 ~2.0 air if block ~1.0 ~-0.5 ~-2.0 air if block ~-2.0 ~-0.5 ~0 air if block ~2.0 ~-0.5 ~0 air if block ~0 ~-0.5 ~-2.0 air if block ~0 ~-0.5 ~2.0 air if block ~-2.0 ~-0.5 ~-2.0 air if block ~2.0 ~-0.5 ~-2.0 air if block ~-2.0 ~-0.5 ~2.0 air if block ~2.0 ~-0.5 ~2.0 air if block ~-1.0 ~-0.5 ~-1.0 air if block ~1.0 ~-0.5 ~-1.0 air if block ~-1.0 ~-0.5 ~1.0 air if block ~1.0 ~-0.5 ~1.0 air if block ~ ~-0.5 ~ air run tag @s add unsolid

execute as @s[scores={check_time=1..}] run kill @e[type=item,name="stick"]

scoreboard players remove @s[scores={check_time=1..}] check_time 1

execute as @s[tag=solid,tag=unsolid] at @s run function spark/force/entity/box/off_ground
execute as @s[tag=solid,tag=unsolid] at @s run function spark/force/entity/box/unsolid

#
scoreboard players add @s[tag=!solid,tag=!grabbed] fall_time 1
scoreboard players reset @s[tag=solid] fall_time

#
effect @s[scores={fall_time=10..}] slow_falling 0

#effect @s slow_falling 10 10 true

#
scoreboard players add @s t2 1
scoreboard players set @s[scores={fall_time=4..}] t2 1
effect @s[scores={fall_time=1,fall_time=9..}] slow_falling 10 10 true
effect @s[scores={fall_time=3}] slow_falling 0

#
#scoreboard players set @e[tag=!solid] force_time 3