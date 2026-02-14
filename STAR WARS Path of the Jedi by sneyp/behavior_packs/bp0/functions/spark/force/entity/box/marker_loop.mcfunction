# execute at @s[tag=size_1_blocks] unless entity @e[type=spark:box,r=1] run fill ~ ~0 ~ ~ ~0 ~ air replace spark:force_box_collision
# execute at @s[tag=size_2_blocks] unless entity @e[type=spark:box,r=1] run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1.99 ~0.5 air replace spark:force_box_collision
# execute at @s[tag=size_3_blocks] unless entity @e[type=spark:box,r=1] run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2.99 ~1.0 air replace spark:force_box_collision
# execute at @s[tag=size_5_blocks] unless entity @e[type=spark:box,r=1] run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4.99 ~2.0 air replace spark:force_box_collision
# execute at @s unless entity @e[type=spark:box,r=1] run event entity @s spark:despawn

execute at @s[tag=size_1_blocks] unless entity @e[tag=force_cube,r=1] run fill ~ ~0 ~ ~ ~0 ~ air replace spark:force_box_collision
execute at @s[tag=size_2_blocks] unless entity @e[tag=force_cube,r=1] run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1.99 ~0.5 air replace spark:force_box_collision
execute at @s[tag=size_3_blocks] unless entity @e[tag=force_cube,r=1] run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2.99 ~1.0 air replace spark:force_box_collision
execute at @s[tag=size_5_blocks] unless entity @e[tag=force_cube,r=1] run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4.99 ~2.0 air replace spark:force_box_collision
execute at @s unless entity @e[tag=force_cube,r=1] run event entity @s spark:despawn