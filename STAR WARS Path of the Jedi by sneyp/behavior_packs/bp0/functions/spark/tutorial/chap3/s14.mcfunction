# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# items
execute if score .timer tutorial matches 1 as @a run function spark/lightsaber/give_lightsaber
execute if score .timer tutorial matches 1 run replaceitem entity @a slot.hotbar 1 air
execute if score .timer tutorial matches 1 run replaceitem entity @a slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 1 run replaceitem entity @a slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 1 run replaceitem entity @a slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}

# remove restrictions and set gamemode
# execute if score .timer tutorial matches 1 run inputpermission set @a movement enabled
# execute if score .timer tutorial matches 1 run inputpermission set @a camera enabled
execute if score .timer tutorial matches 1 run gamemode adventure @a

# teleport
execute if score .timer tutorial matches 2 run tp @a 3047.53 -49.00 2962.95 180 0
execute if score .timer tutorial matches 2 run playsound sound.spark.transitioner_cockpit @a

# check for door, if not exit, spawn in 3047 -49 2965
# execute if score .timer tutorial matches 3 unless entity @e[type=spark:crucible_gate_small,x=3047,y=-49,z=2965,r=1] run summon spark:crucible_gate_small 3047 -49 2965 0 0 spark:door_north

# spawn mobs
execute if score .timer tutorial matches 3 run scoreboard players set .count tutorial 0
execute if score .timer tutorial matches 3 positioned 3046.0 -49 2958.5 run event entity @e[type=spark:kelleran_beq,r=50] spark:despawn
execute if score .timer tutorial matches 4 positioned 3046.0 -49 2958.5 run summon spark:kelleran_beq ~~~ 0 0
execute if score .timer tutorial matches 5 positioned 3046.0 -49 2958.5 run event entity @e[type=spark:kelleran_beq,r=50] spark:quest_npc
execute if score .timer tutorial matches 5 run summon spark:ad_3 3050.78 -49.00 2960.35 180 0
execute if score .timer tutorial matches 6 run summon spark:lx_r5_droid 3044.5 -49 2960.5 80 0
execute if score .timer tutorial matches 5 positioned 3049.63 -49.00 2956.79 run ride @e[type=spark:ad_3,c=1] start_riding @e[type=spark:crucible_chair,c=1]

# set quest on kelleran
execute if score .timer tutorial matches 6 positioned 3047 -49 2958 run dialogue change @e[r=10,type=spark:kelleran_beq] spark:crucible.kelleran_4 @a
execute if score .timer tutorial matches 15 positioned 3047 -49 2958 run tag @e[c=1,r=10,type=spark:kelleran_beq] add has_quest 

# remove fade
# execute if score .timer tutorial matches 15 run title @a actionbar hud:fade_in_1

# next chapter!
# need a time out for this, set .count tutorial to 100, then countdown
# on npc trigger do hyperspace effect and sound
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 4 run camerashake add @a 0.25 4 positional
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 4 run particle spark:hyperspace 3048.0 -46.9 2925
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 65 run camerashake add @a 0.7 0.1 positional
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 4 run playsound sound.spark.enter_hyperspace @a
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 4 run music stop 0.1
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 4 run music play sound.spark.music.InThePilotsChair
execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 1 positioned 3047 -49 2958 run event entity @e[type=spark:kelleran_beq,c=1] spark:reset_npc

execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 80 run title @a actionbar hud:fade_out_1

execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 80 run function spark/tutorial/next_chapter
# execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 if score .count tutorial matches 0 run say finished chapter 3

execute if score .timer tutorial matches 21.. if score .npc_trigger tutorial matches 1 run scoreboard players add .count tutorial 1