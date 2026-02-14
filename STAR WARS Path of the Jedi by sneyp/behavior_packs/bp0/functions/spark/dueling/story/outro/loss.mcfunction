#Stop music if no other players are fighting
# execute if score @s dueling_story matches 1 run title @a[r=50] actionbar hud:fade_out_1
# execute if score @s dueling_story matches 1 run say story/outro/loss title @a[r=50] actionbar hud:fade_out_1
execute if score @s dueling_story matches 1 run titleraw @a[r=50] actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"lightsaber_dueling.announcement.lost.announcement1", "with": { "rawtext": [ { "selector": "@e[family=duel_opponent,tag=!sitting,c=1]" }] } }]}
execute if score @s dueling_story matches 1 run event entity @e[family=duel_opponent,r=50,tag=!sitting] set_move_won
# execute if score @s dueling_story matches 1 run playsound sound.spark.duel_loss @a[r=50]
execute if score @s dueling_story matches 21 run tag @a[r=50] add temp
execute if score @s dueling_story matches 21 unless entity @a[tag=!waiting,tag=!temp] run music stop 0.1
execute if score @s dueling_story matches 21 run tag @a[r=50] remove temp
execute if score @s dueling_story matches 81 run tag @a[r=50] add waiting

# execute if score @s dueling_story matches 20 run event entity @e[family=duel_opponent,r=50,tag=!sitting] spark:despawn
# execute if score @s dueling_story matches 20 run effect @e[tag=sitting,r=50] clear
# execute if score @s dueling_story matches 21 run title @a[r=50] actionbar hud:fade_in_1
# execute if score @s dueling_story matches 21 run say story/outro/loss title @a[r=50] actionbar hud:fade_in_1
# scoreboard players add @s dueling_story 1



# execute if score @s dueling_story matches 21 run event entity @s spark:despawn
# say ran loss as @s