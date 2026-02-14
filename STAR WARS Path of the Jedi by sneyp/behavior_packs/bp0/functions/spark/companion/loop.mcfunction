# © Spark Universe, 2023
# authors: destruc7i0n
# description: pets loop
# called by: main loop

# this function is called before the loop20 is run, so this will always be run in the next tick after loop20 executes
# the entity is teleported to the tutorial area with spreadplayers in loop20
# this ensures that the entity is in the new location because structure save seems to not work if you teleport and save in the same tick

# TODO: update this and the location in `queue_save` to be the same (change the @s[x,y,z] to the same location)
execute as @e[type=!player,family=companion,tag=pet_save] if entity @s[x=-8,y=1,z=279,r=16] at @s run function spark/companion/save/attempt_save
