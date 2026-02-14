# © Spark Universe, 2023
# authors: Jannis
# description: Player drops the crystal
# called by: ./s14
# executor: Player


execute at @s as @e[type=spark:kyber_crystal] run scoreboard players operation @s SS_temp = @s t5
execute at @s as @e[type=spark:kyber_crystal] run scoreboard players operation @s SS_temp -= @p t5
event entity @e[type=spark:kyber_crystal,scores={SS_temp=0}] spark:drop

scoreboard players set @s t5 0

# disable infinite pull when they stop pulling the crystal 
tag @s remove no_force_end
stopsound @p sound.spark.crystal_grab