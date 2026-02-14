# Consume 3 stamina, but only if the bar is at least at 3

execute unless entity @s[scores={stamina=3..}] run function spark/stamina/not_charged
tag @s[scores={stamina=3..}] add enough_stamina
execute if entity @s[tag=enough_stamina] run scoreboard players remove @s stamina 3
execute if entity @s[tag=enough_stamina] run function spark/stamina/after_use
tag @s remove enough_stamina
