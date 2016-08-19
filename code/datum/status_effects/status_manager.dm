/datum/status_manager
	var/list/status_effects = list()
	var/atom/target

/datum/status_manager/New(var/atom/A)
	target = A
	..()

/datum/status_manager/proc/add_status_effect(var/status_to_add, var/list/changed_stuff)
	status_effects += new status_to_add(src, changed_stuff)

/datum/status_manager/proc/process_event(var/event, var/data)
	for(var/a in status_effects)
		var/status_effect/S = a
		if(S.flags & event)
			data = S.process_flag(event, data)
			if(S.should_delete(event,data))
				status_effects -= S
				process_event(STATUS_EVENT_STATUSREMOVED, S)
				qdel(S)
	return data

/datum/status_manager/proc/print_effects()
	. = list()
	for(var/a in status_effects)
		var/status_effect/S = a
		var/text = S.print_effect()
		if(text)
			. += text