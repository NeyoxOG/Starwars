# Consume 3 stamina, but also works if the stamina bar is already lower than 3

execute unless entity @s[scores={stamina=1..}] run function spark/stamina/not_charged
tag @s[scores={stamina=1..}] add enough_stamina
scoreboard players remove @s[scores={stamina=1..}] stamina 1
scoreboard players set @s[scores={stamina=..-1}] stamina 0
execute if entity @s[tag=enough_stamina] run function spark/stamina/after_use
tag @s remove enough_stamina
