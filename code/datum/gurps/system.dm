/datum/stat_system
	var/mob/living/holder = null
	var/list/points = list("total_points" = 100, "attribute_points" = 0, "advantage_points" = 0, "disadvantage_points" = 0, "quirk_points" = 0, "skill_points" = 0, "spell_points" = 0, "race_points" = 0, "points" = 0)
	var/list/attributes = list(/datum/stat/attribute/strength, /datum/stat/attribute/dexterity, /datum/stat/attribute/intelligence, /datum/stat/attribute/health, //Main Attributes
							/datum/stat/attribute/tiny/hp, /datum/stat/attribute/small/fp, //pools
							/datum/stat/attribute/large/basic_move, /datum/stat/attribute/large/basic_speed, /datum/stat/attribute/minor/will, /datum/stat/attribute/minor/perception, //substats
							/datum/stat/dodge //Misc stats
	) //basically: name = datum

	var/list/skill_list = list()
	//A BIT different due to how skills work.
	//Could probably do it similarly, but nah.

/datum/stat_system/New(var/target)
	var/list/create_at = list()
	points["total_points"] = config.starting_points
	points["points"] = config.starting_points
	for(var/a in attributes)
		var/datum/stat/S = a
		create_at["[initial(S.name)]"] = new a
	attributes.Cut()
	attributes = create_at
	holder = target

/datum/stat_system/Destroy()
	if(holder)
		holder.stats = null
	..()

/datum/stat_system/proc/configure_to(var/list/stats, var/list/skills, var/zero_points = 0)
	for(var/a in stats)
		var/datum/stat/S
		S = attributes[a]
		if(!S)
			return
		S.level = stats[a]

	skill_list = list()
	for(var/s in skills)
		var/list/text = params2list(s)
		var/datum/skill/skill_parent = get_skill_by_name(text["name"])
		if(text["specialization"] && !(text["specialization"] in skill_parent.specializations) && !("Editable" in skill_parent.specializations)) //Editable indicates that the specialization is open ended
			log_to_dd("<h3>ERROR: SPECIALIZATION '[text["specialization"]]' NOT AVAILABLE IN [skill_parent.name]")
			continue
		var/datum/skill_data/data = new(src)
		for(var/v in text)
			var/value = text[v]
			if(!isnull(text2num(value)))
				value = text2num(value)
			data.vars[v] = value
		data.skill_parent = skill_parent
		skill_list += data
	if(zero_points)
		points["points"] = 0
	sync_total_points()

/datum/stat_system/proc/sync_total_points()
	points["total_points"] = 0
	points["attribute_points"] = 0
	for(var/a in attributes)
		var/datum/stat/S = attributes[a]
		var/point = S.recalculate_cost()
		points["attribute_points"] += point
		points["total_points"] += point

	points["skill_points"] = 0
	for(var/s in skill_list)
		var/datum/skill_data/skill = s
		points["skill_points"] += skill.points
		points["total_points"] += skill.points

	points["total_points"] += points["points"]

/datum/stat_system/proc/get_attribute_level(var/stat, var/real = 0, var/bonuses = 1, var/status_effect_bonuses = 1, var/action = "")
	var/datum/stat/S = attributes[stat]
	if(real)
		. = S.level
	else
		. = S.get_level()
	if(bonuses)
		if(S.bonuses_from && S.bonuses_from.len)
			for(var/a in S.bonuses_from)
				. += S.bonuses_from[a] * get_attribute_level(a, 1)

	if(status_effect_bonuses)
		. += S.bonus
		. = . * S.bonus_mult

	if(S.whole_numbers_only)
		. = round(.)

/datum/stat_system/proc/get_real_attribute(var/stat)
	return attributes[stat]

/datum/stat_system/proc/get_real_skill(var/skill_name, var/specialization_name)
	for(var/s in skill_list)
		var/datum/skill_data/skill = s
		if(skill.name == skill_name && skill.specialization == specialization_name)
			return skill
	return null

/datum/stat_system/proc/get_skill_level(var/skill_name, var/specialization_name, var/check_for_defaults = 1)
	. = 0
	var/datum/skill_data/S = get_real_skill(skill_name, specialization_name)
	if(S)
		. += S.get_level_from_points()
	else
		if(check_for_defaults)
			var/datum/skill/skill = get_skill_by_name(skill_name)
			if(skill)
				. = skill.calculate_default(src)

/datum/stat_system/proc/get_appropriate_level(var/skill_name, var/specialization_name)
	if(skill_name in attributes)
		return get_attribute_level(skill_name, 1, 1)
	return get_skill_level(skill_name, specialization_name)

/datum/stat_system/proc/add_level_to_attribute(var/attribute, var/levels)
	var/datum/stat/S = get_real_attribute(attribute)
	if(!S)
		return 0
	if(S.level + levels < 0)
		return 0
	var/previous_cost = S.recalculate_cost()
	S.level += levels
	var/cost = S.recalculate_cost() - previous_cost
	if(cost > points["points"])
		S.level -= levels
		return 0

	points["attribute_points"] += cost
	points["points"] -= cost
	return 1

/datum/stat_system/proc/add_points_to_skill(var/skill_name, var/specialization, var/adding_points)
	if(points["points"] < adding_points)
		return 0
	var/datum/skill_data/S = get_real_skill(skill_name, specialization)
	if(!S)
		var/datum/skill/skill = get_skill_by_name(skill_name)
		if(skill && skill.can_get_skill(src,specialization))
			S = new(src)
			S.name = skill.name
			S.specialization = specialization
			S.skill_parent = skill
			skill_list += S
		else
			return 0
	points["skill_points"] += adding_points
	S.points += adding_points
	if(S.points < 1)
		skill_list -= S
		qdel(S)
	points["points"] -= adding_points
	return 1

/datum/stat_system/proc/add_points(var/amount)
	points["points"] += amount
	points["total_points"] += amount