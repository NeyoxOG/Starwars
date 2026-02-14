tag @a[x=8826,y=103,z=-20,r=30] add kamino_inside
tag @a[x=9136,y=103,z=83,r=30] add kamino_inside
execute at @a[x=9000,y=102,z=0,r=280,tag=!kamino_inside,tag=particle_spawner,tag=hide_ui] positioned ^ ^ ^10 run particle spark:kamino_rain_extended ~ ~ ~
execute at @a[x=9000,y=102,z=0,r=280,tag=!kamino_inside,tag=particle_spawner,tag=!hide_ui] run particle spark:kamino_rain ~ ~ ~
execute at @a[x=9000,y=102,z=0,r=280,tag=!kamino_inside,tag=particle_spawner] run particle spark:kamino_waterdust ~ ~ ~
execute at @a[x=8700,y=50,z=-115,dx=442,dy=55,dz=370,tag=!kamino_inside] run particle spark:kamino_rain_splash ~ ~ ~
tag @a remove kamino_inside