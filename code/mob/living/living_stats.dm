/mob/living
	var/datum/stat_system/stats
	var/list/starting_stats
	var/list/starting_skills

/mob/living/New()
	..()
	stats = new(src)
	stats.configure_to(starting_stats, starting_skills,1)
	if(starting_stats)
		starting_stats = null
	if(starting_skills)
		starting_skills = null
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
	death_threshold = -maxHealth

	maxFatigue = get_attribute_level("FP",1)
	fatigue = round(fatigue_percent * maxFatigue)

	move_delay = max(0, config.base_movement - get_attribute_level("Basic Speed")/2)

/mob/living/proc/roll_skill(var/skill_to_roll, var/specialization, var/bonuses, var/move_attack_rules = 0, var/quiet_roll = 0)
	var/base = stats.get_appropriate_level(skill_to_roll, specialization)
	if(move_attack_rules)//UUUGH SPECIAL FLAGS FOR MOVING AND ATTACKING UUUGH
		base -= 4
		if(base > 9)
			base = 9
	var/text = "Rolling... "
	var/total = 0
	for(var/i in 1 to 3)
		var/value = rand(1,6)
		text = "[text][value]"
		total += value
		if(i != 3)
			text = "[text] + "
	text = "[text] <= [base]"
	if(!quiet_roll)
		world << "Rolling 3d6 versus [skill_to_roll][specialization ? " ([specialization])" : ""] [bonuses > 0 ? "+" : ""][bonuses]"
		world << text
	if((total >= 18 - (base <= 15 ? 1 : 0)) || (total - base >= 10))
		if(!quiet_roll)
			world << "\red <font size='3'> CRITICAL FAILURE!</font>"
		return "CRIT FAIL"
	else if(total <= 4 + (base >= 15 ? 1 : 0) + (base >= 16 ? 1 : 0))
		if(!quiet_roll)
			world << "\green <font size='3'>CRITICAL SUCCESS!</font>"
		return "CRITICAL"
	total -= base
	if(!quiet_roll)
		if(total > 0)
			world << "\red Failure by a margin of [total]"
		else
			world << "\green Success by a margin of [-total]"
	return total

/mob/living/proc/get_character_sheet(var/client/user)
	var/text= "[src.portrait_state]"
	if(!global_resource_cache[text])
		global_resource_cache[text] = new /icon(src.portrait_icon, src.portrait_state)
	user << browse_rsc(global_resource_cache[text], "[text].png")
	new /datum/character_sheet(stats, user, list("portrait" = text, "name" = name, "fp" = fatigue, "hp" = health), 1)