#
scoreboard players add .timer .monster_battle 1
function spark/monster_battle/phase/loop

#
execute as @e[family=monster_boss] at @s run function spark/monster_battle/boss/loop