# dev function, ignore

scoreboard players set .substate tutorial 0
scoreboard players set .state tutorial 3
scoreboard players set .timer tutorial 0
scoreboard players set .npc_trigger tutorial 0

# instancing should be fine to not reset here

tag @a[tag=assigned] remove assigned
clear @a

event entity @e[type=spark:crucible_gate_large] spark:despawn
event entity @e[type=spark:crucible_gate_small] spark:despawn
execute as @e[type=spark:astromech] at @s unless entity @s[x=3363,y=34,z=55.5,r=5] run event entity @s spark:despawn
event entity @e[type=spark:lightsaber_ui_npc] instant_despawn

# very distructive, just for dev work
event entity @e[family=quest_npc] spark:despawn
event entity @e[family=npc] spark:despawn
event entity @e[family=training_bot] spark:despawn

# remove ui stuff
scoreboard players set @s SS_ui_info 0
scoreboard players set @s SS_ui_task 0
scoreboard players set @s SS_ui_warning 0
scoreboard players set @s SS_ui_tutorial 0

scoreboard players set .active1 tut_instances 0
scoreboard players set .active2 tut_instances 0
scoreboard players set .active3 tut_instances 0
scoreboard players set .active4 tut_instances 0