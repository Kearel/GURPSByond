/status_effect
	parent_type = /datum
	var/name = "Status Effect"
	var/desc = "This is a regular old status effect that does nothing"
	var/datum/status_manager/manager = null
	var/invisible = 0
	var/flags = 0

/status_effect/New(var/status_manager, var/list/changed_stuff)
	manager = status_manager
	for(var/v in changed_stuff)
		vars[v] = changed_stuff[v]
	if(!manager || !manager.target)
		return 0
	return 1

/status_effect/proc/process_flag(var/flag, var/data)
	return


//When this returns 0, it is deleted.
/status_effect/proc/should_delete(var/flag, var/data)
	return 0

/status_effect/proc/print_effect()
	if(invisible)
		return null
	return name

/status_effect/Destroy()
	if(manager)
		manager = null
	..()
	return

/status_effect/linked
	name = "Linked Status Effect"
	desc = "This status effect lasts as long as its lifeline does."
	flags = STATUS_EVENT_STATUSREMOVED
	var/status_effect/lifeline

/status_effect/linked/process_flag(var/flag, var/data)
	if(lifeline == data)
		lifeline = null
	return

/status_effect/linked/should_delete()
	return !!lifeline

/status_effect/duration
	name = "Duration Effect"
	desc = "This status effect only lasts for a certain duration"
	var/duration = 1 //Lasts til the end of this person's turn
	flags = STATUS_EVENT_ENDTURN

/status_effect/duration/print_effect()
	return "[name] ([duration])"

/status_effect/duration/process_flag(var/flag, var/data)
	duration-- //we do it this way
	return

/status_effect/duration/should_delete()
	return duration <= 0

/status_effect/duration/variable
	name = "Temporary Variable Effect"
	desc = "This status effect is a temporary boost to some stat on a person."
	var/stat = null
	var/amount = 0

/status_effect/duration/variable/New()
	..()
	if(!manager || !stat || !manager.target)
		return
	if(manager.target.vars["[stat]"])
		manager.target.vars["[stat]"] += amount

/status_effect/duration/variable/Destroy()
	if(manager && manager.target && stat && manager.target.vars["[stat]"])
		manager.target.vars["[stat]"] -= amount
	..()
	return

/status_effect/duration/stat
	name = "Temporary Stat Effect"
	desc = "This status effect is a temporary boost to some stat on a person."
	var/stat
	var/amount = 0
	var/mult = 1

/status_effect/duration/stat/New()
	..()
	if(!manager || !stat || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	var/datum/stat/S = L.stats.get_real_attribute(stat)
	if(S)
		S.bonus += amount
		S.bonus_mult *= mult

/status_effect/duration/stat/Destroy()
	if(manager && manager.target && stat && ismob(manager.target))
		var/mob/living/L = manager.target
		var/datum/stat/S = L.stats.get_real_attribute(stat)
		if(S)
			S.bonus -= amount
			S.bonus_mult /= mult
	..()
	return

/status_effect/duration/skill
	name = "Temporary Skill Effect"
	desc = "This status effect gives a temporary boost to a skill of some sort."
	var/skill
	var/specialization
	var/amount = 0
	var/override

/status_effect/duration/skill/New()
	..()
	if(!manager || !skill || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	var/datum/skill_data/S = L.stats.get_real_skill(skill,specialization)
	if(S)
		S.bonus += amount
		if(!isnull(override))
			S.override = override

/status_effect/duration/skill/Destroy()
	if(manager && manager.target && skill && ismob(manager.target))
		var/mob/living/L = manager.target
		var/datum/skill_data/S = L.stats.get_real_skill(skill,specialization)
		if(S)
			S.bonus -= amount
			if(!isnull(override) && S.override == override)
				S.override = null
	..()
	return

