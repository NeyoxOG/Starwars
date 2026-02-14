# © Spark Universe, 2023
# authors: Jannis
# description: Runs on a loop while the ship has a pilot
# called by: loop
# executor: ship

tag @s add self

scoreboard players add @s f_timer1 1
scoreboard players set @s[scores={f_timer1=4..}] f_timer1 0
scoreboard players add @s f_timer2 1
scoreboard players set @s[scores={f_timer2=10..}] f_timer2 0

# Determine Pilot
scoreboard players operation @a[scores={plane_id=1..}] temp_id = @s plane_id
execute as @a[scores={plane_id=1..}] run scoreboard players operation @s temp_id -= @s plane_id
tag @a[scores={plane_id=1..,temp_id=0},r=40] add pilot
execute if entity @a[tag=pilot,r=40] run tag @s add has_pilot
execute if entity @s[tag=!has_pilot] run function spark/flight/revoke_pilot
execute if entity @s[tag=!has_pilot] run function spark/flight/assign_pilot
tag @s[tag=has_pilot] remove has_pilot


# takeoff
execute if entity @s[tag=on_ground] if entity @p[tag=pilot,rx=-38] run event entity @s spark:set_fly
execute if entity @s[tag=on_ground] if entity @p[tag=pilot,rx=-38] run effect @s levitation 1 22 true

execute as @s[tag=!on_ground] run function spark/flight/fly

#camera @a[tag=pilot] set minecraft:free ease 0.1 linear pos ^ ^7 ^-18 rot ~ ~
effect @a[tag=pilot] invisibility 1 0 true

tag @s remove self
tag @a[tag=pilot] remove pilot

#
scoreboard players remove @p spawn_hoard 1
scoreboard players remove @p spawn_loner 1

execute as @p[scores={spawn_hoard=..0}] at @s run function spark/ship_game/swarm/summon
execute as @p[scores={spawn_loner=..0}] at @s run function spark/ship_game/swarm/loner

#
tag @e[tag=!started] add bump_start
tag @e[tag=!started] add started

execute as @s run ride @p start_riding @s teleport_rider