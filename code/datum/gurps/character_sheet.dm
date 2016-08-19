/datum/character_sheet
	var/datum/stat_system/connected_system
	var/client/user
	var/list/data
	var/closeable = 0
	var/modification_level = 0
	var/mode = "Sheet"

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
				var/value = connected_system.get_attribute_level(a,1,1, status_effect_bonuses = 0)
				data["[a] Real"] = value
				data[a] = wrap_data(value, "attribute=[a]", modification_level)
		specific = null //attributes change /everything/

		var/strength_base = connected_system.get_attribute_level("Strength",1)
		data["thrust_dice"] = get_thrust_dice(strength_base)
		data["swing_dice"] = get_swing_dice(strength_base)
		data["collapse health"] = 0
		data["collapse fatigue"] = 0
		data["basic lift"] = calculate_basic_lift(connected_system.get_attribute_level("Strength",1, status_effect_bonuses = 0))
		for(var/i in 1 to 5)
			data["death threshold [i]"] = -data["HP Real"] * i
	for(var/a in connected_system.points - "points")
		data[a] = connected_system.points[a]

	data["points"] = wrap_data(connected_system.points["points"], "add_points=1", modification_level)

	if(!specific || specific == "Skills")
		var/list/skill_list = list()

		for(var/s in 1 to connected_system.skill_list.len)
			var/list/skill_data = list()
			var/datum/skill_data/skill = connected_system.skill_list[s]

			skill_data["name"] = "[skill.name]"//[skill.specialization ? " ([skill.specialization])" : ""]"
			skill_data["level"] = skill.get_level_from_points()
			skill_data["relative skill level"] = "[skill.skill_parent.stat][skill.skill_parent.difficulty != 0 ? skill.skill_parent.difficulty : ""]"
			skill_data["points"] = wrap_data(skill.points, "skill=[skill.name];[skill.specialization ? "specialization=[skill.specialization]" : ""]", modification_level)
			skill_list["[s]"] = skill_data
		data["skill list"] = skill_list

	if(!specific || specific == "Inventory")
		var/list/inventory_list = list()
		if(connected_system.items.len)
			for(var/e in 1 to connected_system.items.len)
				var/list/item_list = list()
				var/obj/item/I = connected_system.items[e]
				item_list["name"] = I.name
				item_list["state"] = "<a href='byond://?src=\ref[src];select_item=[e]'>I</a>"
				item_list["amount"] = I.num
				item_list["cost per"] = 0
				item_list["weight per"] = I.get_singular_weight()
				item_list["cost total"] = 0
				item_list["weight total"] = I.get_weight()
				item_list["page number"] = I.page_number
				inventory_list["[e]"] = item_list
		data["equipment list"] = inventory_list

/datum/character_sheet/proc/generate_skill_list()
	. = "<style type=\"text/css\" title=\"text/css\">\
	             body\
	             {\
	                 color: black;\
	                 background-color: white;\
	                 font: normal 7pt/9pt 'Lucida Sans','Arial',sans-serif;\
	                 margin: 4pt;\
	             }\
	             table, tbody, tr, td\
	             {\
	                 margin: 0;\
	                 border-spacing: 0;\
	                 border-collapse: collapse;\
	                 font: normal 7pt/9pt 'Lucida Sans', 'Arial',sans-serif;\
	                 border: 1pt solid black;\
	             }\
	             table, tbody, tr { padding: 0; }\
	             td\
	             {\
	                 padding: 1pt 1pt 0 1pt;\
	                 verticle-align: top;\
	                 text-align: center;\
	             }\
	     </style>\
	     <body>\
	     <center><a href='byond://?src=\ref[src];switch_mode=Sheet'>Go Back</a></center>\
	         <table>\
	             <tr>\
	                 <td>Skill</td>\
	                 <td>Description</td>\
	                 <td>Difficulty</td>\
	                 <td>Defaults</td>\
	                 <td>Prerequests</td>\
	                 <td>Page</td>\
	                 <td>Actions</td>\
	             </tr>"
	for(var/s in skills)
		var/datum/skill/skill = skills[s]
		var/difficulty = "[skill.stat]/[difficulty2text(skill.difficulty)]"
		. += "<tr>\
		          <td>[skill.name]</td>\
		          <td>[skill.desc]</td>\
		          <td>[difficulty]</td>\
		          <td>"
		if(skill.defaults)
			for(var/d in skill.defaults)
				. += "[d][skill.defaults[d]]<br>"
		. +=      "</td>\
		           <td>"
		if(skill.prerequests)
			for(var/p in skill.prerequests)
				. += "[p]<br>"
		. +=      "</td>\
		           <td>[skill.page_number]</td>\
		           <td><a href='byond://?src=\ref[src];buy_skill=[skill.name]'>Buy</a></td>\
		       </tr>"
	. +=  "</table>\
	   </body>"

/datum/character_sheet/proc/generate_sheet()
	switch(mode)
		if("Sheet")
			. =""
			if(closeable)
				. += "<center><a href='byond://?src=\ref[src];close=\ref[src]'>Close</a></center><br>"
			. += "<center><a href='byond://?src=\ref[src];switch_mode=Skill'>Buy Skills</a></center><br>"
			. += generate_character_sheet(data,modification_level)
		if("Skill")
			. += generate_skill_list()


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
	if(href_list["switch_mode"])
		mode = href_list["switch_mode"]
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
		world << isnull(href_list["specialization"])
		world << "\"[href_list["specialization"]]\""
		if(choice)
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
	if(href_list["buy_skill"])
		var/datum/skill/skill = get_skill_by_name(href_list["buy_skill"])
		var/specialization
		if(skill.specializations)
			specialization = input(user, "Choose specialization", "Specialization", "None") as anything in skill.specializations + "None"
			if(specialization == "None")
				specialization = null
			else if (specialization == "editable")
				specialization = input(user, "You have chosen a custom specialization. Enter it now.", "Specialization", null) as null|text
		if(connected_system.get_real_skill(skill.name, specialization))
			alert(user,"You already have that skill!","Alert")
			return
		connected_system.add_points_to_skill(skill.name,specialization,1)
		refresh_data("Skills")
	if(href_list["add_points"])
		var/num = input(user, "You have [user.global_points] global points left. How many do you wish to transfer?", "Points", 0) as num
		if(num > user.global_points)
			alert(user, "That is more than you have!")
			return
		if(num < 0)
			return
		connected_system.points["points"] += num
		user.global_points -= num
		connected_system.sync_total_points()
		refresh_data("Points")
	if(href_list["select_item"])
		var/num = text2num(href_list["select_item"])
		var/choice = input(user, "Select action.", "Inventory", null) as null|anything in list("Equip", "Examine", "Drop")
		switch(choice)
			if("Drop")
				connected_system.holder.drop(num)
		refresh_data("Inventory")

	user << browse(generate_sheet(), "window=charsheet")
	return ..()

/datum/character_sheet/proc/close_character_sheet()
	user << browse(null, "window=charsheet")
	qdel(src)