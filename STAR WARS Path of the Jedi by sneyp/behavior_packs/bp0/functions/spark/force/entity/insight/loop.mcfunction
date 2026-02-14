# © Spark Universe, 2023
# authors: ChainsawNinja
# description: Controls insight particle object
# called by: loop

# Sets up scores
# t1 = lifetime
# t2 = amount of markers passed (that it is searching for)
# s1-7 = ID's of markers already passed

scoreboard players add @s t1 1

tag @e[tag=insight_mark] remove seen

# Determain what marker count it is on
scoreboard players set @s t2 7
scoreboard players set @s[scores={s6=0}] t2 6
scoreboard players set @s[scores={s5=0}] t2 5
scoreboard players set @s[scores={s4=0}] t2 4
scoreboard players set @s[scores={s3=0}] t2 3
scoreboard players set @s[scores={s2=0}] t2 2
scoreboard players set @s[scores={s1=0}] t2 1

# Lable markers that have already been passed
# Remove all markers with lower ID from pool
tag @s add me

execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s1 run tag @s add seen
execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s2 run tag @s add seen
execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s3 run tag @s add seen
execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s4 run tag @s add seen
execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s5 run tag @s add seen
execute as @e[tag=insight_mark] if score @s ID.object <= @e[tag=me,c=1] s6 run tag @s add seen

tag @s remove me

# Find next ID to track
execute as @s[scores={t2=1}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s1 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object
execute as @s[scores={t2=2}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s2 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object
execute as @s[scores={t2=3}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s3 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object
execute as @s[scores={t2=4}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s4 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object
execute as @s[scores={t2=5}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s5 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object
execute as @s[scores={t2=6}] at @s if entity @e[tag=insight_mark,c=1,tag=!seen,r=1.2] run scoreboard players operation @s s6 = @e[tag=insight_mark,c=1,tag=!seen,r=1.2] ID.object

# Move towards next ID

#execute at @s run tp @s ~ ~ ~ facing @e[tag=insight_mark,c=1,tag=!seen]

tag @e[tag=insight_mark] remove next_point
tag @e[tag=insight_mark,c=1,tag=!seen] add next_point

# Turning
execute at @s run tp @s ~ ~ ~ ~ 0

execute at @s positioned ^-100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~8 ~
execute at @s positioned ^100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~-8 ~

execute at @s if entity @e[tag=insight_mark,c=1,tag=next_point,r=5] positioned ^-100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~1 ~
execute at @s if entity @e[tag=insight_mark,c=1,tag=next_point,r=5] positioned ^100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~-1 ~

execute at @s if entity @e[tag=insight_mark,c=1,tag=next_point,r=2] positioned ^-100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~2 ~
execute at @s if entity @e[tag=insight_mark,c=1,tag=next_point,r=2] positioned ^100 ^ ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~-2 ~

execute at @s positioned ^ ^-100 ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~ ~20
execute at @s positioned ^ ^100 ^ if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] at @s run tp @s ~ ~ ~ ~ ~-20

# Moving forward
execute at @s if entity @e[tag=insight_mark,c=1,tag=next_point,r=100] run tp @s ^ ^ ^0.4

# Particle
execute at @s run particle spark:force_guide ~ ~1 ~

# End life after # of time alive
kill @s[scores={t1=100..}]