# © Spark Universe, 2022
# authors: dragonmaster95
# description: Summons mobs based on score defined in balancing +33% excess

scoreboard players add .timer2 droid_survival 1
execute if score .timer2 droid_survival matches 1 run function spark/droid_survival/waves/balancing/spawn_count

#Add 33% per extra player (max 4)
execute if score .timer2 droid_survival matches 1 run scoreboard players set tmp droid_survival 0
execute if score .timer2 droid_survival matches 1 as @a[tag=in_droid_survvial] run scoreboard players add tmp droid_survival 1
execute if score .timer2 droid_survival matches 1 if score tmp droid_survival matches 2 run scoreboard players operation .amount droid_survival *= _133 SS_const
execute if score .timer2 droid_survival matches 1 if score tmp droid_survival matches 3 run scoreboard players operation .amount droid_survival *= _166 SS_const
execute if score .timer2 droid_survival matches 1 if score tmp droid_survival matches 4.. run scoreboard players operation .amount droid_survival *= _200 SS_const
execute if score .timer2 droid_survival matches 1 if score tmp droid_survival matches 2.. run scoreboard players operation .amount droid_survival /= _100 SS_const
#Round up
execute if score .timer2 droid_survival matches 1 if score tmp droid_survival matches 2.. run scoreboard players add .amount droid_survival 1
execute if score .timer2 droid_survival matches 1 run scoreboard players operation Remaining droid_survival_stats = .amount droid_survival
execute if score .timer2 droid_survival matches 1 run scoreboard players operation .amount2 droid_survival = .amount droid_survival

#Spawn the mobs in 4 groups
#execute if score .timer2 droid_survival matches 2 if score .amount droid_survival matches 6..10 run scoreboard players operation .amount droid_survival /= _2 SS_const
#execute if score .timer2 droid_survival matches 2 if score .amount droid_survival matches 11..15 run scoreboard players operation .amount droid_survival /= _3 SS_const
#execute if score .timer2 droid_survival matches 2 if score .amount droid_survival matches 15.. run scoreboard players operation .amount droid_survival /= _4 SS_const
#execute if score .timer2 droid_survival matches 2 run scoreboard players add .amount droid_survival 1

#Group1
execute if score .timer2 droid_survival matches 10 run function spark/droid_survival/waves/recursive_summon

#stagger spawning for 3 seconds
execute if score .timer2 droid_survival matches 70 run scoreboard players set .timer2 droid_survival 9
execute if score .amount2 droid_survival matches ..0 run scoreboard players set .timer2 droid_survival 0

#execute if score .timer2 droid_survival matches 10 run playsound spark.weapons.raid.start_wave_regular @a ~~~ 20