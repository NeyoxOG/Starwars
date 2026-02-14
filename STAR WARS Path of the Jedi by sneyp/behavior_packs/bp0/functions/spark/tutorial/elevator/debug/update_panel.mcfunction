execute as @e[type=spark:elevator_button,tag=archives,r=5] at @s run summon spark:elevator_scanbox
execute as @e[type=spark:elevator_button,tag=archives,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add archives
execute as @e[type=spark:elevator_button,tag=dueling,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add dueling
execute as @e[type=spark:elevator_button,tag=council,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add council
execute as @e[type=spark:elevator_button,tag=temple,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add temple
execute as @e[type=spark:elevator_button,tag=crafting,tag=!disabled] at @s run tag @e[type=spark:elevator_scanbox,r=5] add crafting