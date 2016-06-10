/mob/observer/verb/upload_ghost_image()
	set name = "Upload Image"
	set desc = "Upload an Image to use as your ghost."
	set category = "Preferences"
	var/icon/file = input(src,"Upload an Image", "Image Uploading") as null|icon
	if(!file)
		return
	icon = file
	var/state = input(src, "Does this file have an icon state?", "Icon State") as null|text
	if(state)
		icon_state = state
	else
		icon_state = ""

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
