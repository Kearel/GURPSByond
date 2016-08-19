/mob/living/proc/check_encumberance()
	status_manager.process_event(STATUS_EVENT_INVENTORY)
	var/level = stats.get_encumberance_level()
	add_status_effect(/status_effect/duration/encumbered, list("level" = (level < 5 ? level : 5)))
	if(level > 5)
		add_status_effect(/status_effect/over_encumbered)

/mob/living/proc/pickup(var/obj/item/I)
	if(!action_precheck())
		return
	if(get_dist(src,I) > 1)
		return

	world << "[get_inline()] picks up \the [I]"
	stats.add_item(I)
	check_encumberance()

/mob/living/proc/drop(var/num)
	var/obj/item/I = stats.get_item(num)
	if(!I)
		return
	world << "[get_inline()] drops \a [I]"
	stats.remove_item(num, get_turf(src))
	check_encumberance()