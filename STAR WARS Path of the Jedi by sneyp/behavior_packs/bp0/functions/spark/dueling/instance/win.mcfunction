# © Spark Universe, 2023
# authors: Jannis
# description: Player wins a round
# called by: 
# executor: duel_force_field


function spark/dueling/instance/disable_shield

# tag @a[r=50] add duel_win
# tp @a[r=50] ~-13.0 ~.2 ~15 -62 -4
scoreboard players set @s SS_const 4
scoreboard players set @s dueling_story 0

# scoreboard players add @s dueling_rank 1
# scoreboard players add ".global" dueling_rank 1
# function spark/dueling/instance/update_leaderboard

# execute if score @s dueling_rank matches 9 run function spark/dueling/instance/win_final