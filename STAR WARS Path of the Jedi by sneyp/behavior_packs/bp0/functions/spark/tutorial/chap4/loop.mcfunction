# © Spark Universe, 2023
# authors: dragonmaster95
# called by: tutorial/loop

# Coursant/Jedy Temple
execute if score .substate tutorial matches 0 run function spark/tutorial/chap4/intro
execute if score .substate tutorial matches 1 run function spark/tutorial/chap4/s1
execute if score .substate tutorial matches 2 positioned ~ ~ ~-22 run function spark/tutorial/chap4/s2
execute if score .substate tutorial matches 3 run function spark/tutorial/chap4/s3
execute if score .substate tutorial matches 4 positioned ~ ~ ~-22 run function spark/tutorial/chap4/s4
execute if score .substate tutorial matches 5 run function spark/tutorial/chap4/s5
execute if score .substate tutorial matches 6 run function spark/tutorial/chap4/teleported_to_temple