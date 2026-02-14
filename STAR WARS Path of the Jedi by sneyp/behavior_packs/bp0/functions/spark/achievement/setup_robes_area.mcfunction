# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/setup

kill @e[type=spark:reward_cloak_pedestal,x=8964,y=27,z=9150,dx=20,dy=20,dz=20]

summon spark:reward_cloak_pedestal 8964 26 9168 180 0 "spark:cloak_dueling"
tag @e[type=spark:reward_cloak_pedestal,x=8964,y=26,z=9168,r=1] add "Lightsaber_Duelling_Post" 
summon spark:reward_cloak_pedestal 8964 26 9150 0 0 "spark:cloak_default"
tag @e[type=spark:reward_cloak_pedestal,x=8964,y=26,z=9150,r=1] add "Pilot"
summon spark:reward_cloak_pedestal 8974 26 9168 180 0 "spark:cloak_kamino"
tag @e[type=spark:reward_cloak_pedestal,x=8974,y=26,z=9168,r=1] add "Droid_Survival_Post"
summon spark:reward_cloak_pedestal 8974 26 9150 0 0 "spark:cloak_battleship"
tag @e[type=spark:reward_cloak_pedestal,x=8974,y=26,z=9150,r=1] add "Escape_the_Battleship_Post"
summon spark:reward_cloak_pedestal 8984 26 9168 180 0 "spark:cloak_monster"
tag @e[type=spark:reward_cloak_pedestal,x=8984,y=26,z=9168,r=1] add "Monster_Battle_Arena_Post"
summon spark:reward_cloak_pedestal 8984 26 9150 0 0 "spark:cloak_puzzles"
tag @e[type=spark:reward_cloak_pedestal,x=8984,y=26,z=9150,r=1] add "Ancient_Puzzle_Post"

tickingarea remove "temp_achievement_robes_area"

