/mob/proc/choose_new_icon(var/mob/user)
	var/choice = input(user, "Choose an image to change to.", "Image changing", null) as null|anything in icon_files
	if(choice)
		icon = icon_files[choice]

	var/list/states = icon_states(icon)
	if(states.len)
		var/state = input(user, "Choose a particular icon state?", "Icon State") as null|anything in states
		if(state)
			icon_state = state
			return
	icon_state = ""