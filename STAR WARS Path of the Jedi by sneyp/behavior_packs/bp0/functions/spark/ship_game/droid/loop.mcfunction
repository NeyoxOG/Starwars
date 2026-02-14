scoreboard players add @s t1 1
event entity @s[scores={t1=500..}] spark:despawn
execute at @s unless entity @p[r=100] run event entity @s spark:despawn

execute at @s if entity @p[r=12] run scoreboard players add @s t1 10
execute at @s if entity @p[r=12] run tp @s ^ ^0.3 ^0.1 true

execute at @s positioned ~ ~1000 ~ if entity @p[r=996] run tp @s ~ ~0.1 ~ true

execute at @s run tp @s @s
execute at @s run tp @s ^ ^ ^0.3 true

execute at @s unless block ^ ^ ^1 air run scoreboard players add @s t2 1
execute at @s unless block ^ ^ ^1 air run tp @s ~ ~0.2 ~
execute at @s[tag=left] unless block ^ ^ ^1 air run tp @s ~ ~ ~ ~-5 ~
execute at @s[tag=right] unless block ^ ^ ^1 air run tp @s ~ ~ ~ ~5 ~

event entity @s[scores={t2=40..}] spark:despawn
