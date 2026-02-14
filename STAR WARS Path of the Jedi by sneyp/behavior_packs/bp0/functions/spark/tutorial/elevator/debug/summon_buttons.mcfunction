summon spark:elevator_button ^ ^3.0 ^4.2 facing @p spark:council
summon spark:elevator_button ^ ^2.625 ^4.2 facing @p spark:dueling
summon spark:elevator_button ^ ^2.25 ^4.2 facing @p spark:crafting
summon spark:elevator_button ^ ^1.875 ^4.2 facing @p spark:temple
summon spark:elevator_button ^ ^1.5 ^4.2 facing @p spark:archives

execute positioned ^ ^3.0 ^4.2 run tag @e[type=spark:elevator_button,c=1] add council
execute positioned ^ ^2.625 ^4.2 run tag @e[type=spark:elevator_button,c=1] add dueling
execute positioned ^ ^2.25 ^4.2 run tag @e[type=spark:elevator_button,c=1] add crafting
execute positioned ^ ^1.875 ^4.2 run tag @e[type=spark:elevator_button,c=1] add temple
execute positioned ^ ^1.5 ^4.2 run tag @e[type=spark:elevator_button,c=1] add archives


execute positioned ^ ^1.6 ^4.2 as @e[type=spark:elevator_button,r=5] at @s if entity @s[rym=-45,ry=45] run tp @s ~ ~ ~ 0 0
execute positioned ^ ^1.6 ^4.2 as @e[type=spark:elevator_button,r=5] at @s if entity @s[rym=45,ry=135] run tp @s ~ ~ ~ 90 0
execute positioned ^ ^1.6 ^4.2 as @e[type=spark:elevator_button,r=5] at @s if entity @s[rym=135,ry=-135] run tp @s ~ ~ ~ 180 0 
execute positioned ^ ^1.6 ^4.2 as @e[type=spark:elevator_button,r=5] at @s if entity @s[rym=-135,ry=-45] run tp @s ~ ~ ~ -90 0

execute as @e[type=spark:elevator_button,tag=archives,r=5] at @s run summon spark:elevator_scanbox
execute as @e[type=spark:elevator_button,tag=archives,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add archives
execute as @e[type=spark:elevator_button,tag=dueling,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add dueling
execute as @e[type=spark:elevator_button,tag=council,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add council
execute as @e[type=spark:elevator_button,tag=temple,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add temple
execute as @e[type=spark:elevator_button,tag=crafting,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add crafting