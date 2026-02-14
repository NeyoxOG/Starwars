# © Spark Universe, 2023
# authors: destruc7i0n, William Savage
# description: Setup scoreboards, etc.
# called by: 

function spark/companion/save/delete_all_saves

scoreboard objectives add pet_id dummy
scoreboard objectives add pet_load dummy

event entity @e[family=companion,tag=!npc] spark:despawn

tag @e remove tamer
tag @e remove tamed

tickingarea add circle 0 0 287 2 pet_area true
fill -16 0 271 0 0 287 stone
