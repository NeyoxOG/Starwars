scoreboard players set @a SS_ui_task 0
execute unless score ".global" dueling_rank matches 9.. run scoreboard players add ".global" dueling_rank 1
function spark/dueling/instance/update_leaderboard

execute if score ".global" dueling_rank matches 9 run function spark/achievement/trigger/duelling_post

execute if score ".global" dueling_rank matches 1 run function spark/dueling/story/outro/on_initial_win