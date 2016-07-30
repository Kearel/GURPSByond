/mob/living/proc/get_attack_range()
	return 1

/mob/living/proc/can_attack(var/atom/a)
	if(!(combat_flags & COMBAT_FLAG_ATTACK) && combat_state != COMBAT_OFF)
		return 0
	var/dist = get_dist(src,a)
	if(dist > get_attack_range() || stunned || attack_disabled)
		return 0
	var/turf/source = get_turf(src)
	var/turf/target = get_turf(a)
	for(var/i in 1 to dist) //Make sure there isn't something blocking us (outside of what we are aiming for)
		source = get_step_towards(source,a)
		if(source.density)
			return 0
		if(target == source)
			break
		for(var/thing in source)
			var/atom/A = thing
			if(A.density)
				return 0
	return 1

/mob/living/proc/get_attack_damage()
	return "1d6-3"

/mob/living/proc/make_attack_roll(var/atom/a, var/check_availability = 1)
	if(check_availability && !can_attack(a))
		return 0
	world << "[get_portrait(32)] <b>\The [src] attacks!</b>"
	var/roll_to_attack = roll_skill("Brawling")
	if(istext(roll_to_attack))
		if(roll_to_attack == "CRITICAL")
			return 1
		else
			return 0
	else
		if(roll_to_attack < 1)
			if(istype(a, /mob/living))
				var/mob/living/L = a
				var/roll_to_defend = L.roll_skill("Dodge")
				if(roll_to_defend > 0)
					deal_damage(a)
				else
					world << "\red \The [src] misses!"
	combat_flags ^= COMBAT_FLAG_ATTACK
	start_combat()
	return 1

/mob/living/proc/deal_damage(var/atom/a)
	var/action = pick("hits", "punches")
	var/other_portrait
	if(istype(a,/mob/living))
		var/mob/living/L = a
		other_portrait = L.get_portrait(32)
	world << "[get_portrait(32)] <b>\The [src]</b> [action]  [other_portrait ? other_portrait : ""] <b>\the [a]</b>!"
	var/damage = max(0,roll(get_attack_damage()))
	world << "They deal [damage] damage."
	a.adjust_health(damage)

/mob/living/