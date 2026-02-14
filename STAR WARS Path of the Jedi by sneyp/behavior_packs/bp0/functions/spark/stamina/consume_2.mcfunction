
execute unless entity @s[scores={stamina=2..}] run function spark/stamina/not_charged
tag @s[scores={stamina=2..}] add enough_stamina
execute if entity @s[tag=enough_stamina] run scoreboard players remove @s stamina 2
execute if entity @s[tag=enough_stamina] run function spark/stamina/after_use
tag @s remove enough_stamina
