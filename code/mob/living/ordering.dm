/mob/living/proc/order(var/atom/A, var/mob/observer/user)
	if(!can_take_action())
		user << "\red \The [src] cannot move at this time."
		return

	if(istype(A,/turf))
		if(combat_state == COMBAT_OFF)
			walk_to(src,A)
			return
		if(paths && paths.len)
			if(paths[A])
				current_path = paths[A]
				current_path.get_next() //get rid of the first step (which will always be the src loc)
				working = 1
				wipe_movement_list()
				return
	if(istype(A,/mob))
		//attack shit
		return