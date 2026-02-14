#
scoreboard players add @s timer 1
execute if score @s timer matches 1 run particle spark:calling_star ~ ~1 ~
scoreboard players set @s[scores={timer=50..}] timer 0

#
execute if entity @p[r=7] run tag @s add move_next

# execute if entity @e[type=spark:marker,tag=follow_particle,r=1] run event entity @e[type=spark:marker,tag=follow_particle] spark:despawn

# execute as @s[tag=move_next] run event entity @e[type=spark:marker,tag=follow_particle] spark:despawn
# execute as @s[tag=move_next] run tag @e[type=spark:marker] add old
# execute as @s[tag=move_next] run summon spark:marker ~~~
# execute as @s[tag=move_next] run tag @e[type=spark:marker,tag=!old] add follow_particle

# # execute as @s[tag=move_next] run execute as @e[type=spark:marker,tag=follow_particle] at @e[c=1,type=spark:marker,tag=calling_star] run tp ~~~
# execute as @e[type=spark:marker,tag=follow_particle] at @s run teleport ~~~ facing @e[c=1,type=spark:marker,tag=calling_star]
# execute as @e[type=spark:marker,tag=follow_particle] at @s run teleport ^ ^0.1 ^0.5 ~~ false
# execute as @e[type=spark:marker,tag=follow_particle] at @s run particle spark:force_guide ~ ~1.25 ~

#
execute as @s[tag=move_next] run scoreboard players add .star_call tutorial 1




## sounds
execute as @s[tag=has_moved] at @s if score .star_call tutorial matches ..25 if score .ice_path tutorial matches 1 run playsound sound.spark.force_particle @a ~ ~ ~ 10
execute as @s[tag=has_moved] at @s if score .star_call tutorial matches ..14 if score .ice_path tutorial matches 2 run playsound sound.spark.force_particle @a ~ ~ ~ 10
execute as @s[tag=has_moved] at @s if score .star_call tutorial matches ..21 if score .ice_path tutorial matches 3 run playsound sound.spark.force_particle @a ~ ~ ~ 10
execute as @s[tag=has_moved] run tag @s remove has_moved
execute as @s[tag=move_next] run tag @s add has_moved

# first hint disabler for lag reasons
scoreboard players add .lag_fix_star tutorial 0

# hints
execute if score .star_call tutorial matches 0 if score .lag_fix_star tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.calling.tip1", "with": [ "\n" ] }]}
execute if score .star_call tutorial matches 0 if score .lag_fix_star tutorial matches 0 run scoreboard players add .lag_fix_star tutorial 1

execute as @s[tag=move_next] if score .star_call tutorial matches 6 if score .ice_path tutorial matches 1 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.move_objects.tip1", "with": [ "\n" ] }]}
execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 1 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.double_jump.tip1", "with": [ "\n" ] }]}

execute as @s[tag=move_next] if score .star_call tutorial matches 6 if score .ice_path tutorial matches 2 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.move_objects.tip1", "with": [ "\n" ] }]}
execute as @s[tag=move_next] if score .star_call tutorial matches 4 if score .ice_path tutorial matches 2 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.double_jump.tip1", "with": [ "\n" ] }]}

execute as @s[tag=move_next] if score .star_call tutorial matches 7 if score .ice_path tutorial matches 3 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.move_objects.tip1", "with": [ "\n" ] }]}
execute as @s[tag=move_next] if score .star_call tutorial matches 5 if score .ice_path tutorial matches 3 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.ilum_caves.tip.double_jump.tip1", "with": [ "\n" ] }]}

# remove calling tutorial message
execute as @s[tag=move_next] if score .star_call tutorial matches 4 run scoreboard players set @s SS_ui_tutorial 0

execute as @s[tag=move_next] if score .star_call tutorial matches 1 run tp @s -185.5 -28 3051.5

execute as @s[tag=move_next] if score .star_call tutorial matches 2 if score .ice_path tutorial matches 1 run tp @s -179.5 -26 3079.5
execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 1 run tp @s -184.5 -26 3098.5
execute as @s[tag=move_next] if score .star_call tutorial matches 4 if score .ice_path tutorial matches 1 run tp @s -188.5 -26 3113.5
execute as @s[tag=move_next] if score .star_call tutorial matches 5 if score .ice_path tutorial matches 1 run tp @s -218.5 -26 3115.5
execute as @s[tag=move_next] if score .star_call tutorial matches 6 if score .ice_path tutorial matches 1 run tp @s -242.5 -29 3123.5
execute as @s[tag=move_next] if score .star_call tutorial matches 7 if score .ice_path tutorial matches 1 run tp @s -257.5 -30 3118.5

# fine
# execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 1 run execute positioned -232 -24 3122 run function spark/force/entity/box/create_size_3

# fine
# execute as @s[tag=move_next] if score .star_call tutorial matches 5 if score .ice_path tutorial matches 1 run execute positioned -262 -28 3126 run function spark/force/entity/box/create_size_3

execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 1 run tp @s -278.5 -31 3135.5
execute as @s[tag=move_next] if score .star_call tutorial matches 9 if score .ice_path tutorial matches 1 run tp @s -298.5 -30 3134.5
execute as @s[tag=move_next] if score .star_call tutorial matches 10 if score .ice_path tutorial matches 1 run tp @s -325.5 -29 3141.5
execute as @s[tag=move_next] if score .star_call tutorial matches 11 if score .ice_path tutorial matches 1 run tp @s -350.5 -33 3143.5
execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 1 run tp @s -357.5 -32 3148.5
execute as @s[tag=move_next] if score .star_call tutorial matches 13 if score .ice_path tutorial matches 1 run tp @s -361.5 -30 3158.5
execute as @s[tag=move_next] if score .star_call tutorial matches 14 if score .ice_path tutorial matches 1 run tp @s -357.5 -28 3173.5
execute as @s[tag=move_next] if score .star_call tutorial matches 15 if score .ice_path tutorial matches 1 run tp @s -374.5 -29 3163.5
execute as @s[tag=move_next] if score .star_call tutorial matches 16 if score .ice_path tutorial matches 1 run tp @s -385.5 -27 3175.5
execute as @s[tag=move_next] if score .star_call tutorial matches 17 if score .ice_path tutorial matches 1 run tp @s -388.5 -29 3164.5
execute as @s[tag=move_next] if score .star_call tutorial matches 18 if score .ice_path tutorial matches 1 run tp @s -404.5 -27 3155.5


# fine
# execute as @s[tag=move_next] if score .star_call tutorial matches 13 if score .ice_path tutorial matches 1 run execute positioned -393 -27 3159 run function spark/force/entity/box/create_size_3
# fine
# execute as @s[tag=move_next] if score .star_call tutorial matches 18 if score .ice_path tutorial matches 1 run execute positioned -387 -22 3120 run function spark/force/entity/box/create_size_3
execute as @s[tag=move_next] if score .star_call tutorial matches 19 if score .ice_path tutorial matches 1 run tp @s -413.5 -27 3142.5
execute as @s[tag=move_next] if score .star_call tutorial matches 20 if score .ice_path tutorial matches 1 run tp @s -404.5 -26 3130.5
execute as @s[tag=move_next] if score .star_call tutorial matches 21 if score .ice_path tutorial matches 1 run tp @s -404.5 -24 3122.5
execute as @s[tag=move_next] if score .star_call tutorial matches 22 if score .ice_path tutorial matches 1 run tp @s -376.5 -25 3124.5
execute as @s[tag=move_next] if score .star_call tutorial matches 23 if score .ice_path tutorial matches 1 run tp @s -360.5 -25 3136.5
execute as @s[tag=move_next] if score .star_call tutorial matches 24 if score .ice_path tutorial matches 1 run tp @s -373.5 -24 3143.5
execute as @s[tag=move_next] if score .star_call tutorial matches 25 if score .ice_path tutorial matches 1 run tp @s -373.5 -48 3143.5


execute as @s[tag=move_next] if score .star_call tutorial matches 18 if score .ice_path tutorial matches 1 run setblock -372 -46 3119 light_block["block_light_level"=15]
# execute as @s[tag=move_next] if score .star_call tutorial matches 18 if score .ice_path tutorial matches 1 run summon spark:kyber_crystal_altar -371.5 -49.00 3119.5

# path 2
execute as @s[tag=move_next] if score .star_call tutorial matches 2 if score .ice_path tutorial matches 2 run tp @s -215.5 -28 3055.5
execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 2 run tp @s -248.5 -27 3053.5
execute as @s[tag=move_next] if score .star_call tutorial matches 4 if score .ice_path tutorial matches 2 run tp @s -278.5 -28 3045.5

execute as @s[tag=move_next] if score .star_call tutorial matches 5 if score .ice_path tutorial matches 2 run tp @s -308.5 -26.5 3040.5
execute as @s[tag=move_next] if score .star_call tutorial matches 6 if score .ice_path tutorial matches 2 run tp @s -325.5 -25 3040.5
execute as @s[tag=move_next] if score .star_call tutorial matches 7 if score .ice_path tutorial matches 2 run tp @s -355.5 -29 3038.5
execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 2 run tp @s -389.0 -34 3035.0
execute as @s[tag=move_next] if score .star_call tutorial matches 9 if score .ice_path tutorial matches 2 run tp @s -410.0 -32 3034.0


# fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 2 run execute positioned -313 -26 3040 run function spark/force/entity/box/create_size_3

execute as @s[tag=move_next] if score .star_call tutorial matches 10 if score .ice_path tutorial matches 2 run tp @s -436.5 -30 3041.5
execute as @s[tag=move_next] if score .star_call tutorial matches 11 if score .ice_path tutorial matches 2 run tp @s -446.0 -29 3055.0
execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 2 run tp @s -426.0 -29 3060.0
execute as @s[tag=move_next] if score .star_call tutorial matches 13 if score .ice_path tutorial matches 2 run tp @s -412.5 -29 3060.0
execute as @s[tag=move_next] if score .star_call tutorial matches 14 if score .ice_path tutorial matches 2 run tp @s -407.5 -28 3076.5


