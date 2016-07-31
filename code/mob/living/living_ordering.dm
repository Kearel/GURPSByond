/mob/living/proc/can_take_action()
	if(working)
		return 0
	if(combat_state == COMBAT_OFF)
		return 1
	if(combat_flags & COMBAT_FLAG_TURN)
		return 1
	return 0


/mob/living/proc/order(var/atom/A, var/mob/observer/user)
	if(!can_take_action())
		user << "\red \The [src] cannot move at this time."
		return

	if(istype(A,/turf))
		if(combat_state == COMBAT_OFF)
			walk_to(src,A)
			return
		if(paths && paths.len && paths[A])
			var/datum/path/current_path = paths[A]
			wipe_movement_list(paths[A])
			working = 1
			current_path.get_next()
			spawn(0)
				for(var/target = get_turf(src), !isnull(target), target = current_path.get_next())
					src.forceMove(target)
					sleep(7)
				qdel(current_path)
				working = 0

			return
	if(istype(A,/mob/living))
		make_attack_roll(A)
		return