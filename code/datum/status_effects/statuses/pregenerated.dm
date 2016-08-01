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
	return manager.target.health > manager.target.maxHealth * 0.3

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