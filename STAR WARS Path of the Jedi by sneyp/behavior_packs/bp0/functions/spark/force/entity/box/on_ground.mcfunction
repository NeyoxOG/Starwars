#
execute at @s run tp @s[ry=-135] ~ ~ ~ -180
execute at @s run tp @s[rym=-135,ry=-45] ~ ~ ~ -90
execute at @s run tp @s[rym=-45,ry=45] ~ ~ ~ 0
execute at @s run tp @s[rym=45,ry=135] ~ ~ ~ 90
execute at @s run tp @s[rym=135] ~ ~ ~ 180

execute at @s run playsound sound.spark.force_grab_fall @a ~ ~ ~

execute at @s[tag=size_1] positioned ~ ~ ~ align xz run tp @s ~ ~ ~
execute as @s[tag=size_1] at @s positioned ~ ~ ~ align xz run fill ~ ~ ~ ~ ~ ~ spark:force_box_collision replace air
execute as @s[tag=size_1] at @s positioned ~ ~ ~ align xz run fill ~ ~ ~ ~ ~ ~ spark:force_box_collision replace water
execute as @s[tag=size_1] at @s positioned ~ ~ ~ align xz run fill ~ ~ ~ ~ ~ ~ spark:force_box_collision replace flowing_water
execute as @s[tag=size_1] at @s positioned ~ ~ ~ align xz run fill ~ ~ ~ ~ ~ ~ spark:force_box_collision replace light_block

execute at @s[tag=size_2] positioned ~0.5 ~ ~0.5 align xz run tp @s ~ ~ ~
execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xz run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1 ~0.5 spark:force_box_collision replace air
execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xz run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1 ~0.5 spark:force_box_collision replace water
execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xz run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1 ~0.5 spark:force_box_collision replace flowing_water
execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xz run fill ~-0.5 ~0 ~-0.5 ~0.5 ~1 ~0.5 spark:force_box_collision replace light_block
execute at @s[tag=size_3] positioned ~ ~ ~ align xz run tp @s ~ ~ ~
execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xz run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2 ~1.0 spark:force_box_collision replace air
execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xz run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2 ~1.0 spark:force_box_collision replace water
execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xz run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2 ~1.0 spark:force_box_collision replace flowing_water
execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xz run fill ~-1.0 ~0 ~-1.0 ~1.0 ~2 ~1.0 spark:force_box_collision replace light_block
execute at @s[tag=size_5] positioned ~ ~ ~ align xz run tp @s ~ ~ ~
execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xz run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4 ~2.0 spark:force_box_collision replace air
execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xz run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4 ~2.0 spark:force_box_collision replace water
execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xz run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4 ~2.0 spark:force_box_collision replace flowing_water
execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xz run fill ~-2.0 ~0 ~-2.0 ~2.0 ~4 ~2.0 spark:force_box_collision replace light_block

#
kill @e[tag=stuck_check]

tag @e[type=spark:marker_force] add old
summon spark:marker_force ~ ~ ~
tag @e[type=spark:marker_force,tag=!old] add stuck_check

tag @s add glass_placer
# execute at @s positioned ~ ~3 ~ as @e[r=5,tag=!glass_placer,type=spark:box,tag=!solid] at @s run tp @s @s true
# execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,type=spark:box,tag=!solid] at @s if block ~ ~ ~ spark:force_box_collision run tp @s ~ ~1 ~
# execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,type=spark:box,tag=!solid] at @s run tp @s ~ ~0.5 ~ true
# execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,type=spark:box,tag=!solid] at @s run tp @s ~ ~0.5 ~ true
# execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,type=spark:box,tag=!solid] at @s run tag @s add dump
# execute at @s[tag=size_5] positioned ~ ~2.5 ~ as @e[r=5,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=!spark:box] at @s run function spark/force/entity/box/position_correct
# execute at @s[tag=size_3] positioned ~ ~1.5 ~ as @e[r=2.5,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=!spark:box] at @s run function spark/force/entity/box/position_correct
# execute at @s[tag=size_2] positioned ~ ~1 ~ as @e[r=2,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=!spark:box] at @s run function spark/force/entity/box/position_correct

