scoreboard players set .state droid_survival 2
scoreboard players set .timer droid_survival 0
event entity @e[type=spark:holo_mace_windu,c=1] spark:reset_npc
function spark/droid_survival/waves/start

tag @a remove death_can_respawn

playsound sound.spark.transitioner_kamino_outdoors @a ~~~
music stop 0.1
music play sound.spark.music.JangosEscape 1.0 1.0 loop