# © Spark Universe, 2023
# authors: destruc7i0n, Jannis
# description: Game loop, runs once a second
# called by: loop

scoreboard players set slow2 SS_time 0

# particles
tag @a remove particle_spawner
execute as @a at @s unless entity @a[tag=particle_spawner,r=14] run tag @s add particle_spawner

execute if entity @a[x=9000,y=102,z=0,r=230] run function spark/particles/kamino_fast
execute at @r[x=73,y=-30,z=2790,dx=272,dy=50,dz=370] run particle spark:ilum_blizzard ~ ~ ~
execute at @r[x=6270,y=145,z=5890,r=245] run particle spark:sandstorm_air ~ ~ ~
execute at @r[x=6000,y=50,z=6000,r=60] run particle spark:sandstorm ~ ~ ~
