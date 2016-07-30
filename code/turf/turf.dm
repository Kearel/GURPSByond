/turf
	icon = 'icons/turf/basic.dmi'
	icon_state = "grass0"
	name = "grass"
	desc = "unremarkable grass."

	var/dynamic_lighting = 1 //whether this turf uses lighting or not.
	var/pathweight = 1 //How much it costs to move over this turf

/turf/proc/AdjacentTurfs(var/check_contents = 0)
	var/L[] = new()
	for(var/turf/t in oview(src,1))
		if(!t.density)
			if(check_contents)
				var/good = 1
				for(var/atom/movable/M in t)
					if(M.density)
						good = 0
						break
				if(!good)
					continue
			L.Add(t)
	return L

//Used mostly by AStar procs.
/turf/proc/AdjacentTurfsContents()
	return AdjacentTurfs(1)

/turf/proc/CardinalTurfs()
	var/L[] = new()
	for(var/turf/T in AdjacentTurfs())
		if(T.x == src.x || T.y == src.y)
			L.Add(T)
	return L

/turf/proc/Distance(turf/t)
	if(get_dist(src,t) == 1)
		var/cost = (src.x - t.x) * (src.x - t.x) + (src.y - t.y) * (src.y - t.y)
		cost *= (pathweight+t.pathweight)/2
		return cost
	else
		return get_dist(src,t)
