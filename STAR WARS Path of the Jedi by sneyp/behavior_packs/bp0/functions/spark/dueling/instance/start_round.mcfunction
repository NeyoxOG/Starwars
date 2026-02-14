# © Spark Universe, 2023
# authors: Jannis
# description: Start a round, activated when a player stands in the starting circle for long enough
# called by: 
# executor: duel_force_field

execute as @p at @s run playsound sound.spark.duel_begin @s
scoreboard players set @s SS_ui_tutorial 0
scoreboard players set @s dueling_story 0
event entity @s spark:disable_ring

function spark/dueling/instance/enable_shield

spawnpoint @a[r=50] ~ ~ ~

inputpermission set @a[r=50] movement disabled
inputpermission set @a[r=50] camera disabled

music play sound.spark.music_tatooine_arrival 1.0 0.1 loop
scoreboard players set @s dueling_story 0
scoreboard players set @s SS_const 1

#(in case this is ran outside of the intended function)
scoreboard players set .state dueling_story 3