#execute as @s[scores={item.type=1}] at @s run tag @s add use_grab
#execute as @s[scores={item.type=1}] at @s run function spark/force/player/force/grab/loop
#execute as @s[scores={item.type=1}] at @s run tag @s remove use_grab
execute as @s[scores={item.type=1}] at @s run function spark/force/player/force/grab/end
execute as @s[scores={item.type=2}] at @s run function spark/force/player/force/pull/end
execute as @s[scores={item.type=3}] at @s run function spark/force/player/force/push/end
execute as @s[scores={item.type=4}] at @s run function spark/force/player/force/insight/end

scoreboard players set @s item.type 0