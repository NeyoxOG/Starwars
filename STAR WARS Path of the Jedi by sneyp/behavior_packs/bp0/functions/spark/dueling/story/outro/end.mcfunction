event entity @e[type=spark:dojo_elevator_door,x=9000,y=21,z=8999,r=3] spark:open_door
event entity @s spark:reset_npc
# dialogue change @s spark:lightsaber_dueling.npc.kelleran.again_loss
titleraw @a actionbar {"rawtext":[{"text":"hud:hint:"},{"translate":"lightsaber_dueling.tip.play_again.tip1"}]}
tag @s remove has_quest
function spark/dueling/story/intro/enable_circle