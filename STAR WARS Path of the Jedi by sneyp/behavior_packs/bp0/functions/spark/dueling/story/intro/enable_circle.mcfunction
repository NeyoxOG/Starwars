execute positioned 8989.5 22.00 8975.5 as @e[type=spark:duel_force_field,r=1] run tag @s add enabled
execute positioned 8989.5 22.00 8975.5 as @e[type=spark:duel_force_field,tag=enabled] run event entity @s spark:enable_ring
scoreboard players set ".ring_enabled" dueling_story 1