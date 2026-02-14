# © Spark Universe, 2023
# authors: FetchBot
# description: check if the conditions are met to unlock this achievement display entity and handle unlocking
# called by: controller.animation.spark.display_small.achievement_checker

execute if score "Lightsaber_Duelling" SS_achievements matches 1 if entity @s[tag="Lightsaber_Duelling",family=!robe_display] run function spark/achievement/unlock_holo
execute if score "Ancient_Puzzle" SS_achievements matches 1 if entity @s[tag="Ancient_Puzzle",family=!robe_display] run function spark/achievement/unlock_holo
execute if score "Droid_Survival" SS_achievements matches 1 if entity @s[tag="Droid_Survival",family=!robe_display] run function spark/achievement/unlock_holo
execute if score "Escape_the_Battleship" SS_achievements matches 1 if entity @s[tag="Escape_the_Battleship",family=!robe_display] run function spark/achievement/unlock_holo
execute if score "Monster_Battle_Arena" SS_achievements matches 1 if entity @s[tag="Monster_Battle_Arena",family=!robe_display] run function spark/achievement/unlock_holo

execute if score "Lightsaber_Duelling_Post" SS_achievements matches 1 if entity @s[tag="Lightsaber_Duelling_Post",family=robe_display] run function spark/achievement/unlock_cloak
execute if score "Ancient_Puzzle_Post" SS_achievements matches 1 if entity @s[tag="Ancient_Puzzle_Post",family=robe_display] run function spark/achievement/unlock_cloak
execute if score "Droid_Survival_Post" SS_achievements matches 1 if entity @s[tag="Droid_Survival_Post",family=robe_display] run function spark/achievement/unlock_cloak
execute if score "Escape_the_Battleship_Post" SS_achievements matches 1 if entity @s[tag="Escape_the_Battleship_Post",family=robe_display] run function spark/achievement/unlock_cloak
execute if score "Monster_Battle_Arena_Post" SS_achievements matches 1 if entity @s[tag="Monster_Battle_Arena_Post",family=robe_display] run function spark/achievement/unlock_cloak
execute if entity @s[tag="Pilot",family=robe_display] run function spark/achievement/unlock_cloak

execute if score "Lightsaber_Duelling" SS_achievements matches 1 if score "Ancient_Puzzle" SS_achievements matches 1 if score "Droid_Survival" SS_achievements matches 1 if score "Escape_the_Battleship" SS_achievements matches 1 if score "Monster_Battle_Arena" SS_achievements matches 1 if score "All_Completed" SS_achievements matches 0 run function spark/achievement/all_completed


execute if entity @s[family=!robe_display] if entity @s[tag=is_achieved,r=1] run event entity @s spark:set_is_achieved