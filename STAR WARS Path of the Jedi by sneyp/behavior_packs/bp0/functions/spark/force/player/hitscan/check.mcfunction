#

#execute if entity @e[family=force,r=1.2] run tag @e[family=force,r=1.3,c=1] add hitscan_hit
#execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~-0.7 ~ if entity @e[family=force,r=1.3] run tag @e[family=force,r=1.2,c=1] add hitscan_hit
#execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~-2.5 ~ if entity @e[family=force,r=2.5,tag=size_5] run tag @e[family=force,r=2.5,c=1] add hitscan_hit
#execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~-1.5 ~ if entity @e[family=force,r=1.5,tag=size_3] run tag @e[family=force,r=1.5,c=1] add hitscan_hit
#execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~-1 ~ if entity @e[family=force,r=1,tag=size_2] run tag @e[family=force,r=1,c=1] add hitscan_hit

execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~1.6 ~ run tag @e[family=force,type=spark:marksman_droid,r=3] add hitscan_hit
execute unless entity @e[tag=hitscan_hit,family=force] positioned ~ ~1.6 ~ if entity @e[family=force,dx=0,dy=0,dz=0] run tag @e[family=force,dx=0,dy=0,dz=0,c=1] add hitscan_hit
execute as @a at @s positioned ~ ~-1.5 ~ run tag @e[family=force,dx=0,dy=0,dz=0,c=1] remove hitscan_hit 

execute if entity @s[tag=grab_success] run tag @e remove hitscan_hit

execute if entity @e[tag=hitscan_hit,family=force] run tag @s add end_hitscan
execute unless block ~ ~1.5 ~ air run tag @s add end_hitscan
execute as @s[tag=!grab_success] if block ~ ~1.6 ~ spark:force_box_collision run tag @s remove end_hitscan

execute if entity @s[tag=end_hitscan] run function spark/force/player/hitscan/marker