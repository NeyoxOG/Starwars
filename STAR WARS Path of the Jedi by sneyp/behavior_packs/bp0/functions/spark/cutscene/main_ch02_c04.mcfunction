### main loop of cutscene ch02c04
# called like: execute if score .timer CS_timer matches X run X 
# duration: 825 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
gamemode spectator @a[tag=!dev]
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene




## final player location
execute if score .timer CS_timer matches 825 run tp @a[tag=!dev] 4.5 -25 3021.5 90 -30

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 825 run replaceitem entity @a[tag=!dev] slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer CS_timer matches 825 run replaceitem entity @a[tag=!dev] slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer CS_timer matches 825 run replaceitem entity @a[tag=!dev] slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}


# fix for decal z-fighting
execute if score .timer CS_timer matches 20 run particle spark:decal_floor_ilum_inner 0.5 -24.88 3021.5
execute if score .timer CS_timer matches 20 run particle spark:decal_floor_ilum_middle 0.5 -25.88 3021.5
execute if score .timer CS_timer matches 20 run particle spark:decal_floor_ilum_outer 0.5 -25.88 3021.5
execute if score .timer CS_timer matches 20..820 if score slow SS_time matches 10 run particle spark:decal_floor_ilum_inner 0.5 -24.9 3021.5
execute if score .timer CS_timer matches 20..820 if score slow SS_time matches 10 run particle spark:decal_floor_ilum_middle 0.5 -25.9 3021.5
execute if score .timer CS_timer matches 20..820 if score slow SS_time matches 10 run particle spark:decal_floor_ilum_outer 0.5 -25.9 3021.5

## sound


## UI
execute if score .timer CS_timer matches 19 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 800 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 825 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 824 run tag @a[tag=!dev] remove hide_ui


## load areas
# execute if score .timer CS_timer matches 0 run tickingarea add -7.5 38 3014.5 14.5 82 3028.5 tmp.cutscene.0
# execute if score .timer CS_timer matches 0 run tickingarea add circle 39.5 61 3021.5 1 tmp.cutscene.1
execute if score .timer CS_timer matches 820 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 820 run tickingarea remove tmp.cutscene.1


## models and triggers
execute if score .timer CS_timer matches 40 run fill 14.5 80 3023.5 -7.5 38 3019.5 minecraft:air
execute if score .timer CS_timer matches 40 run fill 7.5 81 3014.5 -6.5 81 3029.5 minecraft:air
execute if score .timer CS_timer matches 20 run event entity @e[type=spark:cutscene.gyro] spark:despawn
execute if score .timer CS_timer matches 20 run summon spark:cutscene.gyro 0.5 38 3021.5 -90 0
execute if score .timer CS_timer matches 20 run event entity @e[type=spark:cutscene.gyro] spark:stage_1
execute if score .timer CS_timer matches 20 run event entity @e[type=spark:cutscene.ilum_window] spark:despawn
execute if score .timer CS_timer matches 20 run summon spark:cutscene.ilum_window 39.5 61 3021.5 90 0
execute if score .timer CS_timer matches 20 run event entity @e[type=spark:cutscene.ilum_window] spark:close
execute if score .timer CS_timer matches 20 run event entity @e[type=spark:yoda] spark:disable_meditating
execute if score .timer CS_timer matches 19 run event entity @e[type=spark:yoda] spark:disable_lightsaber

execute if score .timer CS_timer matches 25 run playanimation @e[type=spark:yoda] animation.spark.yoda.cutscene_force default 0.7
execute if score .timer CS_timer matches 85 run event entity @e[type=spark:cutscene.ilum_window] spark:open

execute if score .timer CS_timer matches 80 run particle spark:gyro_window_ray 45.5 66 3021.5

execute if score .timer CS_timer matches 160 run playanimation @e[type=spark:yoda] animation.spark.yoda.cutscene_force2 default 0.7
execute if score .timer CS_timer matches 198 run event entity @e[type=spark:cutscene.gyro] spark:stage_2


execute if score .timer CS_timer matches 260 run particle spark:gyro_dragon_rays 0.5 67 3021.5
execute if score .timer CS_timer matches 260 run event entity @e[type=spark:cutscene.gyro] spark:set_emission_c1

execute if score .timer CS_timer matches 420 run particle spark:gyro_focus_ray -15 56 3021.5
execute if score .timer CS_timer matches 420 run event entity @e[type=spark:cutscene.gyro] spark:set_emission_c2



execute if score .timer CS_timer matches 432..459 run function spark/cutscene/util/replace_archway_timer



execute if score .timer CS_timer matches 448 run particle spark:gyro_focus_ray_2 -12 52 3021.5


