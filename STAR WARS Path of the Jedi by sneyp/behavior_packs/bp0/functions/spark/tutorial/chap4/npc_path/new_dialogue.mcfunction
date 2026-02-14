dialogue change @s[type=spark:padme_amidala] spark:jedi_temple.padme.2
dialogue change @s[type=spark:mace_windu] spark:jedi_temple.mace_windu.2
dialogue change @s[type=spark:jar_jar_binks] spark:jedi_temple.jar_jar.2
dialogue change @s[type=spark:anakin_skywalker] spark:jedi_temple.anakin.2
#dialogue change @s[type=spark:ahsoka_tano] spark:jedi_temple.ahsoka.2
dialogue change @s[type=spark:obi_wan_kenobi] spark:jedi_temple.obi_wan.2
dialogue change @s[type=spark:yoda] spark:jedi_temple.yoda.3

execute at @s run tp @s ~~~ facing @p
scoreboard players set @s timer 1

tag @s remove tmp_delay