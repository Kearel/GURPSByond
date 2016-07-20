/status_effect
	parent_type = /datum
	var/name = "Status Effect"
	var/desc = "This is a regular old status effect that does nothing"
	var/datum/status_manager/manager = null
	var/flags = 0

/status_effect/New(var/status_manager)
	manager = status_manager

//When this returns 0, it is deleted.
/status_effect/proc/process_flag(var/flag, var/data)
	return 0

/status_effect/proc/should_delete()
	return 0

/status_effect/proc/print_effect()
	return name

/status_effect/Destroy()
	if(manager)
		manager = null
	..()
	return

/status_effect/duration
	name = "Duration Effect"
	desc = "This status effect only lasts for a certain duration"
	var/duration = 1 //Lasts til the end of this person's turn
	flags = STATUS_EVENT_ENDTURN

/status_effect/duration/print_effect()
	return "[name] [duration/initial(duration)]"

/status_effect/duration/process_flag(var/flag, var/data)
	duration-- //we do it this way
	return 0

/status_effect/duration/should_delete()
	return duration <= 0

/status_effect/duration/stat
	name = "Temporary Stat Effect"
	desc = "This status effect is a temporary boost to some stat on a person."
	var/stat = null
	var/amount = 0

/status_effect/duration/stat/New()
	..()
	if(!manager || !stat || !manager.target)
		return
	if(manager.target.vars["[stat]"])
		manager.target.vars["[stat]"] += amount

/status_effect/duration/stat/Destroy()
	if(manager && manager.target && stat)
		manager.target.vars["[stat]"] -= amount
	..()
	return