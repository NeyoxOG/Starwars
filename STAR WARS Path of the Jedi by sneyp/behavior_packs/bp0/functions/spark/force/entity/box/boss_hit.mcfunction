damage @e[family=monster_boss,r=6,scores={t1=2..}] 65
scoreboard players set @e[family=monster_boss,r=6] t1 0
event entity @e[family=monster_boss,r=6] spark:stun
scoreboard players set .monster_stun .monster_battle 115

tag @s add destroyed
event entity @s spark:break