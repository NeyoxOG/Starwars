execute if score .timer tutorial matches 1 run tp @a 9200 37 8998 -180 0
execute if score .timer tutorial matches 1 run music play sound.spark.music.YodaAndTheYounglingsB

# change player stamina and health max values
execute if score .timer tutorial matches 1 run scoreboard players set .max hotbar_health_size 10
execute if score .timer tutorial matches 1 run scoreboard players set .max hotbar_stamina_size 7
execute if score .timer tutorial matches 2 run effect @a instant_health 10 10 true

execute if score .timer tutorial matches 53 run tag @e[type=spark:mace_windu,c=1] add short
execute if score .timer tutorial matches 53 run event entity @e[type=spark:mace_windu,c=1] spark:quest_npc_sitting

# set mace dialogue
execute if score .timer tutorial matches 55 run dialogue change @e[type=spark:mace_windu,c=1] spark:jedi_council.mace.do_activities

execute if score .timer tutorial matches 73 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"spark.ui.location.jedi_council", "with": [ "\n" ] }]}

#spark/tutorial/next is triggered by NPC