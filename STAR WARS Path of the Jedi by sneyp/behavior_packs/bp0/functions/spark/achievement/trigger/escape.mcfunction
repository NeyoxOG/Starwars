# © Spark Universe, 2023
# authors: FetchBot
# description: trigger the unlocking of an achievement
# called by: <TBD>

execute if score "Escape_the_Battleship" SS_achievements matches 0 run title @a actionbar hud:achievement:escape_the_battleship.finished
execute if score "Escape_the_Battleship" SS_achievements matches 0 run function spark/achievement/progress_update
execute if score "Escape_the_Battleship" SS_achievements matches 0 run scoreboard players add .max hotbar_stamina_size 1
scoreboard players set "Escape_the_Battleship" SS_achievements 1
event entity @e[family=achievement_display] spark:update
playsound sound.spark.achievement @a