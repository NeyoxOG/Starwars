# © Spark Universe, 2023
# authors: Jannis
# description: Update the leaderboard
# called by: 
# executor: duel_force_field

execute as @e[type=spark:duel_leaderboard] run function spark/dueling/update_leaderboard


# execute if score @s dueling_rank matches 0 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_0
# execute if score @s dueling_rank matches 1 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_2
# execute if score @s dueling_rank matches 2 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_3
# execute if score @s dueling_rank matches 3 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_4
# execute if score @s dueling_rank matches 4 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_5
# execute if score @s dueling_rank matches 5 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_6
# execute if score @s dueling_rank matches 6 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_7
# execute if score @s dueling_rank matches 7 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_8
# execute if score @s dueling_rank matches 8 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_9
# execute if score @s dueling_rank matches 9 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_10
# execute if score @s dueling_rank matches 10 run event entity @e[type=spark:duel_leaderboard,r=40] spark:set_rank_10
