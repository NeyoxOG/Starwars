#SS_timer = how long the current wave has lasted
#SS_time = delay before starting the next wave after opening loot chest (5 seconds atm)

#normal wave
scoreboard players operation .tmp droid_survival = Remaining droid_survival_stats

execute if score .timer droid_survival matches 1.. run scoreboard players set .temp droid_survival 0
execute if score .timer droid_survival matches 1.. as @e[family=raider] run scoreboard players add .temp droid_survival 1

#Min requirement reached or no mobs left for some reason:
execute if score .timer droid_survival matches 300.. if score .temp droid_survival matches ..0 run function spark/droid_survival/next_wave
execute if score .timer droid_survival matches 300.. if score Remaining droid_survival_stats matches ..0 run function spark/droid_survival/next_wave

#force next wave after 4 minutes
execute if score .timer droid_survival matches 4800.. run function spark/droid_survival/next_wave