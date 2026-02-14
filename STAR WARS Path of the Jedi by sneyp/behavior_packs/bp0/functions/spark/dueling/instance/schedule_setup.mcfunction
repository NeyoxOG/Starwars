# © Spark Universe, 2023
# authors: Jannis
# description: Wait for the chunks to be loaded, then set up the room
# called by: ../setup_instances
# executor: player


schedule on_area_loaded add ~-24 ~ ~-24 ~24 ~ ~24 spark/dueling/instance/setup_room
tp @s ~8 ~ ~ 90 10
tag @s remove respawned
