# Fast-forward the tutorial state to chapter 4 hub phase

function spark/setup
scoreboard players set .state tutorial 4
scoreboard players set .substate tutorial 0
scoreboard players set .timer tutorial 0

function warp/council

tellraw @s {"rawtext":[{"text":"§d[Custom] Tutorial auf Kapitel 4 gesetzt."}]}
