/datum/status_effect
	var/name = "status effect"
	var/desc = "this is a fucking status effect."
	var/overlay_state
	var/flags = 0

//When this returns 1, the status effect stays.
//When it returns 0, the status effect is removed.
/datum/status_effect/proc/process()
	return 0