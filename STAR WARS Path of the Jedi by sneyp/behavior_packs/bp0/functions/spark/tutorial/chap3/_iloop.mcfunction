# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10

# call each step here, we are executing this from a position, so we should be good :D
# does anyone other than me read this? if you do, add 100 new lines starting from line 8!




































































































# curse you dillon, https://tenor.com/view/reginald-angry-eating-angry-eating-monster-house-gif-20013301
execute if score @s tut_instances matches 0 run function spark/tutorial/chap3/i0
execute if score @s tut_instances matches 1 run function spark/tutorial/chap3/i1
execute if score @s tut_instances matches 2 run function spark/tutorial/chap3/i2
execute if score @s tut_instances matches 3 run function spark/tutorial/chap3/i3
execute if score @s tut_instances matches 4 run function spark/tutorial/chap3/i4
execute if score @s tut_instances matches 5 run function spark/tutorial/chap3/i5
execute if score @s tut_instances matches 6 run function spark/tutorial/chap3/i6

# increment timers
scoreboard players add @s tut_i_times 1