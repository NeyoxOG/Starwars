# © Spark Universe, 2023
# authors: destruc7i0n
# description: check if there is no other pet nearby and then save
# called by: 

tag @s add self_pet
scoreboard players set .nearby_count pet_load 0
execute as @e[family=companion,r=1.5,tag=!self_pet] run scoreboard players add .nearby_count pet_load 1
tag @s remove self_pet

execute if score .nearby_count pet_load matches 0 run function spark/companion/save/do_save_structure
# try again next tick if there is a pet nearby
execute if score .nearby_count pet_load matches 1.. run function spark/companion/save/queue_save

scoreboard players reset .nearby_count pet_load
