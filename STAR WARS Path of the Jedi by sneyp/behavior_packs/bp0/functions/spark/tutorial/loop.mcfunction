# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: main loop

particle spark:tutorial_ambient_spark 0 3.4 0
particle spark:tutorial_ambient_grey 0 2.01 0

# tutorial chapter handling

execute if score .state tutorial matches 1 run function spark/tutorial/chap1/loop
execute if score .state tutorial matches 2 run function spark/tutorial/chap2/loop
execute if score .state tutorial matches 3 run function spark/tutorial/chap3/loop
execute if score .state tutorial matches 4 positioned 9200 37 9006 run function spark/tutorial/chap4/loop
execute if score .state tutorial matches 10 positioned 8926.5 24.5 9159.5 run function spark/tutorial/game_end/loop
#execute if score .state tutorial matches 5 positioned 9200 37 9006 run function spark/tutorial/chap5/loop


scoreboard players add .timer tutorial 1