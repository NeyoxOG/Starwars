execute if score .timer tutorial matches 1 run title @a actionbar hud:credits:
execute if score .timer tutorial matches 1 run music stop 1.0
execute if score .timer tutorial matches 1 run playsound sound.spark.transitioner_fade_general @a
execute if score .timer tutorial matches 1 run music play sound.spark.music.QueenAmidalaCredits
execute if score .timer tutorial matches 1 run inputpermission set @a[tag=!dev] camera disabled
execute if score .timer tutorial matches 1 run inputpermission set @a[tag=!dev] movement disabled

execute if score .timer tutorial matches 1 run event entity @e[type=spark:yoda,c=1] spark:reset_npc
execute if score .timer tutorial matches 150 run event entity @e[type=spark:yoda,c=1] spark:despawn

execute if score .timer tutorial matches 150 run event entity @e[type=spark:anakin_skywalker,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[tag=chunk_loader,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[type=spark:ahsoka_tano,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[type=spark:mace_windu,c=1] spark:despawn

execute if score .timer tutorial matches 150 run event entity @e[type=spark:obi_wan_kenobi,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[type=spark:kelleran_beq,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[type=spark:padme_amidala,c=1] spark:despawn
execute if score .timer tutorial matches 150 run event entity @e[type=spark:jar_jar_binks,c=1] spark:despawn

execute if score .timer tutorial matches 1580 run function spark/tutorial/next