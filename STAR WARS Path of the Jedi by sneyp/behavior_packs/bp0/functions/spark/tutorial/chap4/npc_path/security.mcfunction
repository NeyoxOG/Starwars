fill 3364 63 104 3366 34 104 air [] replace white_wool

summon spark:breadcrumb_2 3366 35.75 110
summon spark:breadcrumb_4 3364 35.75 110
summon spark:breadcrumb_1 3366 35.75 87
summon spark:breadcrumb_3 3364 35.75 87

summon spark:breadcrumb_5 3366 35.75 87
summon spark:breadcrumb_6 3365 35.75 110
execute positioned 3365 34 55.5 run dialogue change @e[r=5,c=1,family=npc] spark:jedi_temple.generic.follow_me
execute positioned 3366 34 55.5 run event entity @e[r=5,c=1,family=npc] spark:move1
execute positioned 3364 34 55.5 run event entity @e[r=5,c=1,family=npc] spark:move3
execute positioned 3366 34 55.5 run event entity @e[r=5,c=1,type=spark:astromech] spark:move5

scoreboard players set @s SS_const 600
scoreboard players set @s timer 1