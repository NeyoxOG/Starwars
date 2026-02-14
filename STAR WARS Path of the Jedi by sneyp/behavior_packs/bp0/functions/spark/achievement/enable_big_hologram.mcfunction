# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/all_completed

event entity @e[type=spark:display_main] spark:set_is_achieved
tickingarea remove temp_hologram