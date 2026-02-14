# © Spark Universe, 2023
# authors: FetchBot
# description: add a display duelist to the lobby
# called by: 
# executor: spark:duel_force_field

effect @e[family=duel_opponent] clear
execute if entity @s[tag=enabled] if score ".global" dueling_rank matches 9.. run scoreboard players random ".next_duel" dueling_rank 0 8
execute if score ".global" dueling_rank matches ..8 run scoreboard players operation ".next_duel" dueling_rank = ".global" dueling_rank
execute if score ".next_duel" dueling_rank matches 0 run effect @e[type=spark:quilo_zanx,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 1 run effect @e[type=spark:thelo_jarn,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 2 run effect @e[type=spark:larno_ruhuk,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 3 run effect @e[type=spark:jedi_temple_guard,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 4 run effect @e[type=spark:stass_allie,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 5 run effect @e[type=spark:shaak_ti,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 6 run effect @e[type=spark:ki_adi_mundi,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 7 run effect @e[type=spark:plo_koon,r=50] invisibility 1000000 0 true
execute if score ".next_duel" dueling_rank matches 8 run effect @e[type=spark:kit_fisto,r=50] invisibility 1000000 0 true

event entity @e[family=duel_opponent,r=10] spark:despawn

execute if score ".next_duel" dueling_rank matches 0 run summon spark:quilo_zanx ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 1 run summon spark:thelo_jarn ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 2 run summon spark:larno_ruhuk ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 3 run summon spark:jedi_temple_guard ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 4 run summon spark:stass_allie ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 5 run summon spark:shaak_ti ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 6 run summon spark:ki_adi_mundi ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 7 run summon spark:plo_koon ~-8 ~ ~ -90 0 
execute if score ".next_duel" dueling_rank matches 8 run summon spark:kit_fisto ~-8 ~ ~ -90 0 

execute if entity @s[tag=enabled] run event entity @e[family=duel_opponent,tag=!sitting,r=10] spark:display