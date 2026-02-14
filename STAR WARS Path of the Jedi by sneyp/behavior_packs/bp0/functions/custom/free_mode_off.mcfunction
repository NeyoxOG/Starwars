# Restores stricter defaults

gamerule keepinventory false
gamerule falldamage true
gamerule showcoordinates false

tag @s add hide_hotbar

tellraw @s {"rawtext":[{"text":"§c[Custom] Free-Mode deaktiviert."}]}
