# © Spark Universe, 2023
# authors: Jannis
# description: Runs when the player gets hit by the opponent
# called by: duel_opponent anim controller
# executor: player


execute if entity @s[tag=blocking] unless entity @e[family=sith_opponent,r=10] run particle spark:lightsaber_contact ~ ~ ~
execute if entity @s[tag=blocking] if entity @e[family=sith_opponent,r=10] run particle spark:lightsaber_contact_sith ~ ~ ~
execute if entity @s[tag=blocking] if entity @e[family=sith_opponent,r=10] run particle spark:sith_lightsaber_swing_sparks ~ ~0.8 ~
execute if entity @s[tag=blocking] run playsound sound.spark.lightsaber_clash @a
execute if entity @s[tag=blocking] run function spark/stamina/consume_1_all

execute unless entity @s[tag=blocking] run playsound sound.spark.player_lightsaber_hit @s

playanimation @s animation.spark.player.block_hit
