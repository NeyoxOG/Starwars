# © Spark Universe, 2023
# authors: FetchBot
# description: 
# called by: spark/temple_crafting_room/setup

event entity @e[type=spark:lightsaber_ui_npc,x=8835,y=24,z=8949,r=32] spark:enable_crafting
# dialogue change @e[type=spark:lightsaber_ui_npc,x=8835,y=24,z=8949,r=32] gui.lightsaber_custom_stance:single

# spawn in the elevator buttons
#execute positioned 8838.57 27.00 8929.51 rotated 90 0 run function spark/temple_crafting_rooms/summon_buttons