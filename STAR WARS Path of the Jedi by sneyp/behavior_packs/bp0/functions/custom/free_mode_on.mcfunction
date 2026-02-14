# Enables a safer free-play sandbox mode

function spark/setup

gamerule keepinventory true
gamerule falldamage false
gamerule sendcommandfeedback true
gamerule showcoordinates true

tag @s add started
tag @s remove hide_ui
tag @s remove hide_hotbar

scoreboard players set .state tutorial 4
scoreboard players set .substate tutorial 0
scoreboard players set .timer tutorial 0

tellraw @s {"rawtext":[{"text":"§a[Custom] Free-Mode aktiviert."}]}
