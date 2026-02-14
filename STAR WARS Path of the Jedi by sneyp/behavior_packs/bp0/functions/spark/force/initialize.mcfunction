# © Spark Universe, 2023
# authors: ChainsawNinja
# description: Setups up scoreboards, gamerules, and teams
# called by: (dev)

#
scoreboard objectives remove .data

scoreboard objectives remove ID
scoreboard objectives remove ID.object
scoreboard objectives remove ID.attacker

scoreboard objectives remove force_time
scoreboard objectives remove collide_time

scoreboard objectives remove size
scoreboard objectives remove fall_time
scoreboard objectives remove check_time

scoreboard objectives remove t1
scoreboard objectives remove t2
scoreboard objectives remove t3
scoreboard objectives remove t4
scoreboard objectives remove t5
scoreboard objectives remove t6

scoreboard objectives remove s1
scoreboard objectives remove s2
scoreboard objectives remove s3
scoreboard objectives remove s4
scoreboard objectives remove s5
scoreboard objectives remove s6

scoreboard objectives remove output

scoreboard objectives remove item.charge
scoreboard objectives remove item.type

#
scoreboard objectives add .data dummy

scoreboard objectives add ID dummy
scoreboard objectives add ID.object dummy
scoreboard objectives add ID.attacker dummy

scoreboard objectives add force_time dummy
scoreboard objectives add collide_time dummy

scoreboard objectives add size dummy
scoreboard objectives add fall_time dummy
scoreboard objectives add check_time dummy

scoreboard objectives add t1 dummy
scoreboard objectives add t2 dummy
scoreboard objectives add t3 dummy
scoreboard objectives add t4 dummy
scoreboard objectives add t5 dummy
scoreboard objectives add t6 dummy

scoreboard objectives add s1 dummy
scoreboard objectives add s2 dummy
scoreboard objectives add s3 dummy
scoreboard objectives add s4 dummy
scoreboard objectives add s5 dummy
scoreboard objectives add s6 dummy

scoreboard objectives add output dummy

scoreboard objectives add item.charge dummy
scoreboard objectives add item.type dummy

#
scoreboard players set .ID .data 1
scoreboard players set .ID.object .data 1