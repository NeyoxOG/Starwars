# © Spark Universe, 2023
# authors: ChainsawNinja
# description: end grab force event
# called by: grab/loop

# FOV toggle
#event entity @s spark:force_speed_end

# find enemy that was grabbed and reset
scoreboard players operation @e[family=force] ID.attacker -= @s ID

# execute as @e[type=spark:box,scores={ID.attacker=0}] at @s run function spark/force/entity/box/unsolid
execute as @e[tag=force_cube,scores={ID.attacker=0}] at @s run function spark/force/entity/box/unsolid

tag @e[family=force,scores={ID.attacker=0},tag=!kill] add grab_end

tag @e[family=force,scores={ID.attacker=0}] remove grabbed
tag @e[family=force,scores={ID.attacker=0}] remove grab_current

scoreboard players set @e[family=force,scores={ID.attacker=0}] force_time 8
effect @e[family=force,scores={ID.attacker=0}] levitation 0
event entity @e[family=force,scores={ID.attacker=0}] spark:set_force_effect_none

scoreboard players operation @e[family=force] ID.attacker += @s ID

#execute as @e[tag=scan_marker,c=1] at @s run function spark/force/player/force/grab/grab_dir

# remove tags
event entity @s spark:set_using_force_off
tag @s remove grab_success
tag @s remove grab_user