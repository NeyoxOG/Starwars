# © Spark Universe, 2023
# authors: Jannis
# description: Set up game rules, scoreboards, etc. Should be executable at any time during development without disrupting testing
# called by: manually

mobevent events_enabled false
gamerule domobspawning false
gamerule doweathercycle false
gamerule dodaylightcycle false
gamerule dodaylightcycle false
gamerule naturalregeneration true
setworldspawn 3 0 -1
gamerule spawnradius 0
gamerule falldamage false
gamerule pvp false
gamerule showtags false
gamerule sendcommandfeedback false

scoreboard objectives add player_id dummy
scoreboard players reset * player_id
scoreboard players set .player_id player_id 1

scoreboard objectives add timer dummy

scoreboard objectives add ac_tps dummy

scoreboard objectives add SS_time dummy

scoreboard objectives add stamina dummy
scoreboard objectives add stamina_cooldown dummy
scoreboard objectives add double_jump dummy

function spark/companion/setup

scoreboard objectives add SS_temp dummy
scoreboard objectives add SS_tmp dummy

# UI scoreboards
function spark/ui/setup
tag @a add hotbar
tag @a add hide_hotbar

scoreboard objectives add achievement_display dummy

scoreboard players set min_puzzle_deaths achievement_display 2147483647

# Flight
scoreboard objectives add float dummy
scoreboard objectives add lift dummy
scoreboard objectives add lift_diff dummy
scoreboard objectives add lift_pre1 dummy
scoreboard objectives add lift_pre2 dummy
scoreboard objectives add plane_id dummy
scoreboard objectives add temp_id dummy
scoreboard objectives add f_timer1 dummy
scoreboard objectives add f_timer2 dummy
scoreboard objectives add jump_timer dummy
scoreboard objectives add age dummy

# dueling
scoreboard objectives add dueling_rank dummy
scoreboard players set ".global" dueling_rank 0

scoreboard objectives add dueling_timer dummy

function spark/constants

#Minigame
scoreboard objectives add spawn_hoard dummy
scoreboard objectives add spawn_hoard dummy
scoreboard objectives add ship_score dummy

#Tutorial relevant scoreboards
function spark/tutorial/setup

#Droid Survival relevant scoreboards
function spark/droid_survival/setup
function spark/droid_survival/debug/reset_highscores

#Dueling story setup
function spark/dueling/story/debug/setup

#Force scoreboards
function spark/force/initialize

# TEMP FIXES
effect @a night_vision 999999 10 true
effect @a saturation 999999 0 true

# sync astromech system
function spark/companion/sync_host/setup

# cutscene system
function spark/cutscene/setup

# achievement system
function spark/achievement/setup

# temple crafting rooms
function spark/temple_crafting_rooms/setup


# load the temple on ilum to prevent issues during the cutscene there (BDEV-2011/realms-soft-lock-yoda-does-not-appear)
tickingarea add circle 0 -25 3021 2 ilum_jedi_temple true