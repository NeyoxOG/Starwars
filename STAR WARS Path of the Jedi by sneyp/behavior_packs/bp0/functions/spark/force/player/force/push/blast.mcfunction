#
execute if entity @s[scores={item.charge=30}] at @s positioned ^ ^ ^5 as @e[type=spark:marksman_droid,r=8,tag=!force_proof] run scoreboard players add .force_kills tut_i_counter 1
execute if entity @s[scores={item.charge=30}] at @s as @e[type=spark:marksman_droid,r=9,tag=!force_proof] run kill @s

execute if entity @s[scores={item.charge=30}] at @s run tag @s add push_attacker

function spark/stamina/consume_2
#
tag @s remove use_push

# UNUSED ROAR METHOD
#execute if entity @s[scores={item.charge=40}] at @s run summon spark:force_push ~ ~ ~ 0 0 spark:force_push