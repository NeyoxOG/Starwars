titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:§x" },{"translate":"droid_survival.lab.announcement.score.announcement1", "with": {"rawtext":[{"score":{"name":"Droids_Defeated","objective":"droid_survival_stats"}}]} }]}
execute as @a at @s run playsound sound.spark.success_major @s

#tellraw @a { "rawtext": [ { "text": "§a"},{"translate":"droid_survival.stats.wave.current"},{"text":": §r" }, { "score": {"name": "Wave", "objective": "droid_survival_stats" } }]}
#tellraw @a { "rawtext": [{ "text": "§a"},{"translate":"droid_survival.stats.wave.highest"},{"text":": §r" }, { "score": {"name": ".highest_wave", "objective": "droid_survival" } }]}
#tellraw @a { "rawtext": [ { "text": "§a"},{"translate":"droid_survival.stats.defeated.current"},{"text":": §r" }, { "score": {"name": "Droids_Defeated", "objective": "droid_survival_stats" } }]}
#tellraw @a { "rawtext": [{ "text": "§a"},{"translate":"droid_survival.stats.defeated.highest"},{"text":": §r" }, { "score": {"name": ".highest_kills", "objective": "droid_survival" } }]}
#
#scoreboard players operation .tmp droid_survival = Time droid_survival_stats
#scoreboard players operation .temp droid_survival = .tmp droid_survival
#scoreboard players operation .tmp droid_survival /= _20 SS_const
#scoreboard players operation .temp droid_survival %= _20 SS_const
#
#execute if score .tmp droid_survival matches 10.. run tellraw @a { "rawtext": [ { "text": "§a"},{"translate":"droid_survival.stats.time.current"},{"text":": §r" }, { "score": {"name": ".temp", "objective": "droid_survival" } }, { "text": ":" }, { "score": {"name": ".tmp", "objective": "droid_survival" } }]}
#execute if score .tmp droid_survival matches ..9 run tellraw @a { "rawtext": [ { "text": "§a"},{"translate":"droid_survival.stats.time.current"},{"text":": §r" }, { "score": {"name": ".temp", "objective": "droid_survival" } }, { "text": ":" }, { "score": {"name": ".tmp", "objective": "droid_survival" }}, {"text":"0"}]}
#
#scoreboard players operation .tmp droid_survival = .highest_time droid_survival
#scoreboard players operation .temp droid_survival = .tmp droid_survival
#scoreboard players operation .tmp droid_survival /= _20 SS_const
#scoreboard players operation .temp droid_survival %= _20 SS_const
#execute if score .tmp droid_survival matches 10.. run tellraw @a { "rawtext": [ { "text": "§a"}, {"translate":"droid_survival.stats.time.highest"},{"text":": §r" }, { "score": {"name": ".temp", "objective": "droid_survival" } }, { "text": ":" }, { "score": {"name": ".tmp", "objective": "droid_survival" } }]}
#execute if score .tmp droid_survival matches ..9 run tellraw @a { "rawtext": [ { "text": "§a"}, {"translate":"droid_survival.stats.time.highest"},{"text":": §r" }, { "score": {"name": ".temp", "objective": "droid_survival" } }, { "text": ":" }, { "score": {"name": ".tmp", "objective": "droid_survival" }}, {"text":"0"}]}