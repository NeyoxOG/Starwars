#select random location 
scoreboard players random .powerup_tmp droid_survival 1 13


#spawn at random location
#if already taken, try different one
execute if score .powerup_tmp droid_survival matches 1 if score .powerup_tmp1 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 1 unless score .powerup_tmp1 droid_survival matches 1 positioned 9011 90 -80 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 1 unless score .powerup_tmp1 droid_survival matches 1 run scoreboard players set .powerup_tmp1 droid_survival 1

execute if score .powerup_tmp droid_survival matches 2 if score .powerup_tmp2 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 2 unless score .powerup_tmp2 droid_survival matches 1 positioned 9037 100 -48 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 2 unless score .powerup_tmp2 droid_survival matches 1 run scoreboard players set .powerup_tmp2 droid_survival 1

execute if score .powerup_tmp droid_survival matches 3 if score .powerup_tmp3 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 3 unless score .powerup_tmp3 droid_survival matches 1 positioned 8966 96 -58 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 3 unless score .powerup_tmp3 droid_survival matches 1 run scoreboard players set .powerup_tmp3 droid_survival 1

execute if score .powerup_tmp droid_survival matches 4 if score .powerup_tmp4 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 4 unless score .powerup_tmp4 droid_survival matches 1 positioned 8921 92 -88 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 4 unless score .powerup_tmp4 droid_survival matches 1 run scoreboard players set .powerup_tmp4 droid_survival 1

execute if score .powerup_tmp droid_survival matches 5 if score .powerup_tmp5 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 5 unless score .powerup_tmp5 droid_survival matches 1 positioned 9000 101 0 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 5 unless score .powerup_tmp5 droid_survival matches 1 run scoreboard players set .powerup_tmp5 droid_survival 1

execute if score .powerup_tmp droid_survival matches 6 if score .powerup_tmp6 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 6 unless score .powerup_tmp6 droid_survival matches 1 positioned 9088 94 -16 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 6 unless score .powerup_tmp6 droid_survival matches 1 run scoreboard players set .powerup_tmp6 droid_survival 1

execute if score .powerup_tmp droid_survival matches 7 if score .powerup_tmp7 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 7 unless score .powerup_tmp7 droid_survival matches 1 positioned 8946 94 43 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 7 unless score .powerup_tmp7 droid_survival matches 1 run scoreboard players set .powerup_tmp7 droid_survival 1

execute if score .powerup_tmp droid_survival matches 8 if score .powerup_tmp8 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 8 unless score .powerup_tmp8 droid_survival matches 1 positioned 9006 99 75 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 8 unless score .powerup_tmp8 droid_survival matches 1 run scoreboard players set .powerup_tmp8 droid_survival 1

execute if score .powerup_tmp droid_survival matches 9 if score .powerup_tmp9 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 9 unless score .powerup_tmp9 droid_survival matches 1 positioned 8946 101 104 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 9 unless score .powerup_tmp9 droid_survival matches 1 run scoreboard players set .powerup_tmp9 droid_survival 1 

execute if score .powerup_tmp droid_survival matches 10 if score .powerup_tmp10 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 10 unless score .powerup_tmp10 droid_survival matches 1 positioned 8984 98 130 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 10 unless score .powerup_tmp10 droid_survival matches 1 run scoreboard players set .powerup_tmp10 droid_survival 1

execute if score .powerup_tmp droid_survival matches 11 if score .powerup_tmp11 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 11 unless score .powerup_tmp11 droid_survival matches 1 positioned 9030 95 114 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 11 unless score .powerup_tmp11 droid_survival matches 1 run scoreboard players set .powerup_tmp11 droid_survival 1

execute if score .powerup_tmp droid_survival matches 12 if score .powerup_tmp12 droid_survival matches 1 run scoreboard players add .powerup_tmp droid_survival 1
execute if score .powerup_tmp droid_survival matches 12 unless score .powerup_tmp12 droid_survival matches 1 positioned 9011 95 -125 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 12 unless score .powerup_tmp12 droid_survival matches 1 run scoreboard players set .powerup_tmp12 droid_survival 1

execute if score .powerup_tmp droid_survival matches 13 if score .powerup_tmp13 droid_survival matches 1 run function spark/droid_survival/powerups/random_location
execute if score .powerup_tmp droid_survival matches 13 unless score .powerup_tmp13 droid_survival matches 1 positioned 8984 98 185 run summon spark:powerup_spawner
execute if score .powerup_tmp droid_survival matches 13 unless score .powerup_tmp13 droid_survival matches 1 run scoreboard players set .powerup_tmp13 droid_survival 1 
