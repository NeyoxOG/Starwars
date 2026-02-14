scoreboard players random .random droid_survival 1 4
execute if score .random droid_survival matches 1..3 run summon spark:delay_spawn ~ ~ ~ ~ ~ spark:b1_battle_droid
execute if score .random droid_survival matches 4 run summon spark:delay_spawn ~ ~ ~ ~ ~ spark:b2_battle_droid
scoreboard players remove .amount2 droid_survival 1