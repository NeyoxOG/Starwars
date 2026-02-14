execute positioned 3389 34 103 unless entity @e[type=spark:elevator_button,c=1,r=10] rotated 0 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons
execute positioned 3389 34 103 run event entity @e[type=spark:elevator_button,c=1,r=10,tag=temple] spark:disable
execute positioned 3389 34 103 as @e[type=spark:elevator_button,r=10] at @s run tp @s ~ ~ ~ 180 0

execute positioned 3364 34 55.5 unless entity @e[type=spark:anakin_skywalker,c=1,r=5] run summon spark:anakin_skywalker ~ ~ ~ -150 0 spark:quest_npc
execute positioned 3366 34 55.5 run dialogue change @e[type=spark:anakin_skywalker,c=1,r=5] spark:jedi_temple.anakin.1
execute positioned 3363 34 55.5 unless entity @e[type=spark:astromech,c=1,r=5] run summon spark:astromech ~ ~ ~ -140 0 spark:r2_d2
execute positioned 3366 34 55.5 unless entity @e[type=spark:ahsoka_tano,c=1,r=5] run summon spark:ahsoka_tano ~ ~ ~ 150 0 spark:quest_npc
execute positioned 3364 34 55.5 run dialogue change @e[type=spark:ahsoka_tano,c=1,r=5] spark:jedi_temple.ahsoka.1
execute positioned 3364 34 55.5 run event entity @e[type=spark:ahsoka_tano,c=1,r=5] spark:enable_quest_icon

execute positioned 3413 34 55.5 unless entity @e[type=spark:obi_wan_kenobi,c=1,r=5] run summon spark:obi_wan_kenobi ~ ~ ~ 180 0 spark:quest_npc
execute positioned 3413 34 55.5 run dialogue change @e[type=spark:obi_wan_kenobi,c=1,r=5] spark:jedi_temple.obi_wan.1
execute positioned 3413 34 55.5 run event entity @e[type=spark:obi_wan_kenobi,c=1,r=5] spark:enable_quest_icon

fill 3365 34 96 3413 64 96 air [] replace red_wool