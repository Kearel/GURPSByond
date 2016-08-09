/datum/character_sheet
	var/datum/stat_system/connected_system
	var/client/user
	var/list/data
	var/closeable = 0
	var/modification_level = 0

/datum/character_sheet/New(var/system, var/target, new_data, var/let_close)
	if(system)
		connected_system = system
	else
		connected_system = new

	character_sheets += src

	user = target
	data = new_data
	closeable = let_close
	if(!istype(user,/client))
		var/mob/M = user
		user = M.client
	if(user.holder || user.gamemaster)
		modification_level = MODIFICATION_ADMIN
	else if(user.controlling == connected_system.holder)
		modification_level = MODIFICATION_USER
	refresh_data()
	user << browse(generate_sheet(), "window=charsheet;can_close=0;size=750x500")

/datum/character_sheet/proc/refresh_data(var/specific)
	if(!data)
		data = list()
	if(!specific || specific == "Attributes")
		for(var/a in connected_system.attributes)
			if(connected_system.attributes[a])
				var/value = connected_system.get_attribute_level(a,1,1)
				data["[a] Real"] = value
				data[a] = wrap_data(value, "attribute=[a]", modification_level)
		specific = null //attributes change /everything/

		var/strength_base = connected_system.get_attribute_level("Strength",1)
		data["thrust_dice"] = get_thrust_dice(strength_base)
		data["swing_dice"] = get_swing_dice(strength_base)
		data["collapse health"] = 0
		data["collapse fatigue"] = 0
		for(var/i in 1 to 5)
			data["death threshold [i]"] = -data["HP Real"] * i
	if(!specific || specific == "Points")
		for(var/a in connected_system.points)
			data[a] = connected_system.points[a]

	if(!specific || specific == "Skills")
		var/list/skill_list = list()

		for(var/s in 1 to connected_system.skill_list.len)
			var/list/skill_data = list()
			var/datum/skill_data/skill = connected_system.skill_list[s]

			skill_data["name"] = "[skill.name]"//[skill.specialization ? " ([skill.specialization])" : ""]"
			skill_data["level"] = skill.get_level_from_points()
			skill_data["relative skill level"] = "[skill.skill_parent.stat][skill.skill_parent.difficulty != 0 ? skill.skill_parent.difficulty : ""]"
			skill_data["points"] = wrap_data(skill.points, "skill=[skill.name];specialization=[skill.specialization]", modification_level)
			skill_list["[s]"] = skill_data
		data["skill list"] = skill_list

/datum/character_sheet/proc/generate_sheet()
	. =""

	if(closeable)
		. += "<center><a href='byond://?src=\ref[src];close=\ref[src]'>Close</a></center><br>"
	. += generate_character_sheet(data,modification_level)

/datum/character_sheet/proc/wrap_data(var/data, var/tag, var/modification_level)
	return "[modification_level ? "<a href='byond://?src=\ref[src];[tag];access=[modification_level]'>" : ""][data][modification_level ? "</a>" : ""]"

/datum/character_sheet/Destroy()
	character_sheets -= src
	if(connected_system && !connected_system.holder)
		qdel(connected_system)
	..()

/datum/character_sheet/Topic(href, href_list, hsrc) //Eventually maybe just open a new window to edit shit
	if(href_list["close"])
		close_character_sheet()
		return
	if(href_list["attribute"])
		var/choice = input(user, "What do you wish to do?", href_list["attribute"], null) as null|anything in list("Increase", "Decrease")
		if(choice)
			switch(choice)
				if("Increase")
					if(connected_system.add_level_to_attribute(href_list["attribute"], 1))
						refresh_data()
					else
						return
				if("Decrease")
					if(connected_system.add_level_to_attribute(href_list["attribute"], -1))
						refresh_data()
					else
						return

	if(href_list["skill"])
		var/choice = input(user, "What do you wish to do?", href_list["skill"], null) as null|anything in list("Increase", "Decrease")
		if(choice)
			world << href_list["specialization"]
			switch(choice)
				if("Increase")
					if(connected_system.add_points_to_skill(href_list["skill"], href_list["specialization"], 1))
						refresh_data("Skills")
					else
						return
				if("Decrease")
					if(connected_system.add_points_to_skill(href_list["skill"], href_list["specialization"], -1))
						refresh_data("Skills")
					else
						return

	user << browse(generate_sheet(), "window=charsheet")
	return ..()

/datum/character_sheet/proc/close_character_sheet()
	user << browse(null, "window=charsheet")
	qdel(src)