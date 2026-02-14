scoreboard players random .random .data 0 10

tag @e[family=ship_droid] add rotation

execute if score .random .data matches 0..7 run summon spark:recon_droid_small
execute if score .random .data matches 8..9 run summon spark:recon_droid_medium
execute if score .random .data matches 10 run summon spark:recon_droid_large

particle spark:recon_droid_far_icon ~ ~1.2 ~

scoreboard players random .random .data 0 1

execute if score .random .data matches 0 run tag @e[family=ship_droid,tag=!rotation] add left
execute if score .random .data matches 1 run tag @e[family=ship_droid,tag=!rotation] add right