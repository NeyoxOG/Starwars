
#function spark/droid_survival/waves/summon_random_mob
#scoreboard players add @s droid_survival 1
##swap spawner pile
#tag @e[type=spark:marker,c=1,tag=droid_survival,tag=!droid_survival_active] add droid_survival_active
#tag @s remove droid_survival_active
#
#
#scoreboard players remove .amount2 droid_survival 1
#execute if score @s droid_survival matches ..2 if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon_wave_mob
#execute if score @s droid_survival matches 2.. run scoreboard players reset @s droid_survival

execute if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon_random_mob
execute if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon_random_mob
execute if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon_random_mob
execute if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon_random_mob
