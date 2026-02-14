#
tag @s add me

execute as @e[tag=insight] if score @s ID = @e[tag=me,c=1] ID run scoreboard players set @s[scores={t1=..90}] t1 90

tag @s remove me