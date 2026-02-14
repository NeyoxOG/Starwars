# © Spark Universe, 2022
# authors: Jannis
# description: Set up scoreboards, etc.
# called by: ../register_kill

execute if entity @s[scores={stamina=0}] run playsound sound.spark.force_empty @s
execute if entity @s[scores={stamina=0}] run playsound sound.spark.force_exhausted_quiet @s
event entity @s[scores={stamina=0}] spark:set_stamina_0
event entity @s[scores={stamina=1}] spark:set_stamina_1
event entity @s[scores={stamina=2}] spark:set_stamina_2
event entity @s[scores={stamina=3}] spark:set_stamina_3
event entity @s[scores={stamina=4}] spark:set_stamina_4
event entity @s[scores={stamina=5}] spark:set_stamina_5
event entity @s[scores={stamina=6}] spark:set_stamina_6
event entity @s[scores={stamina=7}] spark:set_stamina_7
event entity @s[scores={stamina=8}] spark:set_stamina_8
event entity @s[scores={stamina=9}] spark:set_stamina_9
event entity @s[scores={stamina=10}] spark:set_stamina_10
event entity @s[scores={stamina=11}] spark:set_stamina_11
event entity @s[scores={stamina=12}] spark:set_stamina_12

