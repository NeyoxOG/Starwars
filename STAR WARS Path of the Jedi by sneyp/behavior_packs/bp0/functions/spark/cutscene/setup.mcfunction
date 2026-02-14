### function to reset/setup cutscene system
### called: manually || spark/setup || ./cutscene_x (to reset)


### setup scoreboards
# save triggered scene: 0 = idle; 1 = triggered
scoreboard objectives add CS_trigger dummy
# cutscene timer
scoreboard objectives add CS_timer dummy

### setup timer
scoreboard players set .timer CS_timer -1
scoreboard players set .timer_shot CS_timer 0

### triggers
## trigger if any cutscene is triggered; save some executes
scoreboard players set .cs_trigger CS_trigger 0 
scoreboard players set .cs_loading CS_trigger 0

scoreboard players set .cs_corusc_alt CS_trigger 0


## triggeres for each cutscene each
scoreboard players set .ch02_c01 CS_trigger 0
scoreboard players set .ch02_c04 CS_trigger 0
scoreboard players set .ch02_c06 CS_trigger 0
scoreboard players set .ch02_c07 CS_trigger 0
scoreboard players set .ch02_c08 CS_trigger 0
scoreboard players set .ch02_c10 CS_trigger 0
scoreboard players set .ch02_c11 CS_trigger 0
scoreboard players set .ch02_c12 CS_trigger 0
scoreboard players set .ch02_c13 CS_trigger 0
scoreboard players set .ch06_c01 CS_trigger 0
scoreboard players set .ch06_c02 CS_trigger 0
scoreboard players set .ch07_c01 CS_trigger 0
scoreboard players set .ch07_c02 CS_trigger 0
scoreboard players set .ch07_c05 CS_trigger 0
scoreboard players set .ch07_c06 CS_trigger 0
scoreboard players set .ch08_c01 CS_trigger 0
scoreboard players set .ch08_c03 CS_trigger 0
scoreboard players set .ch08_c11 CS_trigger 0
scoreboard players set .ch08_c13 CS_trigger 0
scoreboard players set .ch09_c01 CS_trigger 0
scoreboard players set .ch09_c02 CS_trigger 0
scoreboard players set .ch09_c03 CS_trigger 0
scoreboard players set .ch10_c01 CS_trigger 0



### clear invisibility and FOV
effect @a clear
gamemode a @a[tag=!dev]
inputpermission set @a[tag=!dev] camera enabled
inputpermission set @a[tag=!dev] movement enabled
camera @a[tag=!dev] clear
event entity @a[tag=!dev] spark:set_not_in_cutscene



tickingarea remove tmp.cutscene.0
tickingarea remove tmp.cutscene.1
tickingarea remove tmp.cutscene.2
tickingarea remove tmp.cutscene.3
tickingarea remove tmp.cutscene.4
