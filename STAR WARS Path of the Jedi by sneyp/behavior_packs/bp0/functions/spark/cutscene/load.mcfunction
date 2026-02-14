### function to ensure all areas are loaded properly for cutscnenes

scoreboard players add .cs_loading CS_trigger 1


inputpermission set @a[tag=!dev] camera disabled
inputpermission set @a[tag=!dev] movement disabled



# not setup, implemented 3 areas
execute if score .ch02_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch02_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/load
execute if score .ch02_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 3 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.2 spark/cutscene/start_on_loaded


# not setup, implemented, 3 areas
execute if score .ch02_c04 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch02_c04 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded



# not setup, 1 area
execute if score .ch02_c06 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup
execute if score .ch02_c07 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup
#execute if score .ch02_c08 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch02_c10 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch02_c10 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup, implemented, 3 areas
execute if score .ch02_c11 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch02_c11 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/load
execute if score .ch02_c11 CS_trigger matches 1 if score .cs_loading CS_trigger matches 3 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.2 spark/cutscene/start_on_loaded


# not setup
execute if score .ch02_c12 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup
#execute if score .ch06_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup
#execute if score .ch06_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup
#execute if score .ch07_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup, implemented, 4 areas
execute if score .ch07_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch07_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/load
execute if score .ch07_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 3 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.2 spark/cutscene/load
execute if score .ch07_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 4 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.3 spark/cutscene/load
execute if score .ch07_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 5 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.4 spark/cutscene/start_on_loaded


# not setup, implemented, 1 area
execute if score .ch07_c05 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded



# not setup, implemented, 1 area
execute if score .ch07_c06 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup, implemented, 3 areas
execute if score .ch08_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch08_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/load
execute if score .ch08_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 3 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.2 spark/cutscene/start_on_loaded


# not setup, implemneted, 2 areas
execute if score .ch08_c03 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch08_c03 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch08_c11 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch08_c11 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch08_c13 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch08_c13 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch09_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch09_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch09_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch09_c02 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded


# not setup
#execute if score .ch09_c03 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/start_on_loaded


# not setup, implemented, 2 areas
execute if score .ch10_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 1 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.0 spark/cutscene/load
execute if score .ch10_c01 CS_trigger matches 1 if score .cs_loading CS_trigger matches 2 as @p run schedule on_area_loaded add tickingarea tmp.cutscene.1 spark/cutscene/start_on_loaded
