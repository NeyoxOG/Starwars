execute if score .timer tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:time_skip:" },{"translate":"intro.text_card.time_skip", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 0 as @a at @s run playsound sound.spark.timeskip_card @s
execute if score .timer tutorial matches 40 run time set 1000

execute if score .timer tutorial matches 490 run function spark/tutorial/next

#execute if score .timer tutorial matches 20 run say TODO: Add crucible behind players
#execute if score .timer tutorial matches 40 run music stop 1.0 
#execute if score .timer tutorial matches 40 run music play sound.spark.music_departing_coruscant 1.0 0.1
#execute if score .timer tutorial matches 40 run music queue sound.spark.ambience_coruscant 1.0 0.1 loop
#execute if score .timer tutorial matches 40 as @a at @s run playsound sound.spark.transitioner_front_of_ship @s
#execute if score .timer tutorial matches 40 run title @a actionbar hud:fade_in_1
#execute if score .timer tutorial matches 60 run function spark/tutorial/next
