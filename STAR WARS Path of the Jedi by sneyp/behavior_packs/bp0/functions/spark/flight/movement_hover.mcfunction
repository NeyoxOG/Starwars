# © Spark Universe, 2023
# authors: Jannis
# description: Controls movement while the ship is hovering in place
# called by: 
# executor: ship

scoreboard players set @s lift 5
execute if entity @a[tag=pilot,rxm=40] run scoreboard players set @s lift 4
execute if entity @a[tag=pilot,rxm=65] run scoreboard players set @s lift 3
execute if entity @a[tag=pilot,rx=-35] run scoreboard players set @s lift 6
execute if entity @a[tag=pilot,rx=-60] run scoreboard players set @s lift 7
execute if entity @a[tag=pilot,rxm=65] run scoreboard players set @s lift 3

execute if entity @s[tag=near_ground] if entity @a[tag=pilot,rxm=40] run scoreboard players set @s lift 3


effect @s[scores={lift=3}] slow_falling 1 0 true

effect @s[scores={lift=4,f_timer2=..2}] levitation 1 0 true
effect @s[scores={lift=4,f_timer2=3..}] slow_falling 1 0 true

effect @s[scores={lift=5,f_timer2=..7}] levitation 1 0 true
effect @s[scores={lift=5,f_timer2=8..}] slow_falling 1 0 true

effect @s[scores={lift=6,f_timer2=..6}] levitation 1 3 true
effect @s[scores={lift=6,f_timer2=7..}] slow_falling 1 0 true

effect @s[scores={lift=7,f_timer2=..7}] levitation 1 5 true
effect @s[scores={lift=7,f_timer2=8..}] slow_falling 1 0 true
