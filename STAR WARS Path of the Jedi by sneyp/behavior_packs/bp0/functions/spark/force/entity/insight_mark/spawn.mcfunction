# © Spark Universe, 2023
# authors: ChainsawNinja
# description: summoning insight_markers
# called by: loop

## TEMP DEV FUNCTION
## CURRENTLY CALLED BY BATS

#
tag @e[type=spark:marker_force] add old
summon spark:marker_force ~ ~ ~
tag @e[type=spark:marker_force,tag=!old] add insight_mark
kill @s