#
scoreboard players operation @e[family=force] ID.attacker -= @s ID

execute as @e[type=spark:marksman_droid,scores={ID.attacker=0},tag=!force_proof] run scoreboard players add .force_kills tut_i_counter 1
execute as @e[type=spark:marksman_droid,scores={ID.attacker=0},tag=!force_proof] run kill @s

tag @e[family=force,scores={ID.attacker=0}] add grabbed_prev
tag @e[family=force,scores={ID.attacker=0}] remove grabbed

effect @e[family=force,scores={ID.attacker=0}] levitation 0

scoreboard players operation @e[family=force] ID.attacker += @s ID

function spark/stamina/consume_2

#
tag @s remove use_pull



#
tag @s add pull_attacker
tag @s add weak_1
