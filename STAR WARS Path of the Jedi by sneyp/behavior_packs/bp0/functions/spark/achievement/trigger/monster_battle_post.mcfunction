# © Spark Universe, 2023
# authors: FetchBot
# description: trigger the unlocking of an achievement
# called by: <TBD>

execute if score "Monster_Battle_Arena_Post" SS_achievements matches 0 run title @a actionbar hud:achievement:monster_battle_arena.challenge
scoreboard players set "Monster_Battle_Arena_Post" SS_achievements 1
event entity @e[family=achievement_display] spark:update

playsound sound.spark.achievement @a