# execute at @s[tag=size_5] positioned ~ ~2.5 ~ as @e[r=9,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=spark:box,tag=!solid] at @s run function spark/force/entity/box/position_correct
# execute at @s[tag=size_3] positioned ~ ~1.5 ~ as @e[r=7,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=spark:box,tag=!solid] at @s run function spark/force/entity/box/position_correct
# execute at @s[tag=size_2] positioned ~ ~1 ~ as @e[r=7,tag=!glass_placer,tag=!insight,tag=!stuck_check,type=spark:box,tag=!solid] at @s run function spark/force/entity/box/position_correct

execute at @s positioned ~ ~3 ~ as @e[r=5,tag=!glass_placer,tag=force_cube,tag=!solid] at @s run tp @s @s true
execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,tag=force_cube,tag=!solid] at @s if block ~ ~ ~ spark:force_box_collision run tp @s ~ ~1 ~
execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,tag=force_cube,tag=!solid] at @s run tp @s ~ ~0.5 ~ true
execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,tag=force_cube,tag=!solid] at @s run tp @s ~ ~0.5 ~ true
execute at @s positioned ~ ~3 ~ as @e[r=4,tag=!glass_placer,tag=force_cube,tag=!solid] at @s run tag @s add dump
execute at @s[tag=size_5] positioned ~ ~2.5 ~ as @e[r=5,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=!force_cube,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_3] positioned ~ ~1.5 ~ as @e[r=2.5,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=!force_cube,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_2] positioned ~ ~1 ~ as @e[r=2,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=!force_cube,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_1] positioned ~ ~ ~ as @e[r=2,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=!force_cube,tag=!pz_static] at @s run function spark/force/entity/box/position_correct

execute at @s[tag=size_5] positioned ~ ~2.5 ~ as @e[r=9,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=force_cube,tag=!solid,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_3] positioned ~ ~1.5 ~ as @e[r=7,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=force_cube,tag=!solid,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_2] positioned ~ ~1 ~ as @e[r=7,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=force_cube,tag=!solid,tag=!pz_static] at @s run function spark/force/entity/box/position_correct
execute at @s[tag=size_1] positioned ~ ~ ~ as @e[r=7,tag=!glass_placer,tag=!insight,tag=!stuck_check,tag=force_cube,tag=!solid,tag=!pz_static] at @s run function spark/force/entity/box/position_correct


execute as @s[scores={fall_time=16..}] run summon spark:force_push ~ ~ ~ 0 0 spark:force_push

#
#tag @e[type=spark:box] add old_spawn

#execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xyz run summon spark:box ~ ~ ~ ~ ~ spark:size_2_solid
#execute as @s[tag=size_2] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_2

#execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xyz run summon spark:box ~0.5 ~ ~0.5 ~ ~ spark:size_3_solid
#execute as @s[tag=size_3] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_3

#execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xyz run summon spark:box ~0.5 ~ ~0.5 ~ ~ spark:size_5_solid
#execute as @s[tag=size_5] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_5

#tag @e[type=spark:box,tag=!old_spawn] add solid

#
#tag @s add kill
#event entity @s spark:despawn

#
execute as @s[tag=size_1] at @s run event entity @s spark:size_1_solid
execute as @s[tag=size_2] at @s run event entity @s spark:size_2_solid
execute as @s[tag=size_3] at @s run event entity @s spark:size_3_solid
execute as @s[tag=size_5] at @s run event entity @s spark:size_5_solid

execute as @s at @s run tp @s @s
execute as @s[tag=size_1] at @s positioned ~0.5 ~ ~0.5 align xyz run tp @s ~0.5 ~ ~0.5
execute as @s[tag=size_2] at @s positioned ~0.5 ~ ~0.5 align xyz run tp @s ~ ~ ~
execute as @s[tag=size_3] at @s positioned ~ ~ ~ align xyz run tp @s ~0.5 ~ ~0.5
execute as @s[tag=size_5] at @s positioned ~ ~ ~ align xyz run tp @s ~0.5 ~ ~0.5

tag @s add solid

tag @s remove glass_placer

#
scoreboard players set @s check_time 10

#
tag @e[type=spark:marker] add old
execute at @s run summon spark:marker
execute as @s run tag @e[type=spark:marker,tag=!old] add force_blocks_marker
execute as @s[tag=size_1] run tag @e[type=spark:marker,tag=!old] add size_1_blocks
execute as @s[tag=size_2] run tag @e[type=spark:marker,tag=!old] add size_2_blocks
execute as @s[tag=size_3] run tag @e[type=spark:marker,tag=!old] add size_3_blocks
execute as @s[tag=size_5] run tag @e[type=spark:marker,tag=!old] add size_5_blocks

#
event entity @s spark:set_force_effect_none