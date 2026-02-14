# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/update

# tickingarea add 3413.51 33.07 -54.37 3413.51 33.07 -54.37 yoda_temp true
# say enable_puzzle_level called
execute as @e[type=spark:astromech,tag=npc,c=1] run schedule on_area_loaded add circle 3413.57 34.27 -54.60 1 spark/achievement/update_yoda