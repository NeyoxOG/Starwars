scoreboard objectives add .monster_battle dummy

scoreboard players set .timer .monster_battle 0
scoreboard players set .monster .monster_battle 0
scoreboard players set .phase .monster_battle 0

scoreboard players add .monster_1_complete .monster_battle 0
scoreboard players add .monster_2_complete .monster_battle 0

# no longer in hub
scoreboard players set .hub glob_mission_state 0

#tp @p 6292.63 146.00 6031.69
#schedule delay add spark/monster_battle/temp_load/1 70