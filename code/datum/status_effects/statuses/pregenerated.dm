/status_effect/duration/stat/basic_move/change_posture
	name = "Changed Posture (-1 Movement)"
	stat = "Basic Move"
	amount = -1

/status_effect/duration/stat/alloutdodge
	name = "All Out Dodge (+2 Dodge)"
	flags = STATUS_EVENT_STARTTURN
	stat = "Dodge"
	amount = 2

/status_effect/reeling
	name = "Reeling"
	flags = STATUS_EVENT_DAMAGE

/status_effect/reeling/New()
	if(!..() || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	for(var/stat in list("Basic Speed", "Basic Move"))
		var/datum/stat/S = L.stats.get_real_attribute(stat)
		S.bonus_mult -= 0.5

/status_effect/reeling/Destroy()
	if(!manager || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	for(var/stat in list("Basic Speed", "Basic Move"))
		var/datum/stat/S = L.stats.get_real_attribute(stat)
		S.bonus_mult += 0.5
	..()

/status_effect/reeling/should_delete()
	return manager.target.health > manager.target.maxHealth * 0.3

/status_effect/tired/New()
	if(!..() || !ismob(manager.target))
		return

	var/mob/living/L = manager.target
	var/datum/stat/health = L.stats.get_real_attribute("HP")
	health.bonus_mult += 1 //Strength decay does not effect HP
	for(var/stat in list("Strength", "Basic Speed", "Basic Move"))
		var/datum/stat/S = L.stats.get_real_attribute("Strength")
		S.bonus_mult -= 0.5

/status_effect/tired/Destroy()
	if(!manager || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	var/datum/stat/health = L.stats.get_real_attribute("HP")
	health.bonus_mult -= 1
	for(var/stat in list("Strength", "Basic Speed", "Basic Move"))
		var/datum/stat/S = L.stats.get_real_attribute(stat)
		S.bonus_mult += 0.5
	..()

/status_effect/reeling/should_delete()
	return manager.target.health > manager.target.maxHealth / 3

/status_effect/duration/shock
	name = "Shock"
	desc = "Too much damage! You take minuses to dexterity and intelligence"
	flags = STATUS_EVENT_STARTTURN
	var/amount = 0

/status_effect/duration/shock/New()
	if(!..() || !ismob(manager.target))
		return

	var/mob/living/L = manager.target
	for(var/a in list("Dexterity", "Intelligence"))
		var/datum/stat/stat = L.stats.get_real_attribute(a)
		stat.bonus -= amount
	var/datum/stat/dodge = L.stats.get_real_attribute("Dodge")
	dodge.bonus += amount * 4

/status_effect/duration/shock/Destroy()
	if(!manager || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	for(var/a in list("Dexterity", "Intelligence"))
		var/datum/stat/stat = L.stats.get_real_attribute(a)
		stat.bonus += amount
	var/datum/stat/dodge = L.stats.get_real_attribute("Dodge")
	dodge.bonus -= amount * 4

/status_effect/duration/encumbered
	name = "Encumbered"
	desc = "You are carrying too much!"
	flags = STATUS_EVENT_INVENTORY
	var/level = 0

/status_effect/duration/encumbered/New()
	if(!..() || !ismob(manager.target))
		return

	name = "Encumbered ([encumberance_levels[level]])"
	var/mob/living/L = manager.target
	var/datum/stat/dodge = L.stats.get_real_attribute("Dodge")
	dodge.bonus -= level
	var/datum/stat/movement = L.stats.get_real_attribute("Basic Move")
	movement.bonus_mult -= 0.2 * level

/status_effect/duration/encumbered/Destroy()
	if(!manager || !manager.target || !ismob(manager.target))
		return
	var/mob/living/L = manager.target
	var/datum/stat/dodge = L.stats.get_real_attribute("Dodge")
	dodge.bonus += level
	var/datum/stat/movement = L.stats.get_real_attribute("Basic Move")
	movement.bonus_mult += 0.2 * level

/status_effect/over_encumbered
	name = "Over-Encumbered"
	desc = "You are carrying so much, you are actively getting weaker and weaker."
	flags = STATUS_EVENT_INVENTORY|STATUS_EVENT_STARTTURN

/status_effect/over_encumbered/process_flag(var/flag)
	if(flag == STATUS_EVENT_STARTTURN)
		var/mob/living/L = manager.target
		L.adjust_fatigue(1)

/status_effect/over_encumbered/should_delete(var/flag)
	if(flag == STATUS_EVENT_INVENTORY)
		var/mob/living/L = manager.target
		return L.stats.get_encumberance_level() <= 5
	return 0
