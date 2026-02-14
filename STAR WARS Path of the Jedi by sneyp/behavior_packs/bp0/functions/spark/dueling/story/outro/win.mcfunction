execute if score @s dueling_story matches 1 run tag @a[r=50] add duel_win
execute if score @s dueling_story matches 21 run tag @a[r=50] add temp
execute if score @s dueling_story matches 21 unless entity @a[tag=!waiting,tag=!temp] run music stop 0.1
execute if score @s dueling_story matches 21 run tag @a[r=50] remove temp
execute if score @s dueling_story matches 81 run tag @a[r=50] add waiting
# execute if score @s dueling_story matches 43 run tp @a[r=50] 9007.5 22 8975.5 90 0
# scoreboard players add @s dueling_story 1
# execute if score @s dueling_story matches 1.. run tellraw @a { "rawtext": [ { "score": {"name": "@s", "objective": "dueling_story" } }] }