execute if score .timer CS_timer matches 449 run particle spark:waterfall_start -28.5 17 3021.5
execute if score .timer CS_timer matches 480 run particle spark:waterfall_larger -27.5 -6 3021.5
execute if score .timer CS_timer matches 540 run particle spark:waterfall -28.5 -6 3021.5
execute if score .timer CS_timer matches 540 run particle spark:waterfall_splash -28.5 -22.00 3021.5

execute if score .timer CS_timer matches 535 run structure load spark:ilum_portal_stairs -34 -26 3014
execute if score .timer CS_timer matches 536 run structure load spark:ilum_portal -36 -23 3014
execute if score .timer CS_timer matches 672 run event entity @e[type=spark:cutscene.ilum_window] spark:close

execute if score .timer CS_timer matches 675 run event entity @e[type=spark:cutscene.gyro] spark:set_emission_none
execute if score .timer CS_timer matches 770 run playanimation @e[type=spark:yoda] animation.spark.yoda.cutscene_force2 default 0.7
execute if score .timer CS_timer matches 820 run event entity @e[type=spark:yoda] spark:enable_meditating

## camera
# shot 1: 20
execute if score .timer CS_timer matches 20..83 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 3.53 -25.40 3023.66 126.5 -7.5
execute if score .timer CS_timer matches 21..84 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~-0.01923 ~ ~-0.014 ~ ~-0.13846
# David was here

# shot 2: 85
execute if score .timer CS_timer matches 85..115 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 85 run tp @a[tag=!dev] 17.7 60 3027.5 -106 -13
execute if score .timer CS_timer matches 86..115 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0355 ~.0124 ~-0.013

# shot 3: 116
execute if score .timer CS_timer matches 116..158 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 116 run tp @a[tag=!dev] -14.2 11 3046.1 -147.6 -56.5
execute if score .timer CS_timer matches 117..158 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0094 ~.0344 ~-0.0125

# shot 4: 159
execute if score .timer CS_timer matches 159..196 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 159 run tp @a[tag=!dev] 1.95 -23.12 3022.39 123.2 48.4
execute if score .timer CS_timer matches 160..197 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~ ~-0.002895 ~ ~ ~-0.063158
# David was here

# shot 5: 198
execute if score .timer CS_timer matches 198..314 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 198 run tp @a[tag=!dev] -14.2 11 3046.1 -147.6 -56.5
execute if score .timer CS_timer matches 199..314 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0094 ~.0344 ~-0.0125

# shot 6: 315
execute if score .timer CS_timer matches 315 run effect @a[tag=!dev] slowness 0 0 true
execute if score .timer CS_timer matches 315..371 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 315 run tp @a[tag=!dev] -8.5 57.2 3008.2 -30.4 -22.6
execute if score .timer CS_timer matches 316..371 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0965 ~ ~-0.0368 ~.3912 ~-0.0193

# shot 7: 372
execute if score .timer CS_timer matches 372 run effect @a[tag=!dev] slowness 0 0 true
execute if score .timer CS_timer matches 372..448 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 372 run tp @a[tag=!dev] 15.4 89.5 3044.1 138.7 49.4
execute if score .timer CS_timer matches 373..448 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~-0.0065 ~-0.0156 ~-0.0078

# shot 8: 449
execute if score .timer CS_timer matches 449..540 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 449 run tp @a[tag=!dev] -6.5 -21 3021.5 90 -53
execute if score .timer CS_timer matches 450..540 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~-0.0171 ~.0257 ~

# shot 9: 541
execute if score .timer CS_timer matches 541..590 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 541 run tp @a[tag=!dev] -16.7 -23.13 3024.5 120 13
execute if score .timer CS_timer matches 542..591 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0176 ~.0006 ~.0078

# shot 10: 592
execute if score .timer CS_timer matches 591 run effect @a[tag=!dev] slowness 0 0 true
execute if score .timer CS_timer matches 592..662 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 592 run tp @a[tag=!dev] 0.6 -21.6 3034.2 121.5 6.9
execute if score .timer CS_timer matches 593..662 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0225 ~.00075 ~.01

# shot 11: 663
execute if score .timer CS_timer matches 663..711 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 663 run tp @a[tag=!dev] 15.4 89.5 3044.1 138.7 49.4
execute if score .timer CS_timer matches 664..711 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~.0065 ~.0156 ~.0078

# shot 12 712
execute if score .timer CS_timer matches 712..823 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 712..823 run function spark/cutscene/shots/ch02_c04_s3
execute if score .timer CS_timer matches 824 run effect @a[tag=!dev] clear
# David was here


## timer management
# reset
execute if score .timer CS_timer matches 825 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1