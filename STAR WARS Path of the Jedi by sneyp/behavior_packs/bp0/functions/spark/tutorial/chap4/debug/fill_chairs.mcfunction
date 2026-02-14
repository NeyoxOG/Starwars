#run it: execute positioned 9200 37 8984 rotated 0 0 

event entity @e[family=npc,r=10] spark:despawn
#execute rotated 65 0 run summon spark:eeth_koth ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 90 0 run summon spark:kit_fisto ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 115 0 run summon spark:shaak_ti ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 140 0 run summon spark:oppo_rancisis ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 193 0 run summon spark:saesee_tiin ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 220 0 run summon spark:obi_wan_kenobi ^ ^ ^6 ~180 ~
#execute rotated 245 0 run summon spark:ki_adi_mundi ^ ^ ^6 ~180 ~ spark:sitting
#execute rotated 270 0 run summon spark:yoda ^ ^ ^6 ~180 ~
#execute rotated 295 0 run summon spark:mace_windu ^ ^ ^6 ~180 ~
#execute rotated 320 0 run summon spark:plo_koon ^ ^ ^6 ~180 ~ spark:sitting

execute rotated 65 0 run summon spark:coleman_kcaj ^ ^ ^6 ~180 ~
execute rotated 90 0 run summon spark:saesee_tiin ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 115 0 run summon spark:kit_fisto ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 140 0 run summon spark:stass_allie ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 167 0 run summon spark:mace_windu ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 193 0 run summon spark:yoda ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 220 0 run summon spark:obi_wan_kenobi ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 245 0 run summon spark:plo_koon ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 270 0 run summon spark:shaak_ti ^ ^ ^6 ~180 ~ spark:sitting
execute rotated 295 0 run summon spark:ki_adi_mundi ^ ^ ^6 ~180 ~ spark:sitting

execute as @e[family=npc,r=10] at @s run ride @s start_riding @e[family=council_chair,c=1] teleport_rider if_group_fits