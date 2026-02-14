### function to make players invisible and only let the host be visible
### return tag host 'host'
### called: on join in ac bp

tag @s remove is_host

tag @s add data_new
tag @p[tag=!data_new] add data_origin
execute unless entity @p[tag=data_origin] run tag @s remove data_new
execute if entity @p[tag=data_origin] if score .state tutorial matches 1.. run function spark/catchup/give_appropriate_items

execute unless entity @p[tag=is_host] run tag @s add is_host

