#
scoreboard players operation @e[family=force] ID.attacker -= @s ID

tag @e[family=force,scores={ID.attacker=0}] remove grabbed

scoreboard players set @e[family=force,scores={ID.attacker=0}] force_time 8
effect @e[family=force,scores={ID.attacker=0}] levitation 0
event entity @e[family=force,scores={ID.attacker=0}] spark:set_force_effect_none

scoreboard players operation @e[family=force] ID.attacker += @s ID

function spark/stamina/consume_1
event entity @s spark:set_using_force_off
