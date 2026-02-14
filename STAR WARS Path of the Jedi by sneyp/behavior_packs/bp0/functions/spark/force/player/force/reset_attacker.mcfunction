#
tag @e[family=force] remove attacker_reset

#
scoreboard players operation @e[family=force] ID.attacker -= @s ID

tag @e[family=force,scores={ID.attacker=0}] add attacker_reset

scoreboard players operation @e[family=force] ID.attacker += @s ID

#
scoreboard players set @e[family=force,tag=attacker_reset] ID.attacker 0