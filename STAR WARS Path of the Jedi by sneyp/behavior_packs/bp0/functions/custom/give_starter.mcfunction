# Gives a starter setup useful for testing

replaceitem entity @s slot.armor.chest 0 spark:cloak_default 1 0 {"item_lock":{"mode":"lock_in_slot"}}
effect @s saturation 30 1 true
effect @s night_vision 600 0 true

tellraw @s {"rawtext":[{"text":"§a[Custom] Starter-Loadout vergeben."}]}
