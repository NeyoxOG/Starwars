# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# spawns
# master_huyang 3003 -56 3029
# kelleran_beq 3027.52 -56.00 3033.56
# padawan_1 3030 -56 3037
# padawan_2 3027 -56 3036
# padawan_3 3026 -56 3033
# player spawn 3047 -56 2988
# player chat teleport 3032 -56 3032

# doors and stuff
# work room door 3036 -56 3033 spark:door_east -
# work room door to corridor 3028 -56 3045 spark:door_north -
# cockpit 3x3 3047 -49 2964 north -
# up door 3x3 3047 -49 2977 north -
# entrence 3x3 3047 -56 2986 north -
# side 5x5 3058 -56 2994 east -
# side 5x5 3036 -56 2994 east -
# side 5x5 3053 -56 3009 east -
# side 5x5 3041 -56 3009 east - 
# side 5x5 3047 -56 3039 north -
# side 5x5 3058 -56 3033 east -

# crafting entity 3020 -55 3033 -
# need positions for other crafting entities

execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 0 spark:kyber 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}

#
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 1 run tp @a 3047 -56 2988 0 0
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 1 run gamemode adventure @a
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 2 run music stop 0.1
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 3 run music play sound.spark.music_jarjar_intro1 1.0 0.1
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 4 run music queue sound.spark.music_meadow_picnic 1.0 0.1 loop

#execute if score .timer tutorial matches 10 run title @a actionbar hud:fade_in_1
# execute if score .timer tutorial matches 10 run titleraw @a actionbar {"rawtext":[{"text":"hud:announce:TEMP: FADE IN"}]}

# summon doors
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 13 run summon spark:crucible_gate_large 3058.18 -56 2994 0 0 spark:door_east
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 14 run summon spark:crucible_gate_large 3036.82 -56 2994 0 0 spark:door_east
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 15 run summon spark:crucible_gate_large 3053.18 -56 3009 0 0 spark:door_east
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 16 run summon spark:crucible_gate_large 3041.82 -56 3009 0 0 spark:door_east
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 17 run summon spark:crucible_gate_large 3047 -56 3039.18 0 0 spark:door_north
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 18 run summon spark:crucible_gate_large 3058.18 -56 3033 0 0 spark:door_east

#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 19 run summon spark:crucible_gate_large 3036.82 -56 3033 0 0 spark:door_east

# summon lightsaber crafting entities (disabled)
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 20 run summon spark:lightsaber_crafting_table 3027 -56 3027.0 180 0
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 20 run summon spark:lightsaber_crafting_table 3023 -56 3027.0 180 0
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 20 run summon spark:lightsaber_crafting_table 3023 -56 3044.0 0 0
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 20 run summon spark:lightsaber_crafting_table 3035.0 -56 3039 -90 0

execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 30 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"intro.location_banner.crucible.location1", "with": [ "\n" ] }]}
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 30 run playsound sound.spark.transitioner_cockpit @a

# set task and play sound
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 160 run scoreboard players set @a SS_ui_tutorial 5
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 160 run playsound sound.spark.quest_minor @a

# summon npcs
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 121 run summon spark:kelleran_beq 3027.52 -56.00 3033.56 facing 3041 -55 3033
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 122 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:quest_npc
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 123 positioned 3027.52 -56.00 3033.56 run dialogue change @e[r=1,type=spark:kelleran_beq] spark:crucible.kelleran_2
# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 123 positioned 3027.52 -56.00 3033.56 run tag @e[c=1,r=1,type=spark:kelleran_beq] add has_quest 

#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 103 run summon spark:padawan_1 3023.41 -56.00 3036.43 facing 3041 -55 3033
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 104 run summon spark:padawan_2 3025.38 -56.00 3038.48 facing 3041 -55 3033
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 105 run summon spark:padawan_3 3027.52 -56.00 3038.45 facing 3041 -55 3033

# execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 101 run summon spark:huyang_counter 3020.5 -56.00 3042.5 90 0

# summon doors when close

# door we can only see once we are in the room, summon when close
#execute if score .npc_trigger tutorial matches 0 if entity @a[x=3049,y=-57,z=3020,dx=-4,dy=6,dz=3,c=1] unless entity @e[type=spark:crucible_gate_small,x=3028,y=-56,z=3045,r=1] run summon spark:crucible_gate_small 3028 -56 3045 0 0 spark:door_north

# if players are near door, or door will auto open? 3047.19 -56.00 3033.63
# execute if score .npc_trigger tutorial matches 0 if entity @a[x=3047,y=-57,z=3033,r=6,c=1] positioned 3036 -56 3033 run event entity @e[type=spark:crucible_gate_large,r=1,c=10] spark:open_door

# for lag reasons... we need to trigger the npc update stuff here!
execute if score .npc_trigger tutorial matches 0 if score .s2 chap3_tmp matches 0 if entity @a[x=3047,y=-57,z=3033,r=6,c=1] run scoreboard players set .s2 chap3_tmp 1


execute if score .s2 chap3_tmp matches 2 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:quest_npc

execute if score .s2 chap3_tmp matches 4 positioned 3027.52 -56.00 3033.56 run dialogue change @e[r=1,type=spark:kelleran_beq] spark:crucible.kelleran_2
execute if score .s2 chap3_tmp matches 4 positioned 3036 -56 3033 run event entity @e[type=spark:crucible_gate_large,r=2] spark:open_door

execute if score .s2 chap3_tmp matches 6 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:enable_quest_icon

execute if score .s2 chap3_tmp matches 1.. run scoreboard players add .s2 chap3_tmp 1
execute if score .s2 chap3_tmp matches 7.. run scoreboard players set .s2 chap3_tmp -1


execute if score .npc_trigger tutorial matches 1 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:reset_npc
execute if score .npc_trigger tutorial matches 1 run function spark/tutorial/next