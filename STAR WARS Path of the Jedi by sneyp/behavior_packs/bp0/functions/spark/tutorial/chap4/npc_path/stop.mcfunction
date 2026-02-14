event entity @e[family=npc,r=7] spark:freeze
event entity @e[type=spark:astromech,tag=npc,r=7] spark:freeze
event entity @e[family=npc,type=!spark:ahsoka_tano,r=7] spark:quest_npc
execute if entity @s[family=npc] run event entity @e[type=spark:breadcrumb_2,r=7] spark:despawn
execute if entity @s[family=npc] run event entity @e[type=spark:breadcrumb_4,r=7] spark:despawn
execute if entity @s[type=spark:astromech,tag=npc] run event entity @e[type=spark:breadcrumb_6,r=7] spark:despawn

tag @e[family=npc,r=7] add face_player
tag @e[type=spark:astromech,r=7,tag=npc] add face_player

scoreboard players set @s timer 1
scoreboard players reset @s SS_const

tag @e[r=7,family=npc] add tmp_delay
tag @e[r=7,type=spark:astromech,tag=npc] add tmp_delay