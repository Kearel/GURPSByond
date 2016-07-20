/mob/living
	var/datum/status_manager/status_manager

/mob/living/New()
	..()
	status_manager = new(src)

/mob/living/TurnStart()
	..()
	status_manager.process_event(STATUS_EVENT_STARTTURN)

/mob/living/TurnEnd()
	..()
	status_manager.process_event(STATUS_EVENT_ENDTURN)