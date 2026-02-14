
# steam
# sparks
# test fog
# debris

scoreboard players random .random SS_temp 0 70

# Steam
execute if score slow SS_time matches 10 run particle spark:crucible_steam_south 3006.5 -53.7 3048.1
execute if score slow SS_time matches 19 run particle spark:crucible_steam_south_low 2977.5 -55.3 3048.2

execute if score .random SS_temp matches ..3 run particle spark:crucible_steam_down 3003.70 -50.6 3050.30
execute if score .random SS_temp matches 7 run particle spark:crucible_steam_down 3022.70 -50.6 3052.70

execute if score .random SS_temp matches 50 run particle spark:crucible_steam_down 2965.45 -50.6 3080.43
execute if score .random SS_temp matches 50..53 run particle spark:crucible_steam_down 3028.62 -50.5 3059.80
execute if score .random SS_temp matches 54 run particle spark:crucible_steam_west 2977.82 -55.1 3070.44
execute if score .random SS_temp matches 20..21 run particle spark:crucible_sparks_north 2971.31 -55.7 3084.46

# Sparks
execute if score .random SS_temp matches 10 run particle spark:crucible_sparks_south 3006.5 -54 3048.1
execute if score .random SS_temp matches 20 run particle spark:crucible_sparks_south 3023.5 -54 3048.1
execute if score .random SS_temp matches 30 run particle spark:crucible_sparks_south 2991.5 -54 3048.1
execute if score .random SS_temp matches 40 run particle spark:crucible_sparks_south 2975.5 -54 3048.1

execute if score .random SS_temp matches 11 run particle spark:crucible_sparks_north 3025.5 -54 3057.0
execute if score .random SS_temp matches 21 run particle spark:crucible_sparks_north 3006.5 -54 3054.9
execute if score .random SS_temp matches 31..32 run particle spark:crucible_sparks_north 2991.5 -54.4 3054.9
execute if score .random SS_temp matches 35 run particle spark:crucible_sparks_north 2992.5 -54.4 3054.9
execute if score .random SS_temp matches 41 run particle spark:crucible_sparks_north 2980.5 -54 3054.9
execute if score .random SS_temp matches 21 run particle spark:crucible_sparks_north 3011.5 -54 3054.9

# debris
execute if score .random SS_temp matches 60..64 run particle spark:crucible_debris 2999.5 -50.6 3051.5

# Shake
execute if score .random SS_temp matches 20..22 run camerashake add @a 0.01 0.5 rotational
execute if score .random SS_temp matches 20..22 run playsound sound.spark.crucible_shake_minor

# time
scoreboard players add veryslow SS_time 1
execute if score veryslow SS_time matches 40 run scoreboard players set veryslow SS_time 0



# Steam Sounds
execute if score slow SS_time matches 10 run playsound sound.spark.crucible_steam @a 3006.5 -54 3048.1
execute if score slow SS_time matches 19 run playsound sound.spark.crucible_steam @a 2977.5 -55 3048.1

execute if score .random SS_temp matches ..3 run playsound sound.spark.crucible_steam @a 3003.70 -50.6 3050.30
execute if score .random SS_temp matches 7 run playsound sound.spark.crucible_steam @a 3022.70 -50.6 3052.70

execute if score .random SS_temp matches 50 run playsound sound.spark.crucible_steam @a 2965.45 -50.6 3080.43
execute if score .random SS_temp matches 50..53 run playsound sound.spark.crucible_steam @a 3028.62 -50.5 3059.80
execute if score .random SS_temp matches 54 run playsound sound.spark.crucible_steam @a 2977.95 -52.60 3065.56

# Spark Sounds
execute if score .random SS_temp matches 20..21 run playsound sound.spark.crucible_sparks @a 2971.31 -55.7 3084.46

execute if score .random SS_temp matches 10 run playsound sound.spark.crucible_sparks @a 3006.5 -54 3048.1
execute if score .random SS_temp matches 20 run playsound sound.spark.crucible_sparks @a 3023.5 -54 3048.1
execute if score .random SS_temp matches 30 run playsound sound.spark.crucible_sparks @a 2991.5 -54 3048.1
execute if score .random SS_temp matches 40 run playsound sound.spark.crucible_sparks @a 2975.5 -54 3048.1

execute if score .random SS_temp matches 11 run playsound sound.spark.crucible_sparks @a 3025.5 -54 3057.0
execute if score .random SS_temp matches 21 run playsound sound.spark.crucible_sparks @a 3006.5 -54 3054.9
execute if score .random SS_temp matches 31..32 run playsound sound.spark.crucible_sparks @a 2991.5 -54.4 3054.9
execute if score .random SS_temp matches 35 run playsound sound.spark.crucible_sparks @a 2992.5 -54.4 3054.9
execute if score .random SS_temp matches 41 run playsound sound.spark.crucible_sparks @a 2980.5 -54 3054.9
execute if score .random SS_temp matches 21 run playsound sound.spark.crucible_sparks @a 3011.5 -54 3054.9
