# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILLUM WALL MELTING


execute if score .timer tutorial matches 0 run title @a actionbar hud:fade_out_1
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer tutorial matches 20 run clear @a
execute if score .timer tutorial matches 21 run replaceitem entity @a slot.armor.chest 0 spark:cloak_default 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 20 run structure load spark:ilum_gate 47 -27 3002 0_degrees none
execute if score .timer tutorial matches 20 run gamemode spectator @a

execute if score .timer tutorial matches 100 run function spark/tutorial/next

