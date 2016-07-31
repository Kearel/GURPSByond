/datum/stat_system
	var/mob/living/holder = null
	var/points = 100
	var/list/attributes = list(/datum/stat/attribute/strength, /datum/stat/attribute/dexterity, /datum/stat/attribute/intelligence, /datum/stat/attribute/health, //Main Attributes
							/datum/stat/attribute/tiny/hp, /datum/stat/attribute/tiny/fp, //pools
							/datum/stat/attribute/large/basic_move, /datum/stat/attribute/large/basic_speed, //substats
							/datum/stat/dodge //Misc stats
	) //basically: name = datum

	var/list/skill_list = list()
	//A BIT different due to how skills work.
	//Could probably do it similarly, but nah.

/datum/stat_system/New()
	var/list/create_at = list()
	points = config.starting_points
	for(var/a in attributes)
		var/datum/stat/S = a
		create_at["[initial(S.name)]"] = new a
	attributes.Cut()
	attributes = create_at

/datum/stat_system/Destroy()
	if(holder)
		holder.stats = null
	..()

/datum/stat_system/proc/configure_to(var/list/stats, var/list/skills, var/zero_points = 0)
	if(zero_points)
		points = 0
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
		if(text["specialization"] && !(text["specialization"] in skill_parent.specializations))
			log_to_dd("<h3>ERROR: SPECIALIZATION '[text["specialization"]]' NOT AVAILABLE IN [skill_parent.name]")
			continue
		var/datum/skill_data/data = new
		for(var/v in text)
			var/value = text[v]
			if(!isnull(text2num(value)))
				value = text2num(value)
			data.vars[v] = value
		data.skill_parent = skill_parent
		skill_list += data

/datum/stat_system/proc/get_attribute_level(var/stat, var/real = 0, var/bonuses = 1, var/action = "")
	var/datum/stat/S = attributes[stat]
	if(real)
		. = S.level
	else
		. = S.get_level()
	if(bonuses)
		. += S.bonus
		if(S.bonuses_from && S.bonuses_from.len)
			for(var/a in S.bonuses_from)
				. += S.bonuses_from[a] * get_attribute_level(a, 1, 0)
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
		if(S.skill_parent.stat)
			. +=  get_attribute_level(S.skill_parent.stat,1,1)
	else
		if(check_for_defaults)
			var/datum/skill/skill = get_skill_by_name(skill_name)
			if(skill)
				. = skill.calculate_default(src)

/datum/stat_system/proc/get_appropriate_level(var/skill_name, var/specialization_name)
	if(skill_name in attributes)
		return get_attribute_level(skill_name, 1, 1)
	return get_skill_level(skill_name, specialization_name)