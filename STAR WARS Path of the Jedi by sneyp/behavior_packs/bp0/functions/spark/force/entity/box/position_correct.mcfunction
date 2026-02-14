#
tag @s remove bail

#
function spark/force/entity/box/check_stuck

execute at @s[tag=stuck] run tp @s ~1 ~ ~ true
execute at @s[tag=stuck] run tp @s ~-1 ~ ~ true
execute at @s[tag=stuck] run tp @s ~ ~ ~1 true
execute at @s[tag=stuck] run tp @s ~ ~ ~-1 true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck

execute at @s[tag=stuck] run tp @s @e[tag=glass_placer,tag=size_2,c=1]
execute at @s[tag=stuck] run tp @s @e[tag=glass_placer,tag=size_3,c=1]

execute at @s[tag=stuck] run tp @s ~2 ~ ~ true
execute at @s[tag=stuck] run tp @s ~-2 ~ ~ true
execute at @s[tag=stuck] run tp @s ~ ~ ~2 true
execute at @s[tag=stuck] run tp @s ~ ~ ~-2 true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck

execute at @s[tag=stuck] if entity @e[tag=glass_placer,tag=size_2,c=1] run tag @s add bails

execute at @s[tag=stuck,tag=!bail] run tp @s @e[tag=glass_placer,tag=size_3,c=1]
execute at @s[tag=stuck,tag=!bail] run tp @s @e[tag=glass_placer,tag=size_5,c=1]

execute at @s[tag=stuck,tag=!bail] run tp @s ~2 ~ ~ true
execute at @s[tag=stuck,tag=!bail] run tp @s ~-2 ~ ~ true
execute at @s[tag=stuck,tag=!bail] run tp @s ~ ~ ~2 true
execute at @s[tag=stuck,tag=!bail] run tp @s ~ ~ ~-2 true

execute at @s[tag=stuck,tag=!bail] run function spark/force/entity/box/check_stuck

execute at @s[tag=stuck,tag=!bail] run tp @s ~3 ~ ~ true
execute at @s[tag=stuck,tag=!bail] run tp @s ~-3 ~ ~ true
execute at @s[tag=stuck,tag=!bail] run tp @s ~ ~ ~3 true
execute at @s[tag=stuck,tag=!bail] run tp @s ~ ~ ~-3 true

execute at @s[tag=stuck,tag=!bail] run function spark/force/entity/box/check_stuck

execute at @s[tag=stuck,tag=!bail] if entity @e[tag=glass_placer,tag=size_3,c=1] run tag @s add bail

# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~4.1 ~ ~ true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~-4.1 ~ ~ true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~ ~ ~4.1 true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~ ~ ~-4.1 true

# execute at @s[tag=stuck,tag=!bail,type=spark:box] run function spark/force/entity/box/check_stuck

# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~5.1 ~ ~ true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~-5.1 ~ ~ true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~ ~ ~5.1 true
# execute at @s[tag=stuck,tag=!bail,type=spark:box] run tp @s ~ ~ ~-5.1 true

execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~4.1 ~ ~ true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~-4.1 ~ ~ true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~ ~ ~4.1 true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~ ~ ~-4.1 true

execute at @s[tag=stuck,tag=!bail,tag=force_cube] run function spark/force/entity/box/check_stuck

execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~5.1 ~ ~ true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~-5.1 ~ ~ true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~ ~ ~5.1 true
execute at @s[tag=stuck,tag=!bail,tag=force_cube] run tp @s ~ ~ ~-5.1 true

# Bail
execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true

execute at @s[tag=stuck] run function spark/force/entity/box/check_stuck
execute at @s[tag=stuck] run tp @s ~ ~1 ~ true