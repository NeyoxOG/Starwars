# © Spark Universe, 2023
# authors: FetchBot
# description: trigger the unlocking of all achievements
# called by: manual

scoreboard players set "Lightsaber_Duelling" SS_achievements 1
scoreboard players set "Pilot" SS_achievements 1
scoreboard players set "Droid_Survival" SS_achievements 1
scoreboard players set "Escape_the_Battleship" SS_achievements 1
scoreboard players set "Monster_Battle_Arena" SS_achievements 1
scoreboard players set "Ancient_Puzzle" SS_achievements 1
scoreboard players set "Lightsaber_Duelling_Post" SS_achievements 1
scoreboard players set "Droid_Survival_Post" SS_achievements 1
scoreboard players set "Escape_the_Battleship_Post" SS_achievements 1
scoreboard players set "Monster_Battle_Arena_Post" SS_achievements 1
scoreboard players set "Ancient_Puzzle_Post" SS_achievements 1
function spark/achievement/progress_update
event entity @e[family=achievement_display] spark:update
