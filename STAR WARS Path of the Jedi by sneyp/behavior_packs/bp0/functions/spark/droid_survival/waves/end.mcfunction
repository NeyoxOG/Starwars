# © Spark Universe, 2022
# authors: dragonmaster95
# description: Gets called when the raid should be stopped/end
# called by: 
scoreboard players set @a[tag=in_droid_survival] SS_ui_task 0
scoreboard players operation .highest_wave droid_survival > Wave droid_survival_stats
scoreboard players operation .highest_kills droid_survival > Droids_Defeated droid_survival_stats
scoreboard players operation .highest_time droid_survival > Time droid_survival_stats
function spark/droid_survival/end

# if multiplayer, need to do the fade, but not the hold
# unless you are the final death?

tag @a[tag=!dev] add hide_ui
# title @a[tag=!dev] actionbar hud:fade_out_1
