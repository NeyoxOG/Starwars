# © Spark Universe, 2023
# authors: ChainsawNinja
# description: running grab force event
# called by: item/use/loop

# find target object
scoreboard players operation @e[family=force] ID.attacker -= @s ID

scoreboard players set @e[scores={ID.attacker=0}] force_time 10

execute if entity @s[scores={item.charge=1}] as @e[tag=size_1,scores={ID.attacker=0}] at @s run event entity @s spark:size_1_forced
execute if entity @s[scores={item.charge=1}] as @e[tag=size_2,scores={ID.attacker=0}] at @s run event entity @s spark:size_2_forced
execute if entity @s[scores={item.charge=1}] as @e[tag=size_3,scores={ID.attacker=0}] at @s run event entity @s spark:size_3_forced
execute if entity @s[scores={item.charge=1}] as @e[tag=size_5,scores={ID.attacker=0}] at @s run event entity @s spark:size_5_forced

#
#tag @e remove entity_grabbed
#tag @e[family=force,scores={ID.attacker=0},c=1] add entity_grabbed

#
#tag @s remove size_0_grab
#tag @s remove size_1_grab
#tag @s remove size_2_grab
#tag @s remove size_3_grab

#execute if entity @e[tag=entity_grabbed,family=enemy] run tag @s add size_0_grab
#execute if entity @e[tag=entity_grabbed,tag=force_cube,tag=size_1] run tag @s add size_0_grab
#execute if entity @e[tag=entity_grabbed,tag=force_cube,tag=size_2] run tag @s add size_1_grab
#execute if entity @e[tag=entity_grabbed,tag=force_cube,tag=size_3] run tag @s add size_2_grab
#execute if entity @e[tag=entity_grabbed,tag=force_cube,tag=size_5] run tag @s add size_3_grab

# reun hitscan to get destination location
#execute at @s run function spark/force/player/hitscan/execute

# create box object for teleport hitbox detection
#execute as @e[tag=entity_grabbed,family=enemy] at @s run summon spark:marker_box
#execute as @e[tag=entity_grabbed,tag=force_cube,tag=size_5] at @s run summon spark:marker_box ~ ~ ~ 0 0 spark:size_5
#execute as @e[tag=entity_grabbed,tag=force_cube,tag=size_3] at @s run summon spark:marker_box ~ ~ ~ 0 0 spark:size_3
#execute as @e[tag=entity_grabbed,tag=force_cube,tag=size_2] at @s run summon spark:marker_box ~ ~ ~ 0 0 spark:size_2
#execute as @e[tag=entity_grabbed,tag=force_cube,tag=size_1] at @s run summon spark:marker_box ~ ~ ~ 0 0 spark:size_1

#tag @e remove tele_box
#execute as @e[tag=entity_grabbed] at @s run tag @e[type=spark:marker_box,c=1,tag=!kill] add tele_box

# move towards destination marker (box entity)
#water
#execute at @s[tag=tele_box] if block ~ ~ ~ water run tp ~ ~0.2 ~ facing @p
#execute at @s[tag=tele_box] if block ~ ~ ~ water run tag @s remove tele_box

#execute as @e[tag=tele_box] at @s run function spark/force/player/force/grab/tele_box_move

# correct IDs
scoreboard players operation @e[family=force] ID.attacker += @s ID

#
#execute if entity @s[scores={item.charge=60}] at @s run function spark/force/player/force/grab/end