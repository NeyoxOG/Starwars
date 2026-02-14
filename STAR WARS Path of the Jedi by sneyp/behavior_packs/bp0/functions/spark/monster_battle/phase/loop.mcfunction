#
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1 run function spark/monster_battle/phase/monster_1/chap1
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 2 run function spark/monster_battle/phase/monster_1/chap2
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 3 run function spark/monster_battle/phase/monster_1/chap3
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 4 run function spark/monster_battle/phase/monster_1/chap4
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 5 run function spark/monster_battle/phase/monster_1/chap5
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 6 run function spark/monster_battle/phase/monster_1/chap6
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 7 run function spark/monster_battle/phase/monster_1/chap7
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 8 run function spark/monster_battle/phase/monster_1/chap8
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 9 run function spark/monster_battle/phase/monster_1/chap9

#
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1 run function spark/monster_battle/phase/monster_2/chap1
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 2 run function spark/monster_battle/phase/monster_2/chap2
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 3 run function spark/monster_battle/phase/monster_2/chap3
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 4 run function spark/monster_battle/phase/monster_2/chap4
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 5 run function spark/monster_battle/phase/monster_2/chap5
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 6 run function spark/monster_battle/phase/monster_2/chap6
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 7 run function spark/monster_battle/phase/monster_2/chap7
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 8 run function spark/monster_battle/phase/monster_2/chap8
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 9 run function spark/monster_battle/phase/monster_2/chap9

#
execute if score .monster .monster_battle matches 3 if score .phase .monster_battle matches 1 run function spark/monster_battle/phase/monster_3/chap1
execute if score .monster .monster_battle matches 3 if score .phase .monster_battle matches 2 run function spark/monster_battle/phase/monster_3/chap2
execute if score .monster .monster_battle matches 3 if score .phase .monster_battle matches 3 run function spark/monster_battle/phase/monster_3/chap3
execute if score .monster .monster_battle matches 3 if score .phase .monster_battle matches 4 run function spark/monster_battle/phase/monster_3/chap4
execute if score .monster .monster_battle matches 3 if score .phase .monster_battle matches 5 run function spark/monster_battle/phase/monster_3/chap5

#/tp @s 
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 1 run tp @a[tag=death_can_respawn] 6330.78 158.00 5958.33 6.02 0.52
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 2 run tp @a[tag=death_can_respawn] 6294.56 151.00 6012.10 1.25 -4.75
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 3 run tp @a[tag=death_can_respawn] 6281.01 154.00 6044.43 71.77 6.61
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 4 run tp @a[tag=death_can_respawn] 6202.31 101.00 5968.38 93.58 1.04
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 99 run tp @a[tag=death_can_respawn] 6049.37 53.00 5999.82 90 0
execute if score .monster .monster_battle matches 1 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 1.. run tag @a[tag=death_can_respawn] remove death_can_respawn

#
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 1 run tp @a[tag=death_can_respawn] 8939.18 48.00 5746.67 -70.98 -5.64
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 2 run tp @a[tag=death_can_respawn] 8985.08 48.00 5753.76 -53.24 -4.28
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 3 run tp @a[tag=death_can_respawn] 9174.29 51.00 6116.17 -1.77 -6.78
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 4 run tp @a[tag=death_can_respawn] 9119.56 57.00 5900.63 -16.49 -8.35
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 5 run tp @a[tag=death_can_respawn] 9173.82 51.00 6101.70 -1.60 -6.05
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 99 run tp @a[tag=death_can_respawn] 8860.20 55.00 6118.63 90 -2.25
execute if score .monster .monster_battle matches 2 if score .phase .monster_battle matches 1..9 if score .respawn .monster_battle matches 1.. run tag @a[tag=death_can_respawn] remove death_can_respawn