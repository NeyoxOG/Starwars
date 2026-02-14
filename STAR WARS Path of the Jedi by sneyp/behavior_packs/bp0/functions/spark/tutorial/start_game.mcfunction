# © Spark Universe, 2023
# authors: Arcaniax (Moved By FetchBot)
# description: Starts the map
# called by: button in starting room after checking the player count

titleraw @a[r=10] actionbar {"rawtext":[{ "text": "hud:loading_partner:" }]}
# titleraw @a[r=10] actionbar hud:game_card: (for the game card)
# titleraw @a[r=10] actionbar {"rawtext":[{ "text": "hud:time_skip:" },{"translate":"intro.text_card.time_skip", "with": [ "\n" ] }]}

playsound sound.spark.start_button @a 
music stop 0.1
music play sound.spark.music.PalpatinesTeachings
playsound sound.spark.logo_appear @a 
playsound sound.spark.cutscene.arrive_ilum @a 

replaceitem entity @a slot.armor.chest 0 spark:cloak_default 1 0 {"item_lock":{"mode":"lock_in_slot"}}

#
tp @a -6.70 0.00 -6.70 135.99 4.41

#
tag @a add started
tag @a remove hide_ui
tag @a remove blackbox_spawned
tag @a add hide_hotbar

# setup tutorial scoreboards
scoreboard objectives add tutorial dummy 
scoreboard players set .state tutorial 1
scoreboard players set .substate tutorial 0
scoreboard players set .timer tutorial 0 
scoreboard players set .npc_trigger tutorial 0
