execute if score .timer tutorial matches 1 run tp @a 9200 37 8982 -180 8


# disable mace dialogue
execute if score .timer tutorial matches 8 run event entity @e[type=spark:mace_windu,c=1] spark:reset_npc
execute if score .timer tutorial matches 11 as @e[type=spark:mace_windu,c=1] at @s run ride @s start_riding @e[family=council_chair,c=1] teleport_rider

# do yoda dialogue
execute if score .timer tutorial matches 10 run event entity @e[type=spark:yoda,c=1] spark:quest_npc_sitting
execute if score .timer tutorial matches 11 run dialogue change @e[type=spark:yoda,c=1] spark:jedi_council.yoda.return_to_hall
execute if score .timer tutorial matches 12 run event entity @e[type=spark:yoda,c=1] spark:enable_quest_icon

execute if score .timer tutorial matches 13 run title @a actionbar hud:fade_in_1

#spark/tutorial/next is triggered by NPC