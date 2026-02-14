execute if score .substate tutorial matches 5 run function spark/tutorial/next
execute if score .timer tutorial matches 1 as @a at @s run playsound sound.spark.enter_coruscant_temple @s

#execute if score .timer tutorial matches 1 run music play sound.spark.ambience_coruscant 1.0 0.1

execute as @e[family=npc,tag=tmp_delay] run function spark/tutorial/chap4/npc_path/new_dialogue
execute as @e[type=spark:astromech,tag=npc,tag=tmp_delay] run function spark/tutorial/chap4/npc_path/new_dialogue
scoreboard players add @e[family=npc,scores={timer=1..}] timer 1
scoreboard players add @e[type=spark:astromech,tag=npc,scores={timer=1..}] timer 1
execute at @e[family=npc,scores={timer=1..}] if entity @e[type=spark:breadcrumb_2,r=3] run function spark/tutorial/chap4/npc_path/stop
execute at @e[family=npc,scores={timer=1..}] if entity @e[type=spark:breadcrumb_4,r=3] run function spark/tutorial/chap4/npc_path/stop
execute at @e[type=spark:astromech,scores={timer=1..}] if entity @e[type=spark:breadcrumb_6,r=3] run function spark/tutorial/chap4/npc_path/stop
execute at @e[family=npc,scores={timer=1..}] run event entity @e[family=breadcrumb,r=3] spark:despawn 
execute at @e[type=spark:astromech,scores={timer=1..}] run event entity @e[type=spark:breadcrumb_6,r=3] spark:despawn 
execute as @e[family=npc,scores={timer=1..}] at @s if score @s timer >= @s SS_const run function spark/tutorial/chap4/npc_path/stop

execute as @e[family=npc,scores={timer=1..},tag=face_player] at @s run function spark/tutorial/chap4/npc_path/face_player
execute as @e[type=spark:astromech,tag=npc,scores={timer=1..},tag=face_player] at @s run function spark/tutorial/chap4/npc_path/face_player