#
tag @e[type=spark:marker_force] add old
summon spark:marker_force ~ ~ ~

tag @e[type=spark:marker_force,tag=!old] add scan_marker
tag @e[type=spark:marker_force,tag=!old] add kill

execute if entity @s[scores={item.type=1}] as @e[tag=scan_marker,c=1] at @s run tp @s ~ ~1.71 ~
execute if entity @s[scores={item.type=2}] run tp @e[tag=scan_marker] @e[tag=hitscan_hit,family=force,c=1]

tag @s add end_hitscan