event entity @e[type=spark:powerup_spawner] spark:despawn
scoreboard players set .tmp droid_survival 0
execute as @a[tag=in_droid_survival] run scoreboard players add .tmp droid_survival 1

execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..2 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..2 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..3 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..3 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..4 run function spark/droid_survival/powerups/random_location
execute if score .tmp droid_survival matches 1..4 run function spark/droid_survival/powerups/random_location

#reset whether a location is "already used" or not
scoreboard players set .powerup_tmp1 droid_survival 0
scoreboard players set .powerup_tmp2 droid_survival 0
scoreboard players set .powerup_tmp3 droid_survival 0
scoreboard players set .powerup_tmp4 droid_survival 0
scoreboard players set .powerup_tmp5 droid_survival 0
scoreboard players set .powerup_tmp6 droid_survival 0
scoreboard players set .powerup_tmp7 droid_survival 0
scoreboard players set .powerup_tmp8 droid_survival 0
scoreboard players set .powerup_tmp9 droid_survival 0
scoreboard players set .powerup_tmp10 droid_survival 0
scoreboard players set .powerup_tmp11 droid_survival 0
scoreboard players set .powerup_tmp12 droid_survival 0
scoreboard players set .powerup_tmp13 droid_survival 0