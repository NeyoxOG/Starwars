# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# remove resistance if still applied
execute if score .timer tutorial matches 1 run effect @a resistance 0

# despawn old huyang
execute if score .timer tutorial matches 1 positioned 3021 -56 3030 run event entity @e[type=spark:master_huyang,c=1,r=1] spark:despawn
#execute if score .timer tutorial matches 1 run inputpermission set @a movement enabled

# spawn in huyang with particles
execute if score .timer tutorial matches 2 positioned 3025 -56 3050 run summon spark:master_huyang ~ ~ ~ 0 0
execute if score .timer tutorial matches 4 positioned 3025 -56 3050 run event entity @e[type=spark:master_huyang,c=1,r=1] spark:quest_npc
execute if score .timer tutorial matches 4 positioned 3025 -56 3050 run tag @e[type=spark:master_huyang,c=1,r=1] add tall
execute if score .timer tutorial matches 4 positioned 3025 -56 3050 run tag @e[c=1,r=1,type=spark:master_huyang] add has_quest

# hallway effects
execute if score .timer tutorial matches 3 run event entity @e[type=spark:ship_emergency_light,x=3000,y=-56,z=3050,r=50] spark:enable
function spark/particles/crucible_crash

# set dialog
execute if score .timer tutorial matches 5 positioned 3025 -56 3050 run dialogue change @e[type=spark:master_huyang,r=1] spark:crucible.huyang_3

# fade in
execute if score .timer tutorial matches 10 run title @a actionbar hud:fade_in_1
execute if score .timer tutorial matches 10 run camerashake stop @a

# wait for any player to get past the screen, then goto next phase :D
execute if score .timer tutorial matches 6.. if score .npc_trigger tutorial matches 1 run function spark/tutorial/next