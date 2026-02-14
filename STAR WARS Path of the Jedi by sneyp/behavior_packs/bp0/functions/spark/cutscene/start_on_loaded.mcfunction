### Start cutscene when areas are loaded
### called by ./load

# start cutscene
scoreboard players set .cs_trigger CS_trigger 1
# reset loading function
scoreboard players set .cs_loading CS_trigger 0