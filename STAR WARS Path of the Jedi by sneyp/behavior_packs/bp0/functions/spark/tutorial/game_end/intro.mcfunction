execute if score .timer tutorial matches 0 run tp @a ~~~ 90 0
execute if score .timer tutorial matches 0 run music stop 3.0
execute if score .timer tutorial matches 0 run music play sound.spark.music.YodaAndTheYounglingsB 1.0 0.1 loop
execute if score .timer tutorial matches 55 run function spark/tutorial/game_end/summon_npcs

execute if score .timer tutorial matches 57 run tag @e[type=spark:yoda,c=1] add has_quest
execute if score .timer tutorial matches 57 run tag @e[type=spark:yoda,c=1] add short
execute if score .timer tutorial matches 57 run event entity @e[type=spark:yoda,c=1] spark:quest_npc
execute if score .timer tutorial matches 57 run title @a actionbar hud:fade_in_1
execute if score .timer tutorial matches 57 run tag @a remove hide_ui
execute if score .timer tutorial matches 59 run dialogue change @e[type=spark:yoda,c=1] spark:game.yoda.end
# execute if score .timer tutorial matches 59 run music stop 3.0

#Continues once button in yoda's dialouge was pressed