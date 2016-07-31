/mob/living
	var/move_delay = 10
	var/move_time = 0

	//pathing stuff
	var/list/paths //list of all available paths. target turf = datum

/mob/living/proc/update_movement_images()
	if(!paths || !paths.len)
		return
	for(var/a in paths)
		var/datum/path/P = paths[a]
		if(combat_state == COMBAT_OFF)
			P.remove_image()
		else
			P.add_image()


/mob/living/proc/get_movable_tiles(var/range, var/straight)
	wipe_movement_list()
	paths = list()
	if(!straight)
		for(var/turf/T in no_diagonals_view(range,src) - src.loc)
			var/list/astar = AStar(src.loc,T,/turf/proc/AdjacentTurfsContents,/turf/proc/Distance,max_node_depth=range)
			if(astar)
				paths[T] = new/datum/path(astar,T,src)
	else
		for(var/direct in list(NORTH,SOUTH,EAST,WEST))
			var/list/steps = list()
			steps += src.loc
			var/turf/current = get_step(src.loc,direct)
			for(var/i in 1 to range)
				if(current.density)
					break
				steps += current
				paths[current] = new /datum/path(steps.Copy(),current,src)
				current = get_step(current,direct)
	update_movement_images()
	return paths

/* Movement is as follows:
Move: 1 multiplier
Move & Attack: 1 multiplier
All-Out-Attack: 0.5 multiplier
All-Out-Defense: 0.5 multiplier

Stance:
Standing: 1 multiplier
Kneeling: 0.3 multiplier
Crawling: 0.3 multiplier
Lying Down: 1 movement.
Sitting: 0 movement.
*/


/mob/living/proc/get_combat_movement(var/multiplier = 1, var/override, var/straight)
	if(combat_state == COMBAT_OFF)
		return
	var/total
	if(override)
		total = override
	else
		total = get_attribute_level("Basic Move",1,1) * multiplier
	switch(posture)
		if(POSTURE_KNEEL)
			total *= 0.3
		if(POSTURE_CRAWL)
			total *= 0.3
		if(POSTURE_PRONE)
			total = 1
		if(POSTURE_SIT)
			return
		if(POSTURE_BACK)
			return
	total = max(1,round(total))
	get_movable_tiles(round(total), straight)

/mob/living/proc/wipe_movement_list(var/keep_this_path)
	if(paths && paths.len)
		for(var/a in paths)
			var/datum/path/P = paths[a]
			if(P != keep_this_path)
				qdel(P)
		paths.Cut()

/mob/living/Destroy()
	wipe_movement_list()
	..()

/mob/living/Move()
	if(combat_state == COMBAT_OFF && move_time > world.time)
		return
	move_time = world.time + move_delay
	..()