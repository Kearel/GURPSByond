/atom/movable
	var/anchored = 0 //whether this thing can be moved, at all.

/atom/movable/Destroy()
	. = ..()
	for(var/atom/movable/AM in src)
		qdel(AM)
	forceMove(null)