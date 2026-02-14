# © Spark Universe, 2023
# authors: Arcaniax, FetchBot
# description: runs 1/s 
# called by: tutorial loop20

execute as @e[type=spark:tutorial_button,c=1] run scoreboard players add @s timer 1

execute as @e[type=spark:tutorial_button,c=1,scores={timer=6}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:start_hint:" },{"translate":"spark.ui.tutorial.sound_hint", "with": [ "\n" ] }]}
#temp to clear message
execute as @e[type=spark:tutorial_button,c=1,scores={timer=11}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute as @e[type=spark:tutorial_button,c=1,scores={timer=12}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:start_hint:" },{"translate":"spark.ui.tutorial.copyright_hint", "with": [ "\n" ] }]}
#temp to clear message
execute as @e[type=spark:tutorial_button,c=1,scores={timer=17}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:clear" }]}

# repeating messages every 5 seconds

# START LOOP
execute as @e[type=spark:tutorial_button,c=1,scores={timer=22}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:start_hint:" },{"translate":"spark.ui.tutorial.sound_hint", "with": [ "\n" ] }]}
#temp to clear message
execute as @e[type=spark:tutorial_button,c=1,scores={timer=27}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute as @e[type=spark:tutorial_button,c=1,scores={timer=32}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:start_hint:" },{"translate":"spark.ui.tutorial.copyright_hint", "with": [ "\n" ] }]}
#temp to clear message
execute as @e[type=spark:tutorial_button,c=1,scores={timer=37}] at @s run titleraw @a[r=10,tag=!started] actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute as @e[type=spark:tutorial_button,c=1,scores={timer=42..}] run scoreboard players set @s timer 21