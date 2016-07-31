/mob/observer/verb/upload_ghost_image()
	set name = "Set Ghost Image"
	set desc = "Set an Image to use as your ghost."
	set category = "Preferences"

	choose_new_icon(src)

/mob/observer/verb/reset_ghost_image()
	set name = "Reset Image"
	set desc = "Reset your ghost image."
	set category = "Preferences"

	icon = initial(icon)
	icon_state = initial(icon_state)

/mob/observer/verb/see_darkness()
	set name = "See Darkness"
	set desc = "Unblock the darkness."
	set category = "Preferences"

	if(!config.darkness_toggleable)
		src << "Darkness cannot be toggled at this time."
		return

	see_darkness = !(see_darkness)
	src << "You turn darkness [see_darkness ? "on" : "off"]"
	update_vision()
