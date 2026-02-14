# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/update

execute if score "All_Completed" SS_achievements matches 0 run tickingarea add circle 8900 24 9159 2 temp_hologram true
execute if score "All_Completed" SS_achievements matches 0 run schedule on_area_loaded add tickingarea temp_hologram spark/achievement/enable_big_hologram
scoreboard players set "All_Completed" SS_achievements 1