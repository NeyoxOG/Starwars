# © Spark Universe, 2023
# authors: Jannis
# description: 
# called by: loop
# executor: spark:powerup_spawner

execute if entity @s[tag=powerup_health] run effect @p[m=!spectator,r=2] instant_health 10 10 true
execute if entity @s[tag=powerup_force] as @p[m=!spectator,r=2] run function spark/stamina/recharge_full
execute at @s[tag=powerup_health] run particle spark:powerup_collect_health ~ ~ ~
execute at @s[tag=powerup_force] run particle spark:powerup_collect_force ~ ~ ~
execute at @s[tag=powerup_force] run playsound sound.spark.kamino_powerup @p[m=!spectator]
execute at @s[tag=powerup_health] run playsound sound.spark.kamino_powerup @p[m=!spectator]

tag @s remove active_powerup
tag @s remove powerup_health
tag @s remove powerup_force
event entity @s reset