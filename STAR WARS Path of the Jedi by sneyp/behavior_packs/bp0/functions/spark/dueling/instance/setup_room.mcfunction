# © Spark Universe, 2023
# authors: Jannis
# description: Set up the instanced room
# called by: ../setup_instances
# executor: player

function spark/dueling/instance/setup_entities

summon spark:lightsaber_form_book ~-4 ~1 ~-15 0 0 spark:style_classic
summon spark:lightsaber_form_book ~-2 ~1 ~-15 0 0 spark:style_defensive
summon spark:lightsaber_form_book ~ ~1 ~-15 0 0 spark:style_elegant
summon spark:lightsaber_form_book ~2 ~1 ~-15 0 0 spark:style_power
summon spark:lightsaber_form_book ~4 ~1 ~-15 0 0 spark:style_reverse

summon spark:duel_leaderboard ~19 ~1 ~17 0 0

scoreboard players add @e[type=spark:duel_force_field,r=1] dueling_rank 0
