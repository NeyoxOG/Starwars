#
#effect @e[family=force,r=5,scores={force_time=..40,ID.attacker=0}] levitation 2 0 true
#scoreboard players set @e[family=force,r=5,scores={ID.attacker=0}] force_time 45
#scoreboard players operation @e[family=force,r=5,scores={ID.attacker=0}] ID.attacker = @s ID

#
execute positioned ^ ^ ^5 run tag @e[family=force,r=8,tag=!kill] add push_target_effect
execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove push_target_effect

#
execute unless score .phase .monster_battle matches 7 if entity @s[scores={item.charge=30}] at @s run function spark/force/player/force/push/blast
