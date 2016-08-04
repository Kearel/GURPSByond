/datum/stat_system/proc/get_character_sheet(var/list/data, var/modification_level)
	if(!data)
		data = list()
	for(var/a in attributes)
		data[a] = get_attribute_level(a,1,1)

	var/strength_base = get_attribute_level("Strength",1)
	data["thrust_dice"] = get_thrust_dice(strength_base)
	data["swing_dice"] = get_swing_dice(strength_base)
	data["collapse health"] = 0
	data["collapse fatigue"] = 0
	for(var/i in 1 to 5)
		data["death threshold [i]"] = -data["HP"] * i

	data["skill list"] = skill_list
	data["points"] = points

	return generate_character_sheet(data,modification_level)