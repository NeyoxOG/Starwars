# © Spark Universe, 2023
# authors: destruc7i0n, Jannis
# description: Game loop, runs once a second
# called by: loop

scoreboard players set slow SS_time 0

function spark/companion/loop20

function spark/tutorial/loop20

execute as @e[family=ship_droid] at @s unless entity @p[r=33] run particle spark:recon_droid_far_icon ^ ^1.2 ^1.6
#/particle spark:calling_star ^ ^ ^50

# execute at @e[tag=has_quest] run particle spark:npc_exclamation ~ ~2.5 ~

# Stamina
# can maybe move these 2 to an init-player function later
scoreboard players add @a stamina 0
scoreboard players add @a stamina_cooldown 0
# execute as @a[x=3357,y=80,z=0,r=160,scores={stamina_cooldown=1..}] if score @s stamina < .max hotbar_stamina_size run function spark/stamina/recharge_full
execute as @a[tag=use_grab] run function spark/stamina/consume_1

# hunger
effect @a saturation 2 1 true

# double jump performance fix
execute if score tps timer matches ..18 run event entity @a[scores={ac_tps=16..}] spark:slow_server_on
event entity @a[scores={ac_tps=..15}] spark:slow_server_on
execute unless score tps timer matches ..18 run event entity @a[scores={ac_tps=16..}] spark:slow_server_off
scoreboard players set @a ac_tps 0
scoreboard objectives add ac_tps dummy

function spark/tutorial/elevator/update

# todo: remove once saved in live bedrock world
execute positioned 6490.5 1 7462.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 6096.5 1 7462.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 5702.5 1 7462.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 5308.5 1 7462.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint

execute positioned 5644.5 1 8383.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 5733.5 1 8383.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 5822.5 1 8383.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
execute positioned 5911.5 1 8383.5 if entity @a[r=100] unless entity @e[type=spark:vision_tint,r=1] run summon spark:vision_tint
