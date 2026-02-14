#
execute as @s[tag=size_1] at @s run fill ~ -62 ~ ~ -62 ~ water replace spark:force_box_collision
execute as @s[tag=size_2] at @s run fill ~-0.5 -62 ~-0.5 ~0.5 -61 ~0.5 water replace spark:force_box_collision
execute as @s[tag=size_3] at @s run fill ~-1.0 -62 ~-1.0 ~1.0 -61 ~1.0 water replace spark:force_box_collision
execute as @s[tag=size_5] at @s run fill ~-2.0 -62 ~-2.0 ~2.0 -61 ~2.0 water replace spark:force_box_collision

#
execute as @s[tag=size_1] at @s run fill ~ ~0 ~ ~ ~0 ~ air replace spark:force_box_collision
execute as @s[tag=size_2] at @s run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1.99 ~0.5 air replace spark:force_box_collision
execute as @s[tag=size_3] at @s run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2.99 ~1.0 air replace spark:force_box_collision
execute as @s[tag=size_5] at @s run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4.99 ~2.0 air replace spark:force_box_collision

#
function spark/force/entity/box/stuck_adjust

event entity @s spark:set_force_effect_grab

# scoreboard players set @e[type=spark:box,r=10] check_time 5
scoreboard players set @e[tag=force_cube,r=10] check_time 5