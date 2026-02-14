# © Spark Universe, 2023
# authors: Jannis
# description: Set up the instanced room
# called by: ../setup_instances
# executor: player

# reset
event entity @e[type=spark:duel_force_field,r=10] spark:despawn
event entity @e[type=spark:duel_leaderboard,r=50] spark:despawn
event entity @e[family=duel_opponent,r=50] spark:despawn
event entity @e[type=spark:lightsaber_form_book,r=50] spark:despawn

# entities
summon spark:duel_force_field ~ ~ ~ 0 0 spark:enable_shield
execute as @e[type=spark:duel_force_field,c=1] run function spark/dueling/instance/enable_shield
event entity @e[type=spark:duel_force_field,r=1] spark:disable_ring
summon spark:jedi_temple_guard ~4 ~1 ~18.8 180 0 spark:sitting
summon spark:thelo_jarn ~2 ~1 ~18.8 180 0 spark:sitting
summon spark:larno_ruhuk ~ ~1 ~18.8 180 0 spark:sitting
summon spark:ki_adi_mundi ~-3 ~1 ~18.8 180 0 spark:sitting
summon spark:stass_allie ~-5 ~1 ~18.8 180 0 spark:sitting
summon spark:shaak_ti ~20.8 ~1 ~ 90 0 spark:sitting
summon spark:plo_koon ~20.8 ~1 ~6 90 0 spark:sitting
summon spark:quilo_zanx ~20.8 ~1 ~-6 90 0 spark:sitting
summon spark:kit_fisto ~20.8 ~1 ~-10 90 0 spark:sitting
tag @e[family=duel_opponent,r=50] add sitting

function spark/dueling/place_display_duelist