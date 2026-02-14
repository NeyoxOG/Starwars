# © Spark Universe, 2023
# authors: destruc7i0n
# description: Attempt to load the structure containing the pet
# called by: companion/checks/pet_check, by the player

execute if score @s player_id matches 1 positioned ~ ~ ~ run structure load spark:pet_player_1 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 2 positioned ~ ~ ~ run structure load spark:pet_player_2 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 3 positioned ~ ~ ~ run structure load spark:pet_player_3 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 4 positioned ~ ~ ~ run structure load spark:pet_player_4 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 5 positioned ~ ~ ~ run structure load spark:pet_player_5 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 6 positioned ~ ~ ~ run structure load spark:pet_player_6 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 7 positioned ~ ~ ~ run structure load spark:pet_player_7 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 8 positioned ~ ~ ~ run structure load spark:pet_player_8 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 9 positioned ~ ~ ~ run structure load spark:pet_player_9 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 10 positioned ~ ~ ~ run structure load spark:pet_player_10 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 11 positioned ~ ~ ~ run structure load spark:pet_player_11 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 12 positioned ~ ~ ~ run structure load spark:pet_player_12 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 13 positioned ~ ~ ~ run structure load spark:pet_player_13 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 14 positioned ~ ~ ~ run structure load spark:pet_player_14 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 15 positioned ~ ~ ~ run structure load spark:pet_player_15 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 16 positioned ~ ~ ~ run structure load spark:pet_player_16 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 17 positioned ~ ~ ~ run structure load spark:pet_player_17 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 18 positioned ~ ~ ~ run structure load spark:pet_player_18 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 19 positioned ~ ~ ~ run structure load spark:pet_player_19 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 20 positioned ~ ~ ~ run structure load spark:pet_player_20 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 21 positioned ~ ~ ~ run structure load spark:pet_player_21 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 22 positioned ~ ~ ~ run structure load spark:pet_player_22 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 23 positioned ~ ~ ~ run structure load spark:pet_player_23 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 24 positioned ~ ~ ~ run structure load spark:pet_player_24 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 25 positioned ~ ~ ~ run structure load spark:pet_player_25 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 26 positioned ~ ~ ~ run structure load spark:pet_player_26 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 27 positioned ~ ~ ~ run structure load spark:pet_player_27 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 28 positioned ~ ~ ~ run structure load spark:pet_player_28 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 29 positioned ~ ~ ~ run structure load spark:pet_player_29 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 30 positioned ~ ~ ~ run structure load spark:pet_player_30 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 31 positioned ~ ~ ~ run structure load spark:pet_player_31 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 32 positioned ~ ~ ~ run structure load spark:pet_player_32 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 33 positioned ~ ~ ~ run structure load spark:pet_player_33 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 34 positioned ~ ~ ~ run structure load spark:pet_player_34 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 35 positioned ~ ~ ~ run structure load spark:pet_player_35 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 36 positioned ~ ~ ~ run structure load spark:pet_player_36 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 37 positioned ~ ~ ~ run structure load spark:pet_player_37 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 38 positioned ~ ~ ~ run structure load spark:pet_player_38 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 39 positioned ~ ~ ~ run structure load spark:pet_player_39 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 40 positioned ~ ~ ~ run structure load spark:pet_player_40 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 41 positioned ~ ~ ~ run structure load spark:pet_player_41 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 42 positioned ~ ~ ~ run structure load spark:pet_player_42 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 43 positioned ~ ~ ~ run structure load spark:pet_player_43 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 44 positioned ~ ~ ~ run structure load spark:pet_player_44 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 45 positioned ~ ~ ~ run structure load spark:pet_player_45 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 46 positioned ~ ~ ~ run structure load spark:pet_player_46 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 47 positioned ~ ~ ~ run structure load spark:pet_player_47 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 48 positioned ~ ~ ~ run structure load spark:pet_player_48 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 49 positioned ~ ~ ~ run structure load spark:pet_player_49 ~ ~ ~ 0_degrees none true false false
execute if score @s player_id matches 50 positioned ~ ~ ~ run structure load spark:pet_player_50 ~ ~ ~ 0_degrees none true false false

tag @e[family=companion,c=1,tag=tamed,tag=saved] add loaded_pet
tag @e[tag=loaded_pet] remove saved

# copy the pet id to the new entity (scores are not saved)
scoreboard players operation @e[tag=loaded_pet] pet_id = @s player_id
tag @e[tag=loaded_pet] add player_pet
event entity @e[tag=loaded_pet] spark:mobile

tag @e[tag=loaded_pet] remove loaded_pet
