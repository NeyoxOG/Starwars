# © Spark Universe, 2023
# authors: Jannis
# description: Enable the force field
# called by: 
# executor: duel_force_field

fill ~-16 ~ ~12 ~-16 ~5 ~-12 barrier
fill ~16 ~ ~12 ~16 ~5 ~-12 barrier
fill ~16 ~ ~-12 ~-16 ~5 ~-12 barrier
fill ~16 ~ ~12 ~-16 ~5 ~12 barrier
event entity @s spark:enable_shield


function spark/lightsaber/give_lightsaber
replaceitem entity @a slot.hotbar 1 air
replaceitem entity @a slot.hotbar 2 air
replaceitem entity @a slot.hotbar 3 air
replaceitem entity @a slot.hotbar 4 air

gamerule naturalregeneration false