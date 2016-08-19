/obj/item/thrusting_broadsword
	name = "thrusting broadsword"
	desc = "a broadsword with a tip made especially for stabbing people with."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "claymore"
	weight = 3
	attack_data = list("usage=Swung&damage_base=Swing&damage_bonus=1&damage_type=Cut&reach=1&minimum_strength=10&parry_modifier=0&weapon_skill=Sword" =/datum/item_attack/melee,
						"usage=Thrust&damage_base=Thrust&damage_bonus=2&damage_type=Impale&reach=1&minimum_strength=10&parry_modifier=0&weapon_skill=Sword" = /datum/item_attack/melee)