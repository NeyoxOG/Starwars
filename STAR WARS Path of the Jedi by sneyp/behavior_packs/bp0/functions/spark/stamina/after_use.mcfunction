# © Spark Universe, 2023
# authors: Jannis
# description: Run after consuming stamina
# called by: 
# executor: player

scoreboard players set @s stamina_cooldown 40

# unlimited stamina
scoreboard players operation @s[tag=hide_hotbar] stamina = .max hotbar_stamina_size
scoreboard players operation @s[x=3200,y=60,z=0,r=330] stamina = .max hotbar_stamina_size
scoreboard players operation @s[x=8900,y=25,z=9159,r=120] stamina = .max hotbar_stamina_size
scoreboard players operation @s[x=9200,y=37,z=8984,r=30] stamina = .max hotbar_stamina_size
scoreboard players operation @s[x=8846,y=27,z=8928,r=40] stamina = .max hotbar_stamina_size

function spark/stamina/update_bar

