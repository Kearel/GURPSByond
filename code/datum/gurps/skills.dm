/* These share quite a bit of similarities with stats.
Maybe merge them?


The way this works is that there is a global list of skill datums that you use to figure out stuff like defaults, calculated skill levels, etc.
*/

/proc/generate_skills()
	for(var/a in subtypesof(/datum/skill))
		var/datum/skill/S = a
		skills[initial(S.name)] = new a

/proc/get_skill_by_name(var/name)
	if(skills[name])
		return skills[name]
	for(var/a in skills)
		var/datum/skill/skill = a
		if(dd_hasprefix(name, skill.name))
			return a
	return null

/datum/skill
	var/name = "Skill"
	var/desc = "This is a generic skill that does nothing."
	var/stat = "Dexterity" //Stat this is based off of.
	var/difficulty = SKILL_EASY
	var/page_number = "N/A"

	//Can also do something like name (Specialization)
	//Organized as: name = bonus
	var/list/defaults
	var/list/defaults_spec
	//Organized as: name = required level
	var/list/prerequests
	var/prerequest_mode = SKILL_REQUIRE_ALL
	var/list/specializations

/datum/skill/proc/can_get_skill(var/datum/stat_system/system, var/specialization)
	for(var/a in prerequests)
		var/good = 0
		for(var/s in system.skill_list)
			var/datum/skill_data/skill = s
			if(a == "[skill.name][skill.specialization ? " ([skill.specialization])" : ""]")
				good = 1
				break

		if(good)
			if(prerequest_mode == SKILL_REQUIRE_ONE)
				return 1
		else if(prerequest_mode == SKILL_REQUIRE_ALL)
			return 0
	return 1

/datum/skill/proc/calculate_default(var/datum/stat_system/system, var/specialization)
	. = 0
	if(!defaults)
		return 0
	for(var/i in 1 to defaults.len)
		var/d = defaults[i]
		var/value = 0
		if(d in system.attributes)
			value = system.get_attribute_level(d,1)
		else
			value = system.get_skill_level(d, defaults_spec ? defaults_spec["[i]"] : null, check_for_defaults = 0)
		if(value)
			value += defaults[d]
		if(value > .)
			. = value


/datum/skill_data
	var/name
	var/tech_level
	var/points = 0
	var/bonus = 0
	var/override = null
	var/specialization
	var/datum/skill/skill_parent
	var/datum/stat_system/holder

/datum/skill_data/New(var/system)
	holder = system
	..()

/datum/skill_data/proc/get_level_from_points()
	if(!isnull(override))
		return override
	if(points > 4)
		. = 1+round(points/4)
	else
		. = round(points/2)
	. += skill_parent.difficulty + bonus
	if(skill_parent.stat)
		. += holder.get_attribute_level(skill_parent.stat, 1,1)