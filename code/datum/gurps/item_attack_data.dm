/datum/item_attack
	var/damage_bonus = 0
	var/damage_base = "Thrust"
	var/damage_type = "Crush"
	var/usage = "Thrust"
	var/minimum_strength = 0
	var/weapon_skill

/datum/item_attack/New(var/new_vars)
	..()
	for(var/v in new_vars)
		var/value = new_vars[v]
		if(!isnull(text2num(value)))
			value = text2num(value)
		vars[v] = new_vars[v]

/datum/item_attack/melee
	var/parry_modifier = ITEM_NO_USAGE
	var/block_modifier = ITEM_NO_USAGE
	var/reach = 0

/datum/item_attack/ranged
	var/accuracy = 0
	var/range_minimum = 0 //must be distance away
	var/range_regular = 0 //range of full damage
	var/range_half = 0 //range of halfed damage
	var/rate_of_fire = 0
	var/max_shots = 1
	var/time_to_reload = 1
	var/reload_method = RELOAD_FULL