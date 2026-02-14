# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: tutorial/loop

# Curcible setup
execute if score .substate tutorial matches 0 run function spark/tutorial/chap3/s1
execute if score .substate tutorial matches 1 run function spark/tutorial/chap3/s2
execute if score .substate tutorial matches 2 run function spark/tutorial/chap3/s3
execute if score .substate tutorial matches 3 run function spark/tutorial/chap3/s4

execute if score .substate tutorial matches 4 run function spark/tutorial/chap3/s5

execute if score .substate tutorial matches 5 run function spark/tutorial/chap3/s6
execute if score .substate tutorial matches 6 run function spark/tutorial/chap3/s7
execute if score .substate tutorial matches 7 run function spark/tutorial/chap3/s8
execute if score .substate tutorial matches 8 run function spark/tutorial/chap3/s9
execute if score .substate tutorial matches 9 run function spark/tutorial/chap3/s10
execute if score .substate tutorial matches 10 run function spark/tutorial/chap3/s11
execute if score .substate tutorial matches 11 run function spark/tutorial/chap3/s12
execute if score .substate tutorial matches 12 run function spark/tutorial/chap3/s13
execute if score .substate tutorial matches 13 run function spark/tutorial/chap3/s14

# need following mobs
# spark:master_huyang (empty)
# spark:training_remotes
# spark:ad-3
# spark:lx-r5