# © Spark Universe, 2023
# authors: Jannis
# description: Loop during grievouses lawn mower attack
# called by: main loop

scoreboard players add @s timer 1
scoreboard players set @s[scores={timer=5..}] timer 0

execute at @s[scores={timer=1}] positioned ^ ^ ^1 run damage @p[r=2.6,tag=!blocking] 3 magic entity @s
execute at @s[scores={timer=1}] positioned ^ ^ ^1 as @p[r=2.6] positioned ^ ^ ^-1 run function spark/dueling/player_hit


execute at @s positioned ^ ^0.1 ^0.23 run tp @s ~ -53 ~ facing @p[rm=1.8] true