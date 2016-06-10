/datum/build_mode/proc/Click(var/atom/location,var/mob/user, var/params)
	var/list/pa = params2list(params)
	var/shift = 0
	if(pa["shift"])
		shift = 1
	var/ctrl = 0
	if(pa["ctrl"])
		ctrl = 1
	if(pa["right"])
		if(shift)
			turn_selected(location,user, ctrl)
		else
			remove_selected(location,user)
	else if(pa["middle"])
		get_selected_type(location,user)
	else
		create_selected_type(location,user,shift,(ctrl ? params : null))
	return