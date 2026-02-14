# © Spark Universe, 2022
# authors: dragonmaster95
# description: Recursively summon random zombie mobs based on the value of SS_temp
# called by: ./main

#tag @a[tag=in_droid_survival] remove tmp
#tag @r[tag=in_droid_survival] add tmp
#execute unless entity @e[type=spark:ma run say ma:,c=1,tag
#execute unless entity @e[type=spark:marker,c=1,tag=droid_survival_active] at @p[m=!spectator,tag=tmp,tag=in_droid_survival] run tag @r[type=spark:marker,c=1,tag=droid_survival,r=50] add droid_survival_active
#scoreboard players add @e[type=spark:marker,c=1,tag=droid_survival_active] droid_survival 0
#execute at @p[m=!spectator,tag=tmp,tag=in_droid_survival] as @e[type=spark:marker,c=1,tag=droid_survival_active,scores={droid_survival=..3}] at @s run function spark/droid_survival/waves/summon_wave_mob
#tag @a[tag=in_droid_survival] remove tmp



scoreboard players random .tmp droid_survival 1 21
execute if score .wave droid_survival matches 1 run scoreboard players set .tmp droid_survival 1
execute if score .tmp droid_survival matches 1 positioned 9000 101 -8 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 1 positioned 9000 101 -8 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 1 run say 1: 9000 101 -8
execute if score .tmp droid_survival matches 2 positioned 9011 101 70 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 2 positioned 9011 101 70 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 2 run say 2: 9011 101 70
execute if score .tmp droid_survival matches 3 positioned 9002 100 80 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 3 positioned 9002 100 80 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 3 run say 3: 9002 100 80
execute if score .tmp droid_survival matches 4 positioned 9025 97 109 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 4 positioned 9025 97 109 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 4 run say 4: 9025 97 109
execute if score .tmp droid_survival matches 5 positioned 9034 97 119 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 5 positioned 9034 97 119 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 5 run say 5: 9034 97 119
execute if score .tmp droid_survival matches 6 positioned 8917 106 104 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 6 positioned 8917 106 104 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 6 run say 6: 8917 106 104
execute if score .tmp droid_survival matches 7 positioned 8941 101 100 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 7 positioned 8941 101 100 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 7 run say 7: 8941 101 100
execute if score .tmp droid_survival matches 8 positioned 8951 101 108 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 8 positioned 8951 101 108 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 8 run say 8: 8951 101 108
execute if score .tmp droid_survival matches 9 positioned 8980 99 135 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 9 positioned 8980 99 135 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 9 run say 9: 8980 99 135
execute if score .tmp droid_survival matches 10 positioned 8988 99 126 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 10 positioned 8988 99 126 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 10 run say 10: 8988 99 126
execute if score .tmp droid_survival matches 11 positioned 8950 94 38 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 11 positioned 8950 94 38 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 11 run say 11: 8950 94 38
execute if score .tmp droid_survival matches 12 positioned 8941 94 39 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 12 positioned 8941 94 39 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 12 run say 12: 8941 94 39
execute if score .tmp droid_survival matches 13 positioned 8970 97 -53 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 13 positioned 8970 97 -53 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 13 run say 13: 8970 97 -53
execute if score .tmp droid_survival matches 14 positioned 8962 99 -62 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 14 positioned 8962 99 -62 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 14 run say 14: 8962 99 -62
execute if score .tmp droid_survival matches 15 positioned 8925 92 -82 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 15 positioned 8925 92 -82 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 15 run say 15: 8925 92 -82
execute if score .tmp droid_survival matches 16 positioned 8917 93 -91 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 16 positioned 8917 93 -91 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 16 run say 16: 8917 93 -91
execute if score .tmp droid_survival matches 17 positioned 9008 91 -74 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 17 positioned 9008 91 -74 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 17 run say 17: 9008 91 -74
execute if score .tmp droid_survival matches 18 positioned 9007 91 -84 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 18 positioned 9007 91 -84 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 18 run say 18: 9007 91 -84
execute if score .tmp droid_survival matches 19 positioned 9042 101 -43 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 19 positioned 9042 101 -43 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 19 run say 19: 9042 101 -43
execute if score .tmp droid_survival matches 20 positioned 9032 101 -43 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 20 positioned 9032 101 -43 unless entity @p[m=!spectator,r=100] run scoreboard players add .tmp droid_survival 1
#execute if score .tmp droid_survival matches 20 run say 20: 9032 101 -43
execute if score .tmp droid_survival matches 21 positioned 9093 96 -15 if entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/summon_wave_mob
execute if score .tmp droid_survival matches 21 positioned 9093 96 -15 unless entity @p[m=!spectator,r=100] run function spark/droid_survival/waves/recursive_summon
#execute if score .tmp droid_survival matches 21 run say 21: 9093 96 -15

