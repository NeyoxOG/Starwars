# © Spark Universe, 2023
# authors: Jannis
# description: Disable the force field
# called by: 
# executor: duel_force_field

fill ~-16 ~ ~-12 ~16 ~5 ~12 air [] replace barrier
playsound sound.spark.force_field_deactivate @a[r=50]
event entity @s spark:disable_shield

effect @a[r=50] instant_health 10 10 true
# event entity @a[r=50] spark:force_movement_on
