/datum/stat
	var/name = "Generic"
	var/desc = "This should never be seen."
	var/list/bonuses_from //what stats we gain from and bonuses per level
	var/level = 0
	var/base_level = 0
	var/base_level_mult = 1
	var/bonus = 0         //Quarantined var so that status effects/other similar stuff won't directly modify the level
	var/bonus_mult = 1
	var/whole_numbers_only = 0 //whether we only consider whole levels for this stat. Mainly used for bonuses.
	var/can_level = 1          //whether we can put points into this stat to upgrade it.

/datum/stat/New()
	..()
	if(base_level)
		base_level = round(config.base_attribute_level * base_level_mult)
		level = base_level

/datum/stat/proc/get_points_to_level()
	return 1

/datum/stat/proc/recalculate_cost()
	. = 0
	for(var/i in 0 to get_level())
		. += get_points_to_level(i)

/datum/stat/proc/get_level() //used primarily to calculate bonuses
	if(!base_level)
		return level
	return level - base_level

/datum/stat/attribute
	base_level = 10

/datum/stat/attribute/recalculate_cost()
	return get_level() * get_points_to_level()

/datum/stat/attribute/get_points_to_level()
	return config.attribute_points_per_level

/datum/stat/attribute/minor/get_points_to_level()
	return round((..())/2)

/datum/stat/attribute/tiny/get_points_to_level()
	return round((..())/5)

/datum/stat/attribute/small/get_points_to_level()
	return round((..())/3)

/datum/stat/attribute/large/get_points_to_level()
	return (..())*2