# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# tell the player to not worry, they can customise their mech later
execute if score .timer tutorial matches 1 run music stop 0.5
execute if score .timer tutorial matches 1 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.droid_crafting.announcement.activation.announcement1", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 40 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.droid_crafting.hint.customize_later.tip1", "with": [ "\n" ] }]} 
execute if score .timer tutorial matches 1 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer tutorial matches 1 run scoreboard players set @a SS_ui_task 0


# hallway effects
function spark/particles/crucible_crash

# wait for fade, then do a cutscene
execute if score .timer tutorial matches 100 run titleraw @a actionbar {"rawtext":[{ "text": "hud:clear" }]}


execute if score .timer tutorial matches 101 run function spark/cutscene/start_ch02_c10

# next stage
execute if score .timer tutorial matches 488 run function spark/tutorial/next