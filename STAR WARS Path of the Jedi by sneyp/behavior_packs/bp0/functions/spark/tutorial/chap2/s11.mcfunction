# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILUM CAVE ENTRANCE

execute if score .timer tutorial matches 0 run tp @a 4.5 -26 3021.5 90 -30

execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_task 1
#execute if score .timer tutorial matches 0 run fill -34 -19 3023 -37 -22 3017 air

execute if score .timer tutorial matches 20 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.ilum_temple.announcement.force_powers.announcement1", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 20 run tag @a remove hide_hotbar
execute if score .timer tutorial matches 20 run playsound sound.spark.receive_locked_powers @a

execute if score .timer tutorial matches 0.. positioned -55.5 -22.00 3021.5 run titleraw @a[r=8,tag=!ilum_caves] actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"intro.ilum_caves.location_banner.location1", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 0.. positioned -55.5 -22.00 3021.5 run tag @a[r=8,tag=!ilum_caves] add ilum_caves
execute if score .timer tutorial matches 0.. positioned -55.5 -22.00 3021.5 run playsound sound.spark.enter_crystal_cave @a[r=8,tag=!ilum_caves]


execute if score .timer tutorial matches 0.. positioned -159.0 -28.0 3042.0 if entity @a[r=35] run function spark/tutorial/next