/datum/stat_system
	var/mob/living/holder = null
	var/points = 100
	var/list/attributes = list(/datum/stat/attribute/strength, /datum/stat/attribute/dexterity, /datum/stat/attribute/intelligence, /datum/stat/attribute/health, //Main Attributes
							/datum/stat/attribute/tiny/hp, /datum/stat/attribute/tiny/fp, //pools
							/datum/stat/attribute/large/basic_move, /datum/stat/attribute/large/basic_speed //substats
	) //basically: name = datum

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

/datum/stat_system/proc/configure_to(var/list/stats, var/zero_points = 0)
	if(zero_points)
		points = 0
	for(var/a in stats)
		var/datum/stat/S
		S = attributes[a]
		if(!S)
			return
		S.level = stats[a]

/datum/stat_system/proc/get_attribute_level(var/stat, var/real = 0, var/bonuses = 1, var/action = "")
	var/datum/stat/S = attributes[stat]
	if(real)
		. = S.level
	else
		. = S.get_level()
	if(bonuses && S.bonuses_from)
		for(var/a in S.bonuses_from)
			. += S.bonuses_from[a] * get_attribute_level(a, 0, 0)
	if(S.whole_numbers_only)
		. = round(.)