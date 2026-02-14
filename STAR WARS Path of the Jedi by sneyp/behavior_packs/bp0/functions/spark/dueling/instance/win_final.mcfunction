# © Spark Universe, 2023
# authors: Jannis
# description: Win the last round
# called by: 
# executor: duel_force_field

function spark/achievement/trigger/duelling_post
tellraw @a[r=50] { "rawtext": [ { "text": "You won against everyone!" } ] }
tp @a[r=50] 9000 23 8990
