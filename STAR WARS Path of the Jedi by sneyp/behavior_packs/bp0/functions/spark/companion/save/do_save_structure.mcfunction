# © Spark Universe, 2023
# authors: destruc7i0n
# description: prep and save the pet structure
# called by: ./do_save

# tellraw @a[tag=debug] {"rawtext":[{"text":"§7§oPet has been saved at "}, {"score":{"name":"slow","objective":"SS_time"}}]}

tag @s remove pet_save
tag @s add saved

# save the structure
execute if score @s pet_id matches 1 at @s run structure save spark:pet_player_1 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 2 at @s run structure save spark:pet_player_2 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 3 at @s run structure save spark:pet_player_3 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 4 at @s run structure save spark:pet_player_4 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 5 at @s run structure save spark:pet_player_5 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 6 at @s run structure save spark:pet_player_6 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 7 at @s run structure save spark:pet_player_7 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 8 at @s run structure save spark:pet_player_8 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 9 at @s run structure save spark:pet_player_9 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 10 at @s run structure save spark:pet_player_10 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 11 at @s run structure save spark:pet_player_11 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 12 at @s run structure save spark:pet_player_12 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 13 at @s run structure save spark:pet_player_13 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 14 at @s run structure save spark:pet_player_14 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 15 at @s run structure save spark:pet_player_15 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 16 at @s run structure save spark:pet_player_16 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 17 at @s run structure save spark:pet_player_17 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 18 at @s run structure save spark:pet_player_18 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 19 at @s run structure save spark:pet_player_19 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 20 at @s run structure save spark:pet_player_20 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 21 at @s run structure save spark:pet_player_21 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 22 at @s run structure save spark:pet_player_22 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 23 at @s run structure save spark:pet_player_23 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 24 at @s run structure save spark:pet_player_24 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 25 at @s run structure save spark:pet_player_25 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 26 at @s run structure save spark:pet_player_26 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 27 at @s run structure save spark:pet_player_27 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 28 at @s run structure save spark:pet_player_28 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 29 at @s run structure save spark:pet_player_29 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 30 at @s run structure save spark:pet_player_30 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 31 at @s run structure save spark:pet_player_31 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 32 at @s run structure save spark:pet_player_32 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 33 at @s run structure save spark:pet_player_33 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 34 at @s run structure save spark:pet_player_34 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 35 at @s run structure save spark:pet_player_35 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 36 at @s run structure save spark:pet_player_36 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 37 at @s run structure save spark:pet_player_37 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 38 at @s run structure save spark:pet_player_38 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 39 at @s run structure save spark:pet_player_39 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 40 at @s run structure save spark:pet_player_40 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 41 at @s run structure save spark:pet_player_41 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 42 at @s run structure save spark:pet_player_42 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 43 at @s run structure save spark:pet_player_43 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 44 at @s run structure save spark:pet_player_44 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 45 at @s run structure save spark:pet_player_45 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 46 at @s run structure save spark:pet_player_46 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 47 at @s run structure save spark:pet_player_47 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 48 at @s run structure save spark:pet_player_48 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 49 at @s run structure save spark:pet_player_49 ~ ~ ~ ~ ~ ~ true disk false
execute if score @s pet_id matches 50 at @s run structure save spark:pet_player_50 ~ ~ ~ ~ ~ ~ true disk false

# despawn the pet
event entity @s spark:despawn
