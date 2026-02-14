# © Spark Universe, 2023
# authors: ChainsawNinja
# description: main game function
# called by: tick.json

#
kill @e[tag=kill]

#
tag @e[family=force] remove push_target_effect

#
execute as @a at @s run function spark/force/player/loop

#
event entity @e[tag=push_target_effect,tag=!push_effect_temp] spark:set_force_effect_push
event entity @e[tag=!push_target_effect,tag=push_effect_temp] spark:set_force_effect_none

tag @e[tag=push_target_effect] add push_effect_temp
tag @e[family=force,tag=!push_target_effect] remove push_effect_temp

tag @e[tag=push_target_effect] remove push_target_effect

# execute on all types
# including puzzle entities
execute as @e[tag=force_cube,tag=!kill] at @s run function spark/force/entity/box/loop

# loop to make sure blocks are removed using a marker
execute as @e[type=spark:marker,tag=force_blocks_marker] at @s run function spark/force/entity/box/marker_loop

# execute as @e[type=spark:aurebesh_obstacle_m,tag=!kill] at @s run function spark/force/entity/box/loop
# execute as @e[type=spark:conductor_obstacle_m,tag=!kill] at @s run function spark/force/entity/box/loop
# execute as @e[type=spark:conductor_obstacle_s,tag=!kill] at @s run function spark/force/entity/box/loop
# execute as @e[type=spark:torren_obstacle_l,tag=!kill] at @s run function spark/force/entity/box/loop
# execute as @e[type=spark:torren_obstacle_m,tag=!kill] at @s run function spark/force/entity/box/loop
# execute as @e[type=spark:torren_obstacle_s,tag=!kill] at @s run function spark/force/entity/box/loop

#
scoreboard players add @e[family=force] force_time 0
scoreboard players remove @e[family=force,scores={force_time=0..}] force_time 1
scoreboard players set @e[family=force,scores={force_time=..0}] ID.attacker 0

# COLLIDE DETECTION
# VERY BETA
scoreboard players add @e[family=force] collide_time 0
execute as @e[scores={collide_time=1..},type=spark:box] at @s positioned ~ ~-1.5 ~ if entity @e[family=break_box,r=4] run function spark/force/entity/box/entity_hit
execute as @e[scores={collide_time=1..},type=spark:box] at @s positioned ~ ~-1.5 ~ if entity @e[family=monster_boss,r=6] run function spark/force/entity/box/boss_hit
execute as @e[scores={collide_time=1..}] at @s positioned ~ ~-1.5 ~ if entity @e[family=force,scores={collide_time=..0},r=3,tag=!solid] run summon spark:force_push ~ ~ ~ 0 0 spark:force_push
execute as @e[scores={collide_time=1..}] at @s positioned ~ ~-1.5 ~ if entity @e[family=force,scores={collide_time=..0},r=3,tag=!solid] run scoreboard players set @s collide_time 0
scoreboard players remove @e[scores={collide_time=0..}] collide_time 1

# temp code
# HIGHLIGHTS INSIGHT MARKERS FOR DEV
execute as @e[type=bat] at @s run function spark/force/entity/insight_mark/spawn
execute as @e[tag=insight_mark] at @s run particle spark:force_guide ~ ~1 ~

#
execute as @e[tag=insight_mark,tag=!new] at @s run function spark/force/entity/insight_mark/new

#
execute as @e[tag=insight] at @s run function spark/force/entity/insight/loop

#
#tp @e[tag=kill,type=!spark:marker_box] ~ ~-10000 ~