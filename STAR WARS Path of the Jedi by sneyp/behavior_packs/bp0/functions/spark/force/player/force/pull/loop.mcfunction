#
execute unless score .phase .monster_battle matches 7 if entity @s[scores={item.charge=10},tag=!no_force_end] at @s run function spark/force/player/force/pull/blast