/proc/crash_with(msg)
	CRASH(msg)


//Returns whether or not A is the middle most value
/proc/InRange(var/A, var/lower, var/upper)
	if(A < lower) return 0
	if(A > upper) return 0
	return 1

proc/islist(var/A)
	return istype(A,/list)

/proc/get_turf(atom/A)
	if(!istype(A)) return
	for(A, A && !isturf(A), A=A.loc);
	return A

/proc/get_area(O)
	var/turf/loc = get_turf(O)
	if(loc)
		var/area/res = loc.loc
		.= res

/proc/sortmobs()
	return sortAtom(mob_list)


/proc/no_diagonals_view(range = world.view, atom/center = usr)
    var/list/L = view(range, center)
    for(var/turf/T in L)
        var/d = abs(center.x - T.x) + abs(center.y - T.y)
        if(d > range)
            L -= T
            // everything in that turf is also out of range
            L -= T.contents
    return L

/proc/tview(range = world.view, atom/center = usr)
	var/list/L = view(range, center)
	for(var/turf/T in L)
		if(T.x != usr.x || T.y != usr.y)
			L -= T
			L -= T.contents
	return L

/proc/get_distance_penalty(var/distance)
	for(var/i in distance_penalties)
		if(distance <= text2num(i))
			return distance_penalties[i]
	var/last = distance_penalties.len
	var/current_distance = distance_penalties[last]
	. = distance_penalties["[current_distance]"]
	while(distance > current_distance)
		current_distance = round(current_distance * 1.5)
		distance_penalties["[current_distance]"] = .
		.--