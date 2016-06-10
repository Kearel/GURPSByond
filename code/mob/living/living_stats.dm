/mob/living
	var/datum/stat_system/stats
	var/list/starting_stats

/mob/living/New()
	..()
	stats = new
	if(starting_stats)
		stats.configure_to(starting_stats,1)
		starting_stats.Cut()
	sync_stats()

/mob/living/Destroy()
	if(stats)
		qdel(stats)
		stats = null
	..()

/mob/living/proc/get_attribute_level(var/text, var/actual = 0, var/bonuses = 1)
	return stats.get_attribute_level(text,actual, bonuses)

/mob/living/proc/sync_stats()
	var/health_percent
	if(!maxHealth)
		health_percent = 1
	else
		health_percent = health/maxHealth

	var/fatigue_percent
	if(!maxFatigue)
		fatigue_percent = 1
	else
		fatigue_percent = fatigue/maxFatigue

	maxHealth = get_attribute_level("HP",1)
	health = round(health_percent * maxHealth)
	death_threshold = -5*maxHealth

	maxFatigue = get_attribute_level("FP",1)
	fatigue = round(fatigue_percent * maxFatigue)

	move_delay = max(0, config.base_movement - get_attribute_level("Basic Speed")/2)