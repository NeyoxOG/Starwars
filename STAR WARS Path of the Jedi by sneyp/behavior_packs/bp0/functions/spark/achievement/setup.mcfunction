# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/setup


scoreboard objectives add SS_achievements dummy
scoreboard players set "Lightsaber_Duelling" SS_achievements 0
scoreboard players set "Pilot" SS_achievements 0
scoreboard players set "Droid_Survival" SS_achievements 0
scoreboard players set "Escape_the_Battleship" SS_achievements 0
scoreboard players set "Monster_Battle_Arena" SS_achievements 0
scoreboard players set "Ancient_Puzzle" SS_achievements 0
scoreboard players set "Lightsaber_Duelling_Post" SS_achievements 0
scoreboard players set "Droid_Survival_Post" SS_achievements 0
scoreboard players set "Escape_the_Battleship_Post" SS_achievements 0
scoreboard players set "Monster_Battle_Arena_Post" SS_achievements 0
scoreboard players set "Ancient_Puzzle_Post" SS_achievements 0
scoreboard players set "All_Completed" SS_achievements 0

scoreboard players set ".completed" SS_achievements 0


# tickingarea add circle 8900 26 9159 2 "temp_achievement_spawn_area" true
# schedule on_area_loaded add tickingarea temp_achievement_spawn_area spark/achievement/setup_central_area

# tickingarea add 8964 33 9149 8984 33 9169 "temp_achievement_robes_area" true
# schedule on_area_loaded add tickingarea temp_achievement_robes_area spark/achievement/setup_robes_area

#schedule on_area_loaded add circle 9011.52 26.00 9159.51 1 spark/achievement/setup_elevator
# say setup achievement