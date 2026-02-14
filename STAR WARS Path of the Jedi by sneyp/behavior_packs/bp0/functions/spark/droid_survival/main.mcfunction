execute if score .state droid_survival matches 1.. run scoreboard players add .timer droid_survival 1

#Wave controllers
execute if score .state droid_survival matches 1 positioned 8825 102 -10 run function spark/droid_survival/story/intro/loop
execute if score .state droid_survival matches 2 run function spark/droid_survival/waves/loop
execute if score .state droid_survival matches 3 positioned 9136 105 72 run function spark/droid_survival/story/outro/loop
execute if score .state droid_survival matches 4 run function spark/droid_survival/story/tp_back
execute if score .state droid_survival matches -1 as @a[tag=in_droid_survival] run function spark/droid_survival/return_players