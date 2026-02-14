# move towards destination marker (box entity)
execute at @s run tp ~ ~ ~ facing @e[tag=scan_marker,c=1]
execute at @s unless entity @e[tag=scan_marker,c=1,r=0.5] run tp ^ ^ ^0.4 true
execute at @s unless entity @e[tag=scan_marker,c=1,r=0.3] run tp ^ ^ ^0.2 true
execute at @s if entity @e[tag=scan_marker,c=1,r=0.33,rm=0.11] run tp ^ ^ ^0.1 true
execute at @s if entity @e[tag=scan_marker,c=1,r=0.33,rm=0.11] run tp ^ ^ ^0.1 true

#
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-180,ry=-135] ~ ~ ~ -180
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-135,ry=-45] ~ ~ ~ -90
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-45,ry=45] ~ ~ ~ 0
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=45,ry=-135] ~ ~ ~ 90
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=135,ry=180] ~ ~ ~ 180

execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ^ ^ ^0.15 true
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ^ ^ ^0.15 true

# if that fails (far from destination, close to start) move towards player
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ~ ~ ~ facing @p

execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ^ ^ ^0.15 true

# if moving towards player fails, align direction to grid and try again
# helps prevent not moving by moving parallel to blocks
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-180,ry=-135] ~ ~ ~ -180
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-135,ry=-45] ~ ~ ~ -90
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=-45,ry=45] ~ ~ ~ 0
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=45,ry=-135] ~ ~ ~ 90
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp @s[rym=135,ry=180] ~ ~ ~ 180

execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ^ ^ ^0.15 true
execute at @s if entity @e[tag=scan_marker,c=1,rm=2.2] if entity @e[tag=entity_grabbed,r=0.6] run tp ^ ^ ^0.15 true

# move to destination along cardinals again based on relative position
# low tech way to do another pass of general movement
execute at @s positioned ~20.01 ~ ~ if entity @e[tag=scan_marker,c=1,r=20] if entity @e[tag=entity_grabbed,r=0.4] run tp ~0.05 ~ ~ true
execute at @s positioned ~-20.01 ~ ~ if entity @e[tag=scan_marker,c=1,r=20] if entity @e[tag=entity_grabbed,r=0.4] run tp ~-0.05 ~ ~ true
execute at @s positioned ~ ~ ~20.01 if entity @e[tag=scan_marker,c=1,r=20] if entity @e[tag=entity_grabbed,r=0.4] run tp ~ ~ ~0.05 true
execute at @s positioned ~ ~ ~-20.01 if entity @e[tag=scan_marker,c=1,r=20] if entity @e[tag=entity_grabbed,r=0.4] run tp ~ ~ ~-0.05 true

# lower if destination is below
execute at @s positioned ~ ~-2.21 ~ if entity @e[tag=scan_marker,c=1,r=2.2] if entity @e[tag=entity_grabbed,r=1.6] run tag @s add lift
execute at @s positioned ~ ~-2.21 ~ if entity @e[tag=scan_marker,c=1,r=2.2] if entity @e[tag=entity_grabbed,r=1.6] run tp ~ ~-0.1 ~ true
execute at @s positioned ~ ~-2.21 ~ if entity @e[tag=scan_marker,c=1,r=2.2] if entity @e[tag=entity_grabbed,r=1.6] run tp ~ ~-0.1 ~ true

# raise if movement has still been failing
# the most key step to movement accross terain
execute as @s[tag=!lift] at @s if entity @e[tag=scan_marker,c=1,rm=2.1] if entity @e[tag=entity_grabbed,r=1] run tp ~ ~0.2 ~ true

# particle visualizer

# teleport target to box and kill box
execute at @s run tp @s ~ ~ ~ facing @p
execute as @e[tag=entity_grabbed] at @s run tp @s @e[type=spark:marker_box,tag=tele_box,tag=!kill,c=1]
execute as @e[tag=entity_grabbed] at @s run tp @s ~ ~ ~ facing @p

#
tag @s add kill