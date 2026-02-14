#Wave controllers
function spark/droid_survival/waves/controller

#Death plane
execute as @e[family=raider] at @s if entity @s[y=74,dy=10] run kill @s
#execute as @e[type=spark:box] at @s if entity @s[y=74,dy=10] run kill @s

#Player fell off platforms
execute as @a[tag=in_droid_survival,m=!creative] at @s if entity @s[y=45,dy=20] run tag @s add droid_survival_fell
scoreboard players add @a[tag=droid_survival_fell] droid_survival_timer 1
execute as @a[tag=droid_survival_fell] run function spark/droid_survival/waves/player_fell_off

#ambush stuff
function spark/droid_survival/waves/fake_player_timer
execute if score .spawnpoint_tmp1 droid_survival_timer matches 400.. positioned 9000 101 -8 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp1 droid_survival_timer matches 400.. positioned 9000 101 -8 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp1 droid_survival_timer 0

execute if score .spawnpoint_tmp2 droid_survival_timer matches 400.. positioned 9011 101 70 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp2 droid_survival_timer matches 400.. positioned 9011 101 70 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp2 droid_survival_timer 0

execute if score .spawnpoint_tmp3 droid_survival_timer matches 400.. positioned 9002 100 80 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp3 droid_survival_timer matches 400.. positioned 9002 100 80 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp3 droid_survival_timer 0

execute if score .spawnpoint_tmp4 droid_survival_timer matches 400.. positioned 9025 97 109 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp4 droid_survival_timer matches 400.. positioned 9025 97 109 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp4 droid_survival_timer 0

execute if score .spawnpoint_tmp5 droid_survival_timer matches 400.. positioned 9034 97 119 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp5 droid_survival_timer matches 400.. positioned 9034 97 119 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp5 droid_survival_timer 0

execute if score .spawnpoint_tmp6 droid_survival_timer matches 400.. positioned 8917 106 104 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp6 droid_survival_timer matches 400.. positioned 8917 106 104 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp6 droid_survival_timer 0

execute if score .spawnpoint_tmp7 droid_survival_timer matches 400.. positioned 8941 101 100 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp7 droid_survival_timer matches 400.. positioned 8941 101 100 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp7 droid_survival_timer 0

execute if score .spawnpoint_tmp8 droid_survival_timer matches 400.. positioned 8951 101 108 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp8 droid_survival_timer matches 400.. positioned 8951 101 108 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp8 droid_survival_timer 0

execute if score .spawnpoint_tmp9 droid_survival_timer matches 400.. positioned 8980 99 135 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp9 droid_survival_timer matches 400.. positioned 8980 99 135 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp9 droid_survival_timer 0

execute if score .spawnpoint_tmp10 droid_survival_timer matches 400.. positioned 8988 99 126 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp10 droid_survival_timer matches 400.. positioned 8988 99 126 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp10 droid_survival_timer 0

execute if score .spawnpoint_tmp11 droid_survival_timer matches 400.. positioned 8950 94 38 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp11 droid_survival_timer matches 400.. positioned 8950 94 38 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp11 droid_survival_timer 0

execute if score .spawnpoint_tmp12 droid_survival_timer matches 400.. positioned 8941 94 39 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp12 droid_survival_timer matches 400.. positioned 8941 94 39 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp12 droid_survival_timer 0

execute if score .spawnpoint_tmp13 droid_survival_timer matches 400.. positioned 8970 97 -53 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp13 droid_survival_timer matches 400.. positioned 8970 97 -53 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp13 droid_survival_timer 0

execute if score .spawnpoint_tmp14 droid_survival_timer matches 400.. positioned 8962 99 -62 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp14 droid_survival_timer matches 400.. positioned 8962 99 -62 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp14 droid_survival_timer 0

execute if score .spawnpoint_tmp15 droid_survival_timer matches 400.. positioned 8925 92 -82 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp15 droid_survival_timer matches 400.. positioned 8925 92 -82 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp15 droid_survival_timer 0

execute if score .spawnpoint_tmp16 droid_survival_timer matches 400.. positioned 8917 93 -91 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp16 droid_survival_timer matches 400.. positioned 8917 93 -91 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp16 droid_survival_timer 0

execute if score .spawnpoint_tmp17 droid_survival_timer matches 400.. positioned 9008 91 -74 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp17 droid_survival_timer matches 400.. positioned 9008 91 -74 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp17 droid_survival_timer 0

execute if score .spawnpoint_tmp18 droid_survival_timer matches 400.. positioned 9007 91 -84 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp18 droid_survival_timer matches 400.. positioned 9007 91 -84 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp18 droid_survival_timer 0

execute if score .spawnpoint_tmp19 droid_survival_timer matches 400.. positioned 9042 101 -43 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp19 droid_survival_timer matches 400.. positioned 9042 101 -43 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp19 droid_survival_timer 0

execute if score .spawnpoint_tmp20 droid_survival_timer matches 400.. positioned 9032 101 -43 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp20 droid_survival_timer matches 400.. positioned 9032 101 -43 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp20 droid_survival_timer 0

execute if score .spawnpoint_tmp21 droid_survival_timer matches 400.. positioned 9093 96 -15 if entity @p[m=!spectator,r=10] run function spark/droid_survival/waves/summon_random_mob_instant
execute if score .spawnpoint_tmp21 droid_survival_timer matches 400.. positioned 9093 96 -15 if entity @p[m=!spectator,r=10] run scoreboard players set .spawnpoint_tmp21 droid_survival_timer 0


#powerups
execute as @a[m=!spectator] at @s as @e[type=spark:powerup_spawner,r=1.3,tag=active_powerup] run function spark/droid_survival/powerups/collect

#death detection
execute as @a[tag=death_can_respawn,tag=in_droid_survival] run function spark/droid_survival/player_died
