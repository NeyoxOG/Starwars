execute if score .timer tutorial matches 21 positioned 8912 23 9159 run event entity @e[family=npc,r=10] spark:despawn
execute if score .timer tutorial matches 21 positioned 8914 23 9162 run event entity @e[type=spark:astromech,c=1] spark:despawn

execute if score .timer tutorial matches 22 run tp @a 3389 51 0 90 0

execute if score .timer tutorial matches 62 run inputpermission set @a[tag=!dev] camera enabled
execute if score .timer tutorial matches 62 run inputpermission set @a[tag=!dev] movement enabled

execute if score .timer tutorial matches 62 as @a run function spark/lightsaber/give_lightsaber
execute if score .timer tutorial matches 62 as @a run replaceitem entity @a slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 62 as @a run replaceitem entity @a slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 62 as @a run replaceitem entity @a slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}

execute if score .timer tutorial matches 265 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"main_hall.hint.replay_quests", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 265 run function spark/tutorial/next_chapter

## idk really

#execute if score .timer tutorial matches 62 positioned 3365 34 -54.5 unless entity @e[type=spark:mace_windu,c=1,r=5] run summon spark:mace_windu ~ ~ ~ 0 0 spark:quest_npc
#execute if score .timer tutorial matches 62 positioned 3365 34 -54.5 run dialogue change @e[type=spark:mace_windu,c=1,r=5] spark:jedi_temple.mace_windu.1
#execute if score .timer tutorial matches 62 positioned 3365 34 -54.5 run event entity @e[type=spark:mace_windu,c=1,r=5] spark:enable_quest_icon
#
#execute if score .timer tutorial matches 62 positioned 3413 34 -54.5 unless entity @e[type=spark:yoda,c=1,r=5] run summon spark:yoda ~ ~ ~ 0 0 spark:quest_npc
#execute if score .timer tutorial matches 62 positioned 3414 34 -54.5 run dialogue change @e[type=spark:yoda,c=1,r=5] spark:jedi_temple.yoda.1
#execute if score .timer tutorial matches 62 positioned 3365 34 -54.5 run event entity @e[type=spark:yoda,c=1,r=5] spark:enable_quest_icon
#
#execute if score .timer tutorial matches 62 positioned 3364 34 55.5 unless entity @e[type=spark:anakin_skywalker,c=1,r=5] run summon spark:anakin_skywalker ~ ~ ~ -150 0 spark:quest_npc
#execute if score .timer tutorial matches 62 positioned 3366 34 55.5 run dialogue change @e[type=spark:anakin_skywalker,c=1,r=5] spark:jedi_temple.anakin.1
#execute if score .timer tutorial matches 62 positioned 3363 34 55.5 unless entity @e[type=spark:astromech,c=1,r=5] run summon spark:astromech ~ ~ ~ -140 0 spark:r2_d2
#
#execute if score .timer tutorial matches 62 positioned 3366 34 55.5 unless entity @e[type=spark:ahsoka_tano,c=1,r=5] run summon spark:ahsoka_tano ~ ~ ~ 150 0 spark:quest_npc
#execute if score .timer tutorial matches 62 positioned 3364 34 55.5 run dialogue change @e[type=spark:ahsoka_tano,c=1,r=5] spark:jedi_temple.ahsoka.1
#execute if score .timer tutorial matches 62 positioned 3364 34 55.5 run event entity @e[type=spark:ahsoka_tano,c=1,r=5] spark:enable_quest_icon
#
#execute if score .timer tutorial matches 62 positioned 3413 34 55.5 unless entity @e[type=spark:obi_wan_kenobi,c=1,r=5] run summon spark:obi_wan_kenobi ~ ~ ~ 180 0 spark:quest_npc
#execute if score .timer tutorial matches 62 positioned 3413 34 55.5 run dialogue change @e[type=spark:obi_wan_kenobi,c=1,r=5] spark:jedi_temple.obi_wan.1
#execute if score .timer tutorial matches 62 positioned 3413 34 55.5 run event entity @e[type=spark:obi_wan_kenobi,c=1,r=5] spark:enable_quest_icon