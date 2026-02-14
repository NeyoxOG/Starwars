# © Spark Universe, 2023
# authors: FetchBot
# description: add a display duelist to the lobby
# called by: 
# executor: spark:duel_force_field

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