/mob/living
	var/datum/status_manager/status_manager

/mob/living/New()
	..()
	status_manager = new(src)

/mob/living/proc/add_status_effect(var/effect_to_add)
	return status_manager.add_status_effect(effect_to_add)

/mob/living/TurnStart()
	..()
	status_manager.process_event(STATUS_EVENT_STARTTURN)

/mob/living/TurnEnd()
	..()
	status_manager.process_event(STATUS_EVENT_ENDTURN)