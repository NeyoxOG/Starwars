
scoreboard players random particle_event SS_tmp 0 12


tag @a remove particle_spawner
execute as @a at @s unless entity @a[tag=particle_spawner,r=14] run tag @s add particle_spawner

function spark/particles/decals
particle spark:decal_security_passage_2_start 3365.5 34.005 104.0
particle spark:decal_war_room_floor_extension 3413.5 32.006 119.0

execute if entity @a[x=3092,y=32,z=0,r=250] run function spark/particles/coruscant
execute if entity @a[x=3380,y=36,z=0,r=230] run function spark/particles/main_hall
execute if entity @a[x=-126,y=-22,z=3030,r=400] run function spark/particles/ilum
execute if entity @a[x=9000,y=102,z=0,r=230] run function spark/particles/kamino_slow
execute if entity @a[x=9200,y=37,z=8984,r=45] run function spark/particles/council
execute if entity @a[x=6159,y=72,z=9201,r=300] run function spark/particles/torren
execute if entity @a[x=6084.18,y=-53.00,z=3115.62,r=200] run function spark/particles/battleship
execute at @e[type=spark:vision_tint] if entity @a[r=50] run function spark/particles/vision_room

execute at @a[x=9000,y=-30,z=6000,r=400,tag=particle_spawner] run particle spark:felucia_spores ~ ~ ~
execute if score particle_event SS_tmp matches 1 run execute at @r[x=9000,y=-30,z=6000,r=400] run particle spark:felucia_birds ~ ~ ~