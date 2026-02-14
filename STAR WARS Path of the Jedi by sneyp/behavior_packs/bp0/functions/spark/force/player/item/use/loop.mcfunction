#
scoreboard players add @s item.charge 1

execute as @s[scores={item.charge=1}] at @s run function spark/force/player/item/use/start

execute as @s[tag=use_grab] at @s run function spark/force/player/force/grab/loop
execute as @s[tag=use_pull] at @s run function spark/force/player/force/pull/loop
execute as @s[tag=use_push] at @s run function spark/force/player/force/push/loop
execute as @s[tag=use_insight] at @s run function spark/force/player/force/insight/loop