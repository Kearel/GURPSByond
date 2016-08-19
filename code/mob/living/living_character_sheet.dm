/mob/living/proc/get_character_sheet(var/client/user)
	var/text= "[src.portrait_state]"
	if(!global_resource_cache[text])
		global_resource_cache[text] = new /icon(src.portrait_icon, src.portrait_state)
	user << browse_rsc(global_resource_cache[text], "[text].png")
	new /datum/character_sheet(stats, user, list("portrait" = text, "name" = name, "fp" = fatigue, "hp" = health), 1)