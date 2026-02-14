#
tag @e remove me
tag @s add me

#
tag @e[family=ship_droid] add old
function spark/ship_game/swarm/type

execute as @s at @s rotated ~ 0 positioned ^ ^ ^54 run fill ~-8 ~-3 ~-8 ~8 ~-3 ~8 spark:force_box_collision replace air
execute as @s at @s rotated ~ 0 positioned ^ ^ ^54 run spreadplayers ~ ~ 7 8 @e[family=ship_droid,tag=!old]
execute as @s at @s rotated ~ 0 positioned ^ ^ ^54 run fill ~-8 ~-3 ~-8 ~8 ~-3 ~8 air replace spark:force_box_collision

scoreboard players random @e[family=ship_droid,tag=!old] t1 0 10

execute as @e[family=ship_droid,tag=!old] at @s run tp @s ~ ~ ~ facing @p[tag=me]
execute as @e[family=ship_droid,tag=!old] at @s run tp @s ~ ~ ~ ~50 0
execute as @e[family=ship_droid,tag=!old] at @s run function spark/ship_game/swarm/rotate
tag @e[family=ship_droid,tag=!old] add loner

scoreboard players random @s spawn_loner 20 110