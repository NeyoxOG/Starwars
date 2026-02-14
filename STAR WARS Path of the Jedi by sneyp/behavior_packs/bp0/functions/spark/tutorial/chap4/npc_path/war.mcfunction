summon spark:breadcrumb_2 3365 30.75 -120
summon spark:breadcrumb_1 3365 30.75 -87
execute positioned 3365 34 -54.5 run dialogue change @e[r=5,c=1,family=npc] spark:jedi_temple.generic.follow_me
execute positioned 3365 34 -54.5 run event entity @e[r=5,c=1,family=npc] spark:move1

scoreboard players set @s SS_const 600
scoreboard players set @s timer 1