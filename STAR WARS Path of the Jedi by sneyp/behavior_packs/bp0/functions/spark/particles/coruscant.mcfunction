
scoreboard players random traffic SS_temp 0 6
execute if score traffic SS_temp matches 0..4 run particle spark:coruscant_traffic_north 2950 110 -240
execute if score traffic SS_temp matches 0..3 run particle spark:coruscant_traffic_south 2840 80 250
execute if score traffic SS_temp matches 1..4 run particle spark:coruscant_traffic_east 2844 160 -175
execute if score traffic SS_temp matches 2..6 run particle spark:coruscant_traffic_west 3310 180 135
#execute if score traffic SS_temp matches 1..6 run particle spark:coruscant_traffic_south 3100 230 393
particle spark:coruscant_ground_shade 2984 -64 0

particle spark:decal_jedi_temple_floor_pattern_left 3122.0 32.02 -14.0
particle spark:decal_jedi_temple_floor_pattern_right 3122.0 32.02 15.0
