# © Spark Universe, 2023
# authors: Arcaniax, William Savage
# description: UI loop, runs once a second by each player
# called by: ui/loop
 
# other ui in this tick!
execute if score @s SS_ui_loading matches 0 run title @s title hud:loading:
execute if score @s SS_ui_loading matches 1 run title @s title hud:loading:ilum
execute if score @s SS_ui_loading matches 2 run title @s title hud:loading:coruscant
execute if score @s SS_ui_loading matches 3 run title @s title hud:loading:tattooine
execute if score @s SS_ui_loading matches 4 run title @s title hud:loading:felucia
execute if score @s SS_ui_loading matches 5 run title @s title hud:loading:naboo
execute if score @s SS_ui_loading matches 6 run title @s title hud:loading:dreadnaught
execute if score @s SS_ui_loading matches 7 run title @s title hud:loading:kamino
execute if score @s SS_ui_loading matches 8 run title @s title hud:loading:custom_1
execute if score @s SS_ui_loading matches 9 run title @s title hud:loading:custom_2
execute if score @s SS_ui_loading matches 10 run title @s title hud:loading:blackbars