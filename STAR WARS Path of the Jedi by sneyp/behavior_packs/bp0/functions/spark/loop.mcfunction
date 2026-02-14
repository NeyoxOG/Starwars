# © Spark Universe, 2023
# authors: Jannis
# description: Game loop, runs 20 times a second
# called by: tick.json

scoreboard players add @a player_id 0
execute as @a if score @s player_id matches 0 run function spark/assign_id

function spark/companion/loop

function spark/tutorial/loop

# function spark/ui/loop

execute if score .cs_trigger CS_trigger matches 1 run function spark/cutscene/loop

# Slightly slower loop
scoreboard players add slow2 SS_time 1
execute if score slow2 SS_time matches 2.. run function spark/loop2

# Slow loop
scoreboard players add slow SS_time 1
execute as @a[c=1] if score slow SS_time matches 20.. run function spark/loop20
execute as @a[c=1] if score slow SS_time matches 9 run function spark/particles/loop20

# double jump
scoreboard players remove @a[scores={double_jump=1..}] double_jump 1
effect @a[scores={double_jump=1}] slow_falling 0

# above head marker
execute as @e[tag=has_quest,tag=very_tall] at @s run particle spark:npc_exclamation ~ ~3.8 ~
execute as @e[tag=has_quest,tag=tall] at @s run particle spark:npc_exclamation ~ ~3.0 ~
execute as @e[tag=has_quest,tag=short] at @s run particle spark:npc_exclamation ~ ~2.2 ~
execute as @e[tag=has_quest,tag=!very_tall,tag=!tall,tag=!short] at @s run particle spark:npc_exclamation ~ ~2.5 ~

# sync skyboxes by nearby players
execute as @a at @s if entity @p[rm=0.1,r=8] run event entity @s spark:other_players_nearby
execute as @a at @s unless entity @p[rm=0.1,r=8.01] run event entity @s spark:no_players_nearby

# ship game
# function spark/ship_game/loop

# dueling
function spark/dueling/loop

# droid_survival
function spark/droid_survival/main

#monster battle
function spark/monster_battle/loop

# escape
execute as @e[type=spark:torren_dripleaf] at @s run function spark/puzzle/dripleaf/loop

# escape
execute as @e[type=spark:general_grievous,tag=lawnmower_move] at @s run function spark/escape/grievous_lawnmower

#force
execute as @a at @s run function spark/force/loop

# stamina
scoreboard players operation slow SS_temp = slow SS_time
scoreboard players operation slow SS_temp %= _3 SS_const
execute if score slow SS_temp matches 1 as @a[scores={stamina_cooldown=0}] if score @s stamina < .max hotbar_stamina_size run function spark/stamina/recharge
scoreboard players remove @a[scores={stamina_cooldown=1..}] stamina_cooldown 1
