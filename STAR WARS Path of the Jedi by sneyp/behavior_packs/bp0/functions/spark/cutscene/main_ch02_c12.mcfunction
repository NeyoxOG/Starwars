### main loop of cutscene ch02 c12
# called like: execute if score .timer CS_timer matches X run X 
# duration: 100 ticks


## visibility
effect @a[tag=!dev,tag=!is_host] invisibility 1 1 true
execute if score .timer CS_timer matches 20..730 positioned 9200.44 37.00 8984.51 run effect @e[tag=!dev,tag=!is_host,r=19,type=!spark:skybox_static,type=!spark:cutscene.knighting] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev,tag=!is_host] spark:set_in_cutscene
execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 790 run function spark/cutscene/inv_fill


## final player location
execute if score .timer CS_timer matches 730 run tp @a[tag=!dev] 9200.5 37 8984.5 -90 0
execute if score .timer CS_timer matches 725 run event entity @a spark:reset_cutscene_anim
execute if score .timer CS_timer matches 725 positioned 9200.44 37.00 8984.51 run effect @e[r=19] clear


## sound
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.knighting_ceremony @a
execute if score .timer CS_timer matches 5 run music stop 1.0
execute if score .timer CS_timer matches 6 run music play sound.spark.music.HighCouncilMeeting

## UI
# yes, we are adding every hiding tag, cos why not!
execute if score .timer CS_timer matches 21 run tag @a[tag=!dev] add hide_ui
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_hotbar

# important to mask action hint for player lock
execute if score .timer CS_timer matches 15 run title @a[tag=!dev] title hud:loading:full_black
execute if score .timer CS_timer matches 15 run scoreboard players set @a SS_ui_loading 11
execute if score .timer CS_timer matches 21 run scoreboard players set @a SS_ui_loading 0
execute if score .timer CS_timer matches 15..20 run title @a[tag=!dev] actionbar hud:blackbars
# execute if score .timer CS_timer matches 20..24 run title @a[tag=!dev] title hud:loading:
execute if score .timer CS_timer matches 26..50 run title @a[tag=!dev] title hud:loading:
execute if score .timer CS_timer matches 25 run title @a[tag=!dev] actionbar hud:blackbars_in


execute if score .timer CS_timer matches 396..460 run title @a[tag=!dev] title hud:loading:blackbars
execute if score .timer CS_timer matches 400 run titleraw @a actionbar { "rawtext": [ { "translate": "intro.coruscant.jedi_council.npc.yoda.knighting_1.dialogue1" }]}
execute if score .timer CS_timer matches 460 run title @a[tag=!dev] actionbar hud:blackbars
execute if score .timer CS_timer matches 461 run title @a[tag=!dev] title hud:loading:

execute if score .timer CS_timer matches 596..660 run title @a[tag=!dev] title hud:loading:blackbars
execute if score .timer CS_timer matches 600 run titleraw @a actionbar { "rawtext": [ { "translate": "intro.coruscant.jedi_council.npc.yoda.knighting_1.dialogue2" }]}
execute if score .timer CS_timer matches 660 run title @a[tag=!dev] actionbar hud:blackbars
execute if score .timer CS_timer matches 661 run title @a[tag=!dev] title hud:loading:

execute if score .timer CS_timer matches 704 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 720 run tag @a[tag=!dev] remove hide_ui
execute if score .timer CS_timer matches 720 run tag @a[tag=!dev] remove hide_hotbar

execute if score .timer tutorial matches 750 run title @a actionbar hud:game_card:
execute if score .timer tutorial matches 820 run function spark/tutorial/next


## particles
# execute if score .timer CS_timer matches 0..228 run particle spark:decal_floor_council 9200.5 37.04 8984.5


## models and triggers
execute if score .timer CS_timer matches 820 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 15 run tp @a[tag=!dev] 9200.61 37.00 8996.83
execute if score .timer CS_timer matches 19 run summon spark:skybox_static 9200.5 37 8984.5 0 0 spark:set_planet_archives
# player anim setup
execute if score .timer CS_timer matches 15 run summon spark:cutscene.player_lock 9200.5 36.5 8984.5 0 0
execute if score .timer CS_timer matches 16 run ride @p[tag=is_host] start_riding @e[type=spark:cutscene.player_lock,c=1] teleport_rider
execute if score .timer CS_timer matches 20 run event entity @a[tag=is_host] spark:play_cutscene_anim_knighting
# model shot
execute if score .timer CS_timer matches 20 run summon spark:cutscene.knighting 9200.5 37 8984.5 0 0 spark:stage_play
# remove model
execute if score .timer CS_timer matches 725 run event entity @e[type=spark:cutscene.knighting] spark:despawn
execute if score .timer CS_timer matches 725 run event entity @e[type=spark:skybox_static] spark:despawn
execute if score .timer CS_timer matches 725 run event entity @e[type=spark:cutscene.player_lock] spark:despawn
## camera 703 t
execute if score .timer CS_timer matches 17 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21 run inputpermission set @a[tag=!dev] camera disabled
execute if score .timer CS_timer matches 20..723 run function spark/cutscene/shots/ch02_c12_s1
execute if score .timer CS_timer matches 724 run event entity @a[tag=!dev] spark:reset_cam_used


## timer management
# reset
execute if score .timer CS_timer matches 821 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1
