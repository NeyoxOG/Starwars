# © Spark Universe, 2023
# authors: destruc7i0n
# description: slow loop for pets system
# called by: loop

execute as @e[family=companion,tag=tamed] at @s run function spark/companion/checks/check_owner

# handle loading pet and teleporting to player
execute as @a[tag=tamer,tag=!hide_ui,m=!spectator] at @s run function spark/companion/checks/pet_check
execute as @a[tag=tamer,tag=hide_ui] as @s run function spark/companion/hide
execute as @a[tag=tamer,tag=no_droid] as @s run function spark/companion/hide
execute as @a[tag=tamer,m=spectator] as @s run function spark/companion/hide
