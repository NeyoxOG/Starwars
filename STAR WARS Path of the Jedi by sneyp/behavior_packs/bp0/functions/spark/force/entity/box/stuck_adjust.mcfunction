#
kill @e[tag=stuck_check]

#
tag @e[type=spark:marker_force] add old
summon spark:marker_force ~ ~ ~
tag @e[type=spark:marker_force,tag=!old] add stuck_check

#
function spark/force/entity/box/check_stuck
#
execute as @s at @s run tp @s[tag=stuck] ~ ~0.5 ~

#
function spark/force/entity/box/check_stuck
#
execute as @s at @s run tp @s[tag=stuck] ~ ~0.5 ~

#
function spark/force/entity/box/check_stuck
#
execute as @s at @s run tp @s[tag=stuck] ~ ~0.5 ~

#
kill @e[tag=stuck_check]
