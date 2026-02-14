### main loop of cutscenes
### spark/loop

## base management

inputpermission set @a[tag=!dev] camera disabled
inputpermission set @a[tag=!dev] movement disabled

## cutscenes
execute if score .ch02_c01 CS_trigger matches 1 run function spark/cutscene/main_ch02_c01
execute if score .ch02_c04 CS_trigger matches 1 run function spark/cutscene/main_ch02_c04
execute if score .ch02_c06 CS_trigger matches 1 run function spark/cutscene/main_ch02_c06
execute if score .ch02_c07 CS_trigger matches 1 run function spark/cutscene/main_ch02_c07
execute if score .ch02_c08 CS_trigger matches 1 run function spark/cutscene/main_ch02_c08
execute if score .ch02_c10 CS_trigger matches 1 run function spark/cutscene/main_ch02_c10
execute if score .ch02_c11 CS_trigger matches 1 run function spark/cutscene/main_ch02_c11
execute if score .ch02_c12 CS_trigger matches 1 run function spark/cutscene/main_ch02_c12
execute if score .ch02_c13 CS_trigger matches 1 run function spark/cutscene/main_ch02_c13
execute if score .ch06_c01 CS_trigger matches 1 run function spark/cutscene/main_ch06_c01
execute if score .ch06_c02 CS_trigger matches 1 run function spark/cutscene/main_ch06_c02
execute if score .ch07_c01 CS_trigger matches 1 run function spark/cutscene/main_ch07_c01
execute if score .ch07_c02 CS_trigger matches 1 run function spark/cutscene/main_ch07_c02
execute if score .ch07_c05 CS_trigger matches 1 run function spark/cutscene/main_ch07_c05
execute if score .ch07_c06 CS_trigger matches 1 run function spark/cutscene/main_ch07_c06
execute if score .ch08_c01 CS_trigger matches 1 run function spark/cutscene/main_ch08_c01
execute if score .ch08_c03 CS_trigger matches 1 run function spark/cutscene/main_ch08_c03
execute if score .ch08_c11 CS_trigger matches 1 run function spark/cutscene/main_ch08_c11
execute if score .ch08_c13 CS_trigger matches 1 run function spark/cutscene/main_ch08_c13
execute if score .ch09_c01 CS_trigger matches 1 run function spark/cutscene/main_ch09_c01
execute if score .ch09_c02 CS_trigger matches 1 run function spark/cutscene/main_ch09_c02
execute if score .ch09_c03 CS_trigger matches 1 run function spark/cutscene/main_ch09_c03
execute if score .ch10_c01 CS_trigger matches 1 run function spark/cutscene/main_ch10_c01
