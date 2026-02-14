# Unlocks broad progression-related states for free-play testing

function spark/setup

scoreboard players set .state tutorial 10
scoreboard players set .substate tutorial 0
scoreboard players set .timer tutorial 0
scoreboard players set .npc_trigger tutorial 0

scoreboard players set @s SS_ui_tutorial 0
scoreboard players set @s SS_ui_task 0

tag @s add started
tag @s remove hide_ui
tag @s remove hide_hotbar

clear @s
effect @s saturation 120 1 true
effect @s night_vision 3600 0 true

tellraw @s {"rawtext":[{"text":"§a[Custom] Alles freigeschaltet (Free-Play Zustand aktiv)."}]}
