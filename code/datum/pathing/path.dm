
//A datum used to support the AStar algorithm. Stores all useful information.
//Also holds the image overlay.

/datum/path
	var/list/path_to
	var/image/image_overlay
	var/mob/living/source

/datum/path/New(var/list/path, var/turf/target, var/mob/living/source)
	src.source = source
	image_overlay = image(icon = target.icon, icon_state = target.icon_state, loc = target, layer = TURF_LAYER)
	image_overlay.overlays += image(icon = 'icons/effects/overlays.dmi', icon_state = "turf_select")
	image_overlay.override = 1
	path_to = path
	add_image()

/datum/path/Destroy()
	remove_image()
	source = null
	..()

/datum/path/proc/get_next()
	if(!path_to || !path_to.len)
		return null
	var/element = path_to[1]
	path_to -= element
	return element

/datum/path/proc/get_target()
	return path_to[length(path_to)]

/datum/path/proc/add_image()
	if(source && source.controlled_by)
		var/client/C = directory["[source.controlled_by]"]
		if(C)
			C.images += image_overlay

/datum/path/proc/remove_image()
	if(!source)
		return
	for(var/client/C in clients)
		if((C.key in source.allowed_control) || ("everyone" in source.allowed_control))
			C.images -= image_overlay