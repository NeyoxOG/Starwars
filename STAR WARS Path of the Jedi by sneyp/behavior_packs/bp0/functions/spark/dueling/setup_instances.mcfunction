# © Spark Universe, 2023
# authors: Jannis
# description: Spread players from the main room into their instanced rooms to set them up
# called by: 
# executor: -

tag @a remove duel_win

tag @r[tag=!instanced] add tmp
execute as @p[tag=tmp] positioned 8989.5 22.0 8891.5 run function spark/dueling/instance/context/room_0
tag @p[tag=tmp] add instanced
tag @a remove tmp

tag @r[tag=!instanced] add tmp
execute as @p[tag=tmp] positioned 8989.5 22.0 8807.5 run function spark/dueling/instance/context/room_1
tag @p[tag=tmp] add instanced
tag @a remove tmp


tag @r[tag=!instanced] add tmp
execute as @p[tag=tmp] positioned 8989.5 22.0 8723.5 run function spark/dueling/instance/context/room_2
tag @p[tag=tmp] add instanced
tag @a remove tmp


tag @r[tag=!instanced] add tmp
execute as @p[tag=tmp] positioned 8989.5 22.0 8639.5 run function spark/dueling/instance/context/room_3
tag @p[tag=tmp] add instanced
tag @a remove tmp



tag @a remove instanced