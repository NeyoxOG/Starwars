# © Spark Universe, 2023
# authors: FetchBot
# description: Update this leaderboard
# called by: 
# executor: duel_leaderboard

execute if score ".global" dueling_rank matches 0 run event entity @s spark:set_rank_1
execute if score ".global" dueling_rank matches 1 run event entity @s spark:set_rank_2
execute if score ".global" dueling_rank matches 2 run event entity @s spark:set_rank_3
execute if score ".global" dueling_rank matches 3 run event entity @s spark:set_rank_4
execute if score ".global" dueling_rank matches 4 run event entity @s spark:set_rank_5
execute if score ".global" dueling_rank matches 5 run event entity @s spark:set_rank_6
execute if score ".global" dueling_rank matches 6 run event entity @s spark:set_rank_7
execute if score ".global" dueling_rank matches 7 run event entity @s spark:set_rank_8
execute if score ".global" dueling_rank matches 8 run event entity @s spark:set_rank_9
execute if score ".global" dueling_rank matches 9 run event entity @s spark:set_rank_10
#  the rank will only get to 9 so we need to offset this
# execute if score ".global" dueling_rank matches 10 run event entity @s spark:set_rank_10