#  fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 2 run execute positioned -444 -28 3044 run function spark/force/entity/box/create_size_3
#  fixed

# moved to not fall in water
# execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 2 run execute positioned -422 -30 3039 run function spark/force/entity/box/create_size_3

#summon kyber crystal
execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 2 run setblock -410 -20 3087 light_block["block_light_level"=15]
execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 2 run summon spark:kyber_crystal_altar -409.5 -23.00 3088.5

#path 3
execute as @s[tag=move_next] if score .star_call tutorial matches 2 if score .ice_path tutorial matches 3 run tp @s -190.5 -25 3032.5
execute as @s[tag=move_next] if score .star_call tutorial matches 3 if score .ice_path tutorial matches 3 run tp @s -202 -21 3006
execute as @s[tag=move_next] if score .star_call tutorial matches 4 if score .ice_path tutorial matches 3 run tp @s -213.5 -19 2997.5
execute as @s[tag=move_next] if score .star_call tutorial matches 5 if score .ice_path tutorial matches 3 run tp @s -216.5 -18 2980.5
execute as @s[tag=move_next] if score .star_call tutorial matches 6 if score .ice_path tutorial matches 3 run tp @s -222.5 -19 2964.5

# fixed ---------------------------------------------
# execute as @s[tag=move_next] if score .star_call tutorial matches 4 if score .ice_path tutorial matches 3 run execute positioned -232 -16 2963 run function spark/force/entity/box/create_size_2
execute as @s[tag=move_next] if score .star_call tutorial matches 7 if score .ice_path tutorial matches 3 run tp @s -246.5 -18 2963.5
execute as @s[tag=move_next] if score .star_call tutorial matches 8 if score .ice_path tutorial matches 3 run tp @s -282.5 -20 2973.5
execute as @s[tag=move_next] if score .star_call tutorial matches 9 if score .ice_path tutorial matches 3 run tp @s -288.5 -20 2960.5
execute as @s[tag=move_next] if score .star_call tutorial matches 10 if score .ice_path tutorial matches 3 run tp @s -322.5 -21 2965.5
execute as @s[tag=move_next] if score .star_call tutorial matches 11 if score .ice_path tutorial matches 3 run tp @s -340.5 -27 2968.5
execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run tp @s -358.5 -23 2981.5
execute as @s[tag=move_next] if score .star_call tutorial matches 13 if score .ice_path tutorial matches 3 run tp @s -378.5 -25 2976.5

# fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 10 if score .ice_path tutorial matches 3 run execute positioned -347 -25 2976 run function spark/force/entity/box/create_size_3
execute as @s[tag=move_next] if score .star_call tutorial matches 14 if score .ice_path tutorial matches 3 run tp @s -406.5 -27 2981.5
execute as @s[tag=move_next] if score .star_call tutorial matches 15 if score .ice_path tutorial matches 3 run tp @s -419.5 -25 2962.5
execute as @s[tag=move_next] if score .star_call tutorial matches 16 if score .ice_path tutorial matches 3 run tp @s -415.5 -23 2948.5
execute as @s[tag=move_next] if score .star_call tutorial matches 17 if score .ice_path tutorial matches 3 run tp @s -400.5 -20 2942.5


# fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run execute positioned -383 -23 2976 run function spark/force/entity/box/create_size_5

# fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run execute positioned -382 -21 2952 run function spark/force/entity/box/create_size_3

# fixed
# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run execute positioned -417 -26 2973 run function spark/force/entity/box/create_size_3

# ok
# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run execute positioned -414 -22 2946 run function spark/force/entity/box/create_size_3

# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run execute positioned -394 -24 2977 run function spark/force/entity/box/create_size_3

execute as @s[tag=move_next] if score .star_call tutorial matches 18 if score .ice_path tutorial matches 3 run tp @s -383.5 -18 2961.5
execute as @s[tag=move_next] if score .star_call tutorial matches 19 if score .ice_path tutorial matches 3 run tp @s -383.5 -18 2961.5
execute as @s[tag=move_next] if score .star_call tutorial matches 20 if score .ice_path tutorial matches 3 run tp @s -395.5 -13 2959.5

execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run setblock -417 -8 2959 light_block["block_light_level"=15]
# execute as @s[tag=move_next] if score .star_call tutorial matches 12 if score .ice_path tutorial matches 3 run summon spark:kyber_crystal_altar -416.5 -11.00 2959.5


# despawn
execute as @s[tag=move_next] if score .star_call tutorial matches 26.. if score .ice_path tutorial matches 1 run event entity @s spark:despawn
execute as @s[tag=move_next] if score .star_call tutorial matches 15.. if score .ice_path tutorial matches 2 run event entity @s spark:despawn
execute as @s[tag=move_next] if score .star_call tutorial matches 21.. if score .ice_path tutorial matches 3 run event entity @s spark:despawn



#
tag @s remove move_next