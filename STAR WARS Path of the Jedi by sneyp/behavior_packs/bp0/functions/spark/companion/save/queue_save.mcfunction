# © Spark Universe, 2023
# authors: destruc7i0n
# description: Save pets when the player logs out
# called by: companion/saving/check, by the pet

# only tags are saved to the entity
tag @s add pet_save

# remove follow_owner to not teleport them back
event entity @s spark:immobile

# TODO: set a new area which is in a ticking area in the below command.
spreadplayers -8 279 2 5 @e[family=companion,tag=pet_save]

# tellraw @a[tag=debug] {"rawtext":[{"text":"§7§oPet queued to save at "}, {"score":{"name":"slow","objective":"SS_time"}}]}
