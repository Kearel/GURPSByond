//BUILDMODE HERE

/datum/build_mode
	var/selected_type = null
/datum/build_mode/proc/create_selected_type(var/atom/a, var/mob/user, var/place_turf = 0, var/params)
	if(!selected_type)
		return
	var/loc = a
	if(ispath(selected_type, /turf))
		var/turf/T = get_turf(loc)
		user << "Changed \the [T]."
		T.ChangeTurf(selected_type,1)
		return

	if(place_turf)
		loc = get_turf(a)

	var/atom/movable/M = new selected_type(loc)
	if(params)
		var/list/mouse_info = params2list(params)
		if(!mouse_info["icon-x"] || !mouse_info["icon-y"])
			return
		M.pixel_x = text2num(mouse_info["icon-x"])-16
		M.pixel_y = text2num(mouse_info["icon-y"])-16

	user << "Placing \the [M] on \the [loc]."

/datum/build_mode/proc/get_selected_type(var/atom/a, var/mob/user)
	selected_type = a.type
	user << "Type selected: [selected_type]"

/datum/build_mode/proc/remove_selected(var/atom/a, var/mob/user)
	if(istype(a,/turf))
		user << "\red Buildmode does not currently support turf destruction."
		return
	qdel(a)

/datum/build_mode/proc/turn_selected(var/atom/movable/M, var/mob/user, var/counter = 0)
	M.set_dir(turn(M.dir,90 * (counter ? -1 : 1)))
	user << "\The [M] now faces [dir2text(M.dir)]."