/datum/status_manager
	var/list/status_effects = list()
	var/atom/target

/datum/status_manager/New(var/atom/A)
	target = A
	..()

/datum/status_manager/proc/process_event(var/event, var/data)
	for(var/a in status_effects)
		var/status_effect/S = a
		if(S.flags & event)
			data = S.process_flag(tag, data)
			if(S.should_delete())
				status_effects -= S
				qdel(S)
	return data

/datum/status_manager/proc/print_effects()
	. = list()
	for(var/a in status_effects)
		var/status_effect/S = a
		. += S.print_effect()