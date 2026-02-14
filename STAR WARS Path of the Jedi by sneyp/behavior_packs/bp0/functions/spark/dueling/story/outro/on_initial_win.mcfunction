function spark/achievement/trigger/duelling
scoreboard players set @a SS_ui_task 0
execute positioned 9000.62 22.00 8990.30 as @e[type=spark:kelleran_beq,r=1] run dialogue change @s spark:lightsaber_dueling.npc.kelleran.win
execute positioned 9000.62 22.00 8990.30 as @e[type=spark:kelleran_beq,r=1] run tag @s add has_quest

# tp @a 9000.5 22.00 8996.5 180 0

function spark/dueling/story/intro/disable_circle