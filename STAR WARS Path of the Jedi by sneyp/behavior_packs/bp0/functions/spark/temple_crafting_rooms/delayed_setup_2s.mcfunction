# © Spark Universe, 2023
# authors: FetchBot
# description: 
# called by: spark/temple_crafting_room/setup

# event entity @e[type=spark:lightsaber_ui_npc,x=8835,y=24,z=8949,r=32] spark:enable_crafting
execute as @e[type=spark:lightsaber_ui_npc,x=8835,y=24,z=8949,r=32] run dialogue change @s gui.lightsaber_custom_stance:single

tickingarea remove temp_crafting_room