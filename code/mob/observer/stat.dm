/mob/observer/Stat()
	. = ..()
	Stat_Controlling()

/mob/observer/proc/Stat_Controlling()
	if(!client.controlling)
		return
	var/mob/living/L = client.controlling
	if(statpanel("Information ([L])"))
		stat(null,"[client.controlling.get_portrait()]           <font size='5'>\The [client.controlling]</font>")
		stat(null, "[client.controlling.get_blurb()]")
		stat(null, "HP: [L.health]/[L.maxHealth]		Basic Speed: [client.controlling.get_attribute_level("Basic Speed",1,1)]")
		stat(null, "FP: [L.fatigue]/[L.maxFatigue]	Basic Move: [client.controlling.get_attribute_level("Basic Move",1,1)]")
		stat(null, "Posture: [L.posture]")
		stat(null, "<font size='4'>ATTRIBUTES</font>")
		for(var/a in list("Strength", "Dexterity", "Intelligence", "Health"))
			stat(null, "<b>[a]:</b> [client.controlling.get_attribute_level(a,1,1)]")