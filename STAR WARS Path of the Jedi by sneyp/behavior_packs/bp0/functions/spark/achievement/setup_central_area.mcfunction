# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/setup

# 8894 25.00 9159
# 8898 25.00 9165
# 8905 25.00 9163
# 8905 25.00 9155
# 8898 25.00 9153
kill @e[type=spark:display_small,x=8900,y=27,z=9159,r=16]
kill @e[type=spark:hologram_small,x=8900,y=27,z=9159,r=16]

summon spark:display_small 8894 24.5 9159 0 0 "spark:set_hologram_0"
tag @e[type=spark:display_small,x=8894,y=25,z=9159,r=1] add "Lightsaber_Duelling"
summon spark:display_small 8898 24.5 9165 0 0 "spark:set_hologram_4"
tag @e[type=spark:display_small,x=8898,y=25,z=9165,r=1] add "Ancient_Puzzle"
summon spark:display_small 8905 24.5 9163 0 0 "spark:set_hologram_3"
tag @e[type=spark:display_small,x=8905,y=25,z=9163,r=1] add "Droid_Survival"
summon spark:display_small 8905 24.5 9155 0 0 "spark:set_hologram_1"
tag @e[type=spark:display_small,x=8905,y=25,z=9155,r=1] add "Escape_the_Battleship"
summon spark:display_small 8898 24.5 9153 0 0 "spark:set_hologram_2"
tag @e[type=spark:display_small,x=8898,y=25,z=9153,r=1] add "Monster_Battle_Arena"

kill @e[type=spark:display_main]
kill @e[type=spark:hologram_main]
summon  spark:display_main 8900 25.00 9159
tickingarea remove "temp_achievement_spawn_area"

# summon spark:hologram_small 8894 25.25 9159 90 0 "spark:type_1"
# summon spark:hologram_small 8898 25.25 9165 18 0 "spark:type_2"
# summon spark:hologram_small 8905 25.25 9163 306 0 "spark:type_3"
# summon spark:hologram_small 8905 25.25 9155 234 0 "spark:type_4"
# summon spark:hologram_small 8898 25.25 9153 162 0 "spark:type_5"