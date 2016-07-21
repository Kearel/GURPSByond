
//////////////////////
//     GAMEMASTER   //
//////////////////////

/client/proc/toggle_visibility()
	set name = "Toggle Visibility"
	set desc = "Toggle whether non-GMs can see you."
	set category = "GameMaster"
	var/off = (mob.invisibility == INVISIBILITY_OBSERVER)

	mob.invisibility = (off ? INVISIBILITY_GAMEMASTER : INVISIBILITY_OBSERVER)
	src << "You are now [off ? "invisible" : "visible"] to the non-GMs"

/client/proc/toggle_combat_verb()
	set name = "Toggle Combat Off/On"
	set desc = "Toggle combat mode."
	set category = "GameMaster"

	toggle_combat()

/client/proc/toggle_buildmode()
	set name = "Toggle Buildmode"
	set desc = "Turf on/off buildmode."
	set category = "GameMaster"

	if(build)
		qdel(build)
		show_popup_menus = 1
		build = null
	else
		show_popup_menus = 0
		build = new /datum/build_mode()

	src << "You turn [build ? "on" : "off"] buildmode."

/client/proc/toggle_allow_darkness()
	set name = "Toggle Darkness Toggling"
	set desc = "Toggle whether players can turn on and off darkness."
	set category = "GameMaster"

	config.darkness_toggleable = !config.darkness_toggleable

	src << "You toggle Toggling [config.darkness_toggleable ? "on" : "off"]."

/client/proc/edit_mob_permissions(var/mob/living/L)
	set name = "Edit Mob Permissions"
	set desc = "Edit what players can control this mob."
	set category = "GameMaster"

	if(!istype(L))
		src << "\red Can only be used on living mobs."
		return
	if(alert("Edit global control of \the [L] or specific?","Mob Permissions","Global", "Specific") == "Global")
		if(alert("Turn global control on or off?", "Mob Permissions", "On", "Off") == "On")
			L.allowed_control |= "everyone"
		else
			L.allowed_control -= "everyone"
		return
	var/mode = alert("Would you like to use a list, or directly enter their key?",,"Key", "List")
	while(1)
		if(mode == "List")
			var/list/keys = list()
			for(var/key in directory)
				if(key in L.allowed_control)
					keys["[key] ALLOWED"] = "[key]"
				else
					keys["[key] DISALLOWED"] = "[key]"
			var/key = input("Select a key of the player to toggle permissions. Press cancel to finish.", "Mob Permissions") as null|anything in keys
			if(!key)
				return
			L.toggle_control(keys[key])
		else
			var/key = input("Enter the key of the player. Press cancel to finish.","Mob Permissions") as null|text
			if(!key)
				return
			if(!directory["[key]"])
				src << "\red The client [key] cannot be found. Please try again."
				continue
			if(alert("Turn on or off permissions for [key] for \the [L]?","Mob Permissions", "On", "Off") == "On")
				L.add_control(key)
			else
				L.remove_control(key)

/client/proc/create_new_status_effect()
	set name = "Create new status effect"
	set desc = "Create a new status effect."
	set category = "GameMaster"

	var/list/rvars = list()
	rvars["name"]     = input("Name of the status effect", "Status Effect", "Effect") as text
	rvars["desc"]     = input("Description of the status effect", "Status Effect", "An effect") as text
	rvars["duration"] = input("Duration of effect", "Status Effect",1) as num
	rvars["stat"]     = input("Used Stat", "Status Effect", "Strength") as text
	rvars["amount"]   = input("Amount of bonus", "Status Effect", 0) as num
	rvars["mult"]     = input("Amount of bonus multiplier", "Status Effect", 1) as num

	for(var/a in rvars)
		world << "[a] = [rvars[a]]"


	created_status_effects[rvars["name"]] = rvars

/client/proc/apply_status_effect(var/mob/living/L)
	set name = "Apply status effect"
	set desc = "Apply a created status effect."
	set category = "GameMaster"

	var/list/rvars = list()
	var/type = /status_effect/duration/stat
	if(alert("Use a pregenerated effect, or one you've created at runtime?", "Status Effects", "Pregenerated", "Created") == "Created")
		var/choice = input("Choose from the list below", "Status Effects", null) as null|anything in created_status_effects
		if(!choice)
			return
		rvars = created_status_effects[choice]
	else
		type = input("Choose from a list below", "Status Effects", /status_effect/duration/stat) as anything in typesof(/status_effect)

	L.add_status_effect(type, rvars)