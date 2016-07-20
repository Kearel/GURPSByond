/datum/status_manager
	var/list/status_effects = list()
	var/mob/living/target

/datum/status_manager/New(var/mob/living/L)
	target = L
	..()

/datum/status_manager/proc/process_event(var/event)
	for(var/a in status_effects)
		var/status_effect/S = a
		if(S.flags & event)
			S.process_flag(tag)
