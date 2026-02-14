

# execute if score .timer dueling_story matches 41 as @a[r=50] at @s run title @a actionbar hud:fade_in_1
# execute if score .timer dueling_story matches 61 as @a[r=50] at @s run playsound sound.spark.transitioner_fade_general @s
# execute if score .timer dueling_story matches 61 run music stop 4.0
# execute if score .timer dueling_story matches 81 as @a[r=50] at @s run playsound sound.spark.quest_major @s

# execute if score .timer dueling_story matches 101 run playsound random.levelup @a[r=50]

# execute if score .timer dueling_story matches 141 run event entity @s spark:activate_ring
# execute if score .timer dueling_story matches 141 as @a[r=50] run function spark/dueling/instance/init_round

#Wait for player to stand in circle for 3 second in one go (resets counter when they leave)
scoreboard players add ".circle_timer" dueling_story 0
execute if score ".circle_timer" dueling_story matches 62.. run scoreboard players add ".circle_timer" dueling_story 1
execute positioned ~7 ~ ~ if entity @a[r=2] if score ".circle_timer" dueling_story matches ..61 run scoreboard players add ".circle_timer" dueling_story 1
# execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 1.. unless entity @a[r=2] run titleraw @a[r=10] actionbar { "rawtext": [ { "text": " " }]}
execute positioned ~7 ~ ~ unless entity @a[r=2] if score ".circle_timer" dueling_story matches ..61 run event entity @s spark:deactivate_ring
execute positioned ~7 ~ ~ unless entity @a[r=2] if score ".circle_timer" dueling_story matches ..61 run scoreboard players set ".circle_timer" dueling_story 0
# execute as @a[r=50] unless score ".circle_timer" dueling_story matches 1.. run scoreboard players set @s SS_ui_tutorial 21
# execute as @a[r=50] if score ".circle_timer" dueling_story matches 1.. run scoreboard players set @s SS_ui_tutorial 0

execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 1 as @a at @s run playsound sound.spark.duel_circle_enter @s
execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 1 run event entity @s spark:activate_ring

execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 1 as @a at @s run playsound sound.spark.duel_counter @s
# execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 1 as @a at @s run titleraw @s actionbar { "rawtext": [ { "translate": "The Duel starts in: " }, { "text": "3" }]}
#TODO proper translate text here --------------------------------------------------------------------------------------------------------------------------------^

execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 21 as @a at @s run playsound sound.spark.duel_counter @s
# execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 21 as @a at @s run titleraw @s actionbar { "rawtext": [ { "translate": "The Duel starts in: " }, { "text": "2" }]}
#TODO proper translate text here --------------------------------------------------------------------------------------------------------------------------------^

execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 41 as @a at @s run playsound sound.spark.duel_counter @s
# execute positioned ~7 ~ ~ if score ".circle_timer" dueling_story matches 41 as @a at @s run titleraw @s actionbar { "rawtext": [ { "translate": "The Duel starts in: " }, { "text": "1" }]}
#TODO proper translate text here --------------------------------------------------------------------------------------------------------------------------------^

# the player has been in the circle for 3 seconds, start the duel sequence
execute if score ".circle_timer" dueling_story matches 62 run title @a actionbar hud:fade_out_1
execute if score ".circle_timer" dueling_story matches 62 run playsound sound.spark.transitioner_fade_general @a
execute if score ".circle_timer" dueling_story matches 82 run tag @e[type=spark:astromech,tag=!npc] add no_tp

# execute if score ".circle_timer" dueling_story matches 82 run function spark/dueling/setup_instances
execute if score ".circle_timer" dueling_story matches 82 at @s run function spark/dueling/place_cutscene_duelist
execute if score ".circle_timer" dueling_story matches 82 run title @a actionbar hud:blackbars_in
execute if score ".circle_timer" dueling_story matches 81 run scoreboard players set cutscene dueling_story 0

execute if score ".circle_timer" dueling_story matches 82..182 run function spark/dueling/cutscene/tick

execute if score ".circle_timer" dueling_story matches 162 run title @a actionbar hud:blackbars_out
execute if score ".circle_timer" dueling_story matches 162 run playsound sound.spark.transitioner_fade_general @a
execute if score ".circle_timer" dueling_story matches 182 run tag @e[type=spark:astromech,tag=!npc] add no_tp
execute if score ".circle_timer" dueling_story matches 181 positioned 8982.01 22.00 8975.54 run event entity @e[family=duel_opponent,r=4] spark:despawn
execute if score ".circle_timer" dueling_story matches 181 run function spark/dueling/setup_instances
execute if score ".circle_timer" dueling_story matches 181 run title @a actionbar hud:fade_in_1

execute if score ".circle_timer" dueling_story matches 201 as @a at @s as @e[type=spark:duel_force_field,r=50] at @s run function spark/dueling/instance/start_fight
execute if score ".circle_timer" dueling_story matches 202 run scoreboard players set ".circle_timer" dueling_story 0