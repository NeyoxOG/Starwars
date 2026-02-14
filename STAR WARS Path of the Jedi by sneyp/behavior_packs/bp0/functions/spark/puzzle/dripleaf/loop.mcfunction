# tag @s add me
scoreboard players set .player_count lv_puzzle_level 0
#

# execute if score slow SS_time matches 9 as @s[tag=closed] positioned ^ ^ ^2 unless block ~ ~-1 ~ spark:door_box_collision run fill ^1 ^-1 ^4 ^-1 ^-1 ^ spark:door_box_collision replace air
# execute if score slow SS_time matches 9 as @s[tag=closed] positioned ^ ^ ^2 unless block ~ ~-1 ~ spark:door_box_collision run fill ^ ^-1 ^5 ^ ^-1 ^ spark:door_box_collision replace air

#
execute positioned ^ ^ ^3 as @a[r=3] at @s if block ~ ~-0.1 ~ spark:door_box_collision run scoreboard players add .player_count lv_puzzle_level 1
execute positioned ^ ^ ^2 as @a[r=3] at @s if block ~ ~-0.1 ~ spark:door_box_collision run scoreboard players add .player_count lv_puzzle_level 1
# execute as @s[tag=closed] positioned ^ ^ ^3 as @a[r=3] at @s if block ~ ~-0.1 ~ spark:door_box_collision run tag @e[tag=me] remove closed

#
# execute as @s[tag=closed] positioned ^ ^ ^2 as @a[r=3] at @s if block ~ ~-0.1 ~ spark:door_box_collision run event entity @e[tag=me] spark:start_react
# execute as @s[tag=closed] positioned ^ ^ ^2 as @a[r=3] at @s if block ~ ~-0.1 ~ spark:door_box_collision run tag @e[tag=me] remove closed

execute if score .player_count lv_puzzle_level matches 1.. if entity @s[tag=closed] run event entity @s spark:start_react
execute if score .player_count lv_puzzle_level matches 1.. if entity @s[tag=closed] run tag @s remove closed

execute if score .player_count lv_puzzle_level matches 0 if entity @s[tag=!closed] run event entity @s spark:end_react
execute if score .player_count lv_puzzle_level matches 0 if entity @s[tag=!closed] run tag @s add closed

# tag @s remove me