/proc/start_combat()
	if(combat_state != COMBAT_OFF)
		return
	world << "<font size='5'>COMBAT BEGIN!</font>"
	turn_controller.start_combat()
	combat_state = COMBAT_ON

/proc/stop_combat()
	if(combat_state == COMBAT_OFF)
		return
	turn_controller.end_combat()
	world << "<font size='5'>COMBAT END!</font>"
	combat_state = COMBAT_OFF

/proc/toggle_combat()
	if(combat_state == COMBAT_OFF)
		start_combat()
		return
	stop_combat()