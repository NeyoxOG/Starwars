# © Spark Universe, 2023
# authors: Jannis
# description: Loop per instance
# called by: ../loop
# executor: duel_force_field

# Active Fight
effect @a[r=50] slowness 1 0 true

# Events
## Death
execute if entity @a[r=50,tag=respawned] run function spark/dueling/instance/loss

execute as @p[tag=blocking] at @s positioned ^ ^0.3 ^0.8 if entity @e[family=duel_opponent,tag=blocking,r=2.2] run playsound random.levelup @a ~ ~ ~
execute as @p[tag=blocking] at @s positioned ^ ^0.3 ^0.8 if entity @e[family=duel_opponent,tag=blocking,r=2.2] run particle spark:lightsaber_sparks ~ ~1.1 ~