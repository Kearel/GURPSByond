/atom
	var/datum/material
	var/health
	var/maxHealth
	var/death_threshold = 0//This is the number that is used to determine when something should proc Death.
	var/delete_on_death = 1
	var/stat = ALIVE

/atom/proc/update_icon() //generalized icon updating proc
	return

/atom/proc/adjust_health(var/amount)
	if(maxHealth && stat != DEAD) //we have some sort of health
		health = min(maxHealth,max(death_threshold, health - amount))
		if(health == death_threshold)
			Death()
	return 1

/atom/proc/Death()
	if(delete_on_death)
		qdel(src)
	else
		stat = DEAD

/atom/proc/set_dir(new_dir)
	var/old_dir = dir
	if(new_dir == old_dir)
		return FALSE

	dir = new_dir
	dir_set_event.raise_event(src, old_dir, new_dir)
	return TRUE

/atom/proc/Adjacent(var/atom/neighbor)
	var/turf/T0 = get_turf(neighbor)
	var/turf/T1 = get_turf(src)
	if(get_dist(T0, T1) > 1)
		return 0
	return 1