execute as @s[scores={droid_survival_timer=1}] run damage @s 0
execute as @s[scores={droid_survival_timer=1}] run title @s actionbar hud:fade_out_0
execute as @s[scores={droid_survival_timer=21}] run spreadplayers 9000 0 1 5 @s
execute as @s[scores={droid_survival_timer=21}] run title @s actionbar hud:fade_in_1
execute as @s[scores={droid_survival_timer=21}] run tag @s remove droid_survival_fell
execute as @s[scores={droid_survival_timer=21..}] run scoreboard players reset @s droid_survival_timer