# © Spark Universe, 2023
# authors: William Savage
# description: hides the players companion when they have hide_ui tag
# called by: loop

function spark/companion/checks/tag_player_pet

effect @e[family=companion,tag=player_pet] invisibility 2 1 true
event entity @e[family=companion,tag=player_pet] spark:immobile
tag @e[family=companion,tag=player_pet] remove player_pet