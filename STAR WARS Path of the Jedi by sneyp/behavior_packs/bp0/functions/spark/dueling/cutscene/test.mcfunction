#execute if score @s dueling_story matches 1 run say TODO play cutscene ch06_c01 (opponent intro cutscene)
execute if score @s dueling_story matches 1 as @p at @s run playsound sound.spark.cutscene_jedi_duel_start @s

execute if score @s dueling_story matches 21 run function spark/dueling/cutscene/end