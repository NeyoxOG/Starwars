tag @e remove me
tag @s add me

tag @e[type=spark:marker] add old

execute rotated ~ 0 positioned ^ ^ ^64 run summon spark:marker

tag @e[type=spark:marker,tag=!old] add spawner

execute as @e[type=spark:marker,tag=spawner] at @s run tp @s ~ ~ ~ facing @p[tag=me]
execute as @e[type=spark:marker,tag=spawner] at @s run tp @s ~ ~ ~ ~ 0
execute as @e[type=spark:marker,tag=spawner] at @s run tp @s ~ ~ ~ ~100 0

scoreboard players random @e[type=spark:marker,tag=spawner] t1 0 16

execute as @e[type=spark:marker,tag=spawner] at @s run function spark/ship_game/swarm/rotate

tag @e[family=ship_droid] add old

scoreboard players random @e[type=spark:marker,tag=spawner] t1 1 3

execute as @e[type=spark:marker,tag=spawner] at @s run function spark/ship_game/swarm/type
execute as @e[type=spark:marker,tag=spawner] at @s run function spark/ship_game/swarm/type
execute as @e[type=spark:marker,tag=spawner] at @s run function spark/ship_game/swarm/type
execute as @e[type=spark:marker,tag=spawner] at @s if score @s t1 matches 2.. run function spark/ship_game/swarm/type
execute as @e[type=spark:marker,tag=spawner] at @s if score @s t1 matches 3.. run function spark/ship_game/swarm/type

execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run fill ~-10 ~-3 ~-10 ~10 ~-3 ~10 spark:force_box_collision replace air
execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run spreadplayers ~ ~ 7 10 @e[family=ship_droid,tag=!old]
execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run spreadplayers ~ ~ 7 10 @e[family=ship_droid,tag=!old,rm=15]
execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run spreadplayers ~ ~ 7 10 @e[family=ship_droid,tag=!old,rm=15]
execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run fill ~-10 ~-3 ~-10 ~10 ~-3 ~10 air replace spark:force_box_collision
execute as @e[type=spark:marker,tag=spawner] at @s rotated ~ 0 positioned ^ ^ ^34 run event entity @e[family=ship_droid,tag=!old,rm=15] spark:despawn

execute as @e[type=spark:marker,tag=spawner] at @s run tp @s ^ ^ ^-20

execute as @e[family=ship_droid,tag=!old] at @s run tp @s ~ ~ ~ facing @e[type=spark:marker,tag=spawner,c=1]
execute as @e[family=ship_droid,tag=!old] at @s run tp @s ~ ~ ~ ~ 0
execute as @e[family=ship_droid,tag=!old] as @r[family=ship_droid,tag=!old] run tp @s ~ ~0.5 ~ 
execute as @e[family=ship_droid,tag=!old] as @r[family=ship_droid,tag=!old] run tp @s ~ ~-0.5 ~
execute as @e[family=ship_droid,tag=!old] as @r[family=ship_droid,tag=!old] run tp @s ~ ~ ~ ~5 ~ 
execute as @e[family=ship_droid,tag=!old] as @r[family=ship_droid,tag=!old] run tp @s ~ ~ ~ ~-5 ~

tag @s remove me
kill @e[type=spark:marker,tag=spawner]

scoreboard players random @s spawn_hoard 30 120
scoreboard players operation @s spawn_hoard += @s area_fatigue

scoreboard players add @s area_fatigue 10