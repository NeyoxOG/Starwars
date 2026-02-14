#
#scoreboard players operation @e[family=force] ID.attacker -= @s ID

#scoreboard players set @e[family=force,scores={ID.attacker=0}] force_time 8
#effect @e[family=force,scores={ID.attacker=0}] levitation 0
#event entity @e[family=force,scores={ID.attacker=0}] spark:set_force_effect_none

#scoreboard players operation @e[family=force] ID.attacker += @s ID

function spark/stamina/consume_1

#
event entity @s spark:set_using_force_off
tag @s remove use_push

#
execute if entity @s[scores={item.charge=4..9}] at @s run tag @s add push_attacker
execute if entity @s[scores={item.charge=4..9}] at @s run tag @s add weak_3
execute if entity @s[scores={item.charge=10..19}] at @s run tag @s add push_attacker
execute if entity @s[scores={item.charge=10..19}] at @s run tag @s add weak_2
execute if entity @s[scores={item.charge=20..29}] at @s run tag @s add push_attacker
execute if entity @s[scores={item.charge=20..29}] at @s run tag @s add weak_1