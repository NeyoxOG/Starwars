execute positioned 3389 34 -103 unless entity @e[type=spark:elevator_button,c=1,r=10] rotated 180 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons
execute positioned 3389 34 -103 run event entity @e[type=spark:elevator_button,c=1,r=10,tag=temple] spark:disable
execute positioned 3389 34 -103 as @e[type=spark:elevator_button,r=10] at @s run tp @s ~ ~ ~ 0 0

execute positioned 3365 34 -54.5 unless entity @e[type=spark:mace_windu,c=1,r=5] run summon spark:mace_windu ~ ~ ~ 0 0 spark:quest_npc
execute positioned 3365 34 -54.5 run dialogue change @e[type=spark:mace_windu,c=1,r=5] spark:jedi_temple.mace_windu.1
execute positioned 3365 34 -54.5 run event entity @e[type=spark:mace_windu,c=1,r=5] spark:enable_quest_icon


execute positioned 3413 34 -54.5 unless entity @e[type=spark:yoda,c=1,r=5] run summon spark:yoda ~ ~ ~ 0 0 spark:quest_npc
execute positioned 3414 34 -54.5 run dialogue change @e[type=spark:yoda,c=1,r=5] spark:jedi_temple.yoda.1


fill 3365 34 -96 3413 64 -96 air [] replace red_wool