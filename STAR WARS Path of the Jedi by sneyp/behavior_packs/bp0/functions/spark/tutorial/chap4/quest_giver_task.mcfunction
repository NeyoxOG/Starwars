execute if score .hub glob_mission_state matches 1 unless score .completed SS_achievements matches 4.. run scoreboard players set @s SS_ui_tutorial 40
execute if score .hub glob_mission_state matches 1 unless score .completed SS_achievements matches 4.. run scoreboard players set @s SS_ui_task 9999

execute if score .hub glob_mission_state matches 1 if score .completed SS_achievements matches 4 run scoreboard players set @s SS_ui_tutorial 41
#execute if score .completed SS_achievements matches 5 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"main_hall.hint.replay_quests", "with": [ "\n" ] }]}

execute unless score .completed SS_achievements matches 5.. if score "Droid_Survival" SS_achievements matches 1 run event entity @e[type=spark:mace_windu] spark:disable_quest_icon
execute unless score .completed SS_achievements matches 5.. if score "Lightsaber_Duelling" SS_achievements matches 1 run event entity @e[type=spark:kelleran_beq] spark:disable_quest_icon
execute unless score .completed SS_achievements matches 5.. if score "Escape_the_Battleship" SS_achievements matches 1 run event entity @e[type=spark:anakin_skywalker] spark:disable_quest_icon
execute unless score .completed SS_achievements matches 5.. if score "Monster_Battle_Arena" SS_achievements matches 1 run event entity @e[type=spark:obi_wan_kenobi] spark:disable_quest_icon

# need to detect if anakin and ahsoka are not in the are
# if they arnt, trigger a script event to spawn them in!
scriptevent spark:enforce

execute if score "Droid_Survival" SS_achievements matches 5.. run event entity @e[type=spark:mace_windu,tag=!reenabled] spark:enable_quest_icon
execute if score "Droid_Survival" SS_achievements matches 5.. run tag @e[type=spark:mace_windu,tag=!reenabled] add reenabled
execute if score "Escape_the_Battleship" SS_achievements matches 5.. run event entity @e[type=spark:anakin_skywalker,tag=!reenabled] spark:enable_quest_icon
execute if score "Escape_the_Battleship" SS_achievements matches 5.. run tag @e[type=spark:anakin_skywalker,tag=!reenabled] add reenabled
execute if score "Monster_Battle_Arena" SS_achievements matches 5.. run event entity @e[type=spark:obi_wan_kenobi,tag=!reenabled] spark:enable_quest_icon
execute if score "Monster_Battle_Arena" SS_achievements matches 5.. run tag @e[type=spark:obi_wan_kenobi,tag=!reenabled] add reenabled
execute if score "Lightsaber_Duelling" SS_achievements matches 5.. run event entity @e[type=spark:kelleran_beq,tag=!reenabled] spark:enable_quest_icon
execute if score "Lightsaber_Duelling" SS_achievements matches 5.. run tag @e[type=spark:kelleran_beq,tag=!reenabled] add reenabled