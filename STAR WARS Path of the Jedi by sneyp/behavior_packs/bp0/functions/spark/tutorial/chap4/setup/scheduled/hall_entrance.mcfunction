fill 3315 51 0 3315 52 0 air
execute positioned 3315 51 0 unless entity @e[type=spark:kelleran_beq,c=1,r=5] run summon spark:kelleran_beq ~ ~ ~ 90 0 spark:quest_npc
execute positioned 3315 51 0 run event entity @e[type=spark:kelleran_beq,c=1,r=5] spark:enable_quest_icon
execute positioned 3315 51 0 run dialogue change @e[type=spark:kelleran_beq,c=1,r=5] spark:jedi_temple.kelleran.4
execute positioned 3315 51 0 run dialogue change @e[type=spark:kelleran_beq,c=1,r=5] spark:jedi_temple.kelleran.4 @a