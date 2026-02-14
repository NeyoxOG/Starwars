
effect @a invisibility 1 1 true
scoreboard players add cutscene dueling_story 1
# effect @a slowness 3 3 true
# execute if score cutscene dueling_story matches 1 positioned 8982.01 22.00 8975.54 run event entity @e[family=duel_opponent,tag=!sitting,r=4] spark:reset_npc
execute if score cutscene dueling_story matches 1 run scoreboard players set @a SS_ui_task 0
execute if score cutscene dueling_story matches 1 positioned 8982.01 22.00 8975.54 as @e[family=duel_opponent,tag=!sitting,r=4] at @s run tp @s ~ ~ ~ -90 0 
execute if score cutscene dueling_story matches 1 run inputpermission set @a movement disabled
execute if score cutscene dueling_story matches 1 run inputpermission set @a camera disabled
execute if score cutscene dueling_story matches 1 run gamemode spectator @a
# execute if score cutscene dueling_story matches 1 run title @a actionbar hud:
execute if entity @e[tag=!sitting,type=spark:kit_fisto,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:plo_koon,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:ki_adi_mundi,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:shaak_ti,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:stass_allie,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:jedi_temple_guard,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:larno_ruhuk,r=50] run function spark/dueling/cutscene/opponent_intro
execute if entity @e[tag=!sitting,type=spark:thelo_jarn,r=50] run function spark/dueling/cutscene/opponent_intro_tall
execute if entity @e[tag=!sitting,type=spark:quilo_zanx,r=50] run function spark/dueling/cutscene/opponent_intro_tall
execute if score cutscene dueling_story matches 1 as @e[type=spark:duel_force_field,tag=enabled] at @s run function  spark/dueling/instance/enable_shield
execute if score cutscene dueling_story matches 1 run event entity @e[family=duel_opponent,tag=!sitting] spark:run_cutscene
execute if score cutscene dueling_story matches 101 run function spark/dueling/cutscene/end
execute if score cutscene dueling_story matches 101 as @e[type=spark:duel_force_field,tag=enabled] at @s run function  spark/dueling/instance/disable_shield
execute if score cutscene dueling_story matches 101 unless score .global dueling_rank matches 1.. run scoreboard players set @a SS_ui_task 20