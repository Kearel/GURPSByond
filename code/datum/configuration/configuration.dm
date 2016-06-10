/datum/configuration
	var/greet_text = "Hello!"
	var/world_name = "Fartsville"
	var/looc_allowed = 1
	var/ooc_allowed  = 1
	var/darkness_toggleable = 1
	var/base_attribute_level = 10
	var/attribute_points_per_level = 10
	var/starting_points = 100
	var/base_movement = 10 //What we use as our base from which we subtract basic_speed from to get our actual movement delay.

/datum/configuration/proc/load_config(var/filename)
	var/list/Lines = file2list(filename)

	for(var/t in Lines)
		if(!t)	continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		switch(name)
			if("greet_text")
				config.greet_text = value
			if("world_name")
				config.world_name = value
			if("looc_disabled")
				config.looc_allowed = 0
			if("ooc_disabled")
				config.ooc_allowed = 0
			if("no_toggle_darkness")
				darkness_toggleable = 0
			if("points_per_attribute")
				attribute_points_per_level = text2num(value)
			if("base_attribute_level")
				base_attribute_level = text2num(value)
			if("starting_points")
				starting_points = text2num(value)
			if("base_movement_delay")
				base_movement = text2num(value)

/proc/load_config()
	config = new()
	config.load_config("config/config.txt")