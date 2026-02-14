# execute if score .timer tutorial matches 0 run title @a actionbar hud:fade_out_1
execute if score .timer tutorial matches 15 run music stop 1.0
# execute if score .timer tutorial matches 23 run title @a actionbar hud:fade_in_1
execute if score .timer tutorial matches 20 run function spark/cutscene/start_ch02_c12
execute if score .timer tutorial matches 20 run tag @e[type=spark:mace_windu,c=1] remove has_quest

# execute if score .timer tutorial matches 80 run title @a actionbar hud:fade_out_1
# execute if score .timer tutorial matches 100 run title @a actionbar hud:game_card:
# execute if score .timer tutorial matches 220 run function spark/tutorial/next