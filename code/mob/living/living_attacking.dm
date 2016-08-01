/mob/living/proc/toggle_attack(var/on)
	if(on)
		combat_flags |= COMBAT_FLAG_ATTACK
	else if(combat_flags & COMBAT_FLAG_ATTACK)
		combat_flags ^= COMBAT_FLAG_ATTACK
	build_overlays()

/mob/living/proc/get_attack_range()
	return 1

/mob/living/proc/can_attack(var/atom/a)
	if(!(combat_flags & COMBAT_FLAG_ATTACK))
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
	return get_swing_dice(get_attribute_level("Strength",1))

/mob/living/proc/roll_attack_damage()
	return max(0,roll(get_attack_damage()))

/mob/living/proc/make_attack_roll(var/atom/a, var/check_availability = 1)
	if(check_availability && !can_attack(a))
		return 0
	world << "[get_inline()] <b>attacks!</b>"
	var/roll_to_attack = roll_skill("Brawling", move_attack_rules = !!(combat_flags & COMBAT_FLAG_MOVE_ATTACK))
	if(istext(roll_to_attack))
		if(roll_to_attack == "CRITICAL")
			deal_critical_damage(a)
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
	toggle_attack(0)
	start_combat()
	return 1

/mob/living/proc/deal_damage(var/atom/a)
	var/action = pick("hits", "punches")
	var/other = "\the [a]"
	if(istype(a,/mob/living))
		var/mob/living/L = a
		other = L.get_inline()
	world << "[get_inline()] [action] [other]!"
	var/damage = roll_attack_damage()
	world << "They deal [damage] damage."
	a.adjust_health(damage)

/mob/living/proc/deal_critical_damage(var/atom/a)
	var/action = pick("atomizes", "pulverizes")
	var/other = "\the [a]"
	if(istype(a,/mob/living))
		var/mob/living/L = a
		other = L.get_inline()
	world << "[get_inline()] </b> [action] [other]!"
	var/number = roll("3d6")
	if(number in list(3,18))
		world << "TRIPLE DAMAGE!"
		var/damage = roll_attack_damage()
		world << "They deal [damage] x 3 damage!"
		a.adjust_health(damage*3)
	else if(number in list(5,16))
		world << "DOUBLE DAMAGE!"
		var/damage = roll_attack_damage()
		world << "They deal [damage] x 2 damage!"
		a.adjust_health(damage*2)
	else if(number in list(6,15))
		world << "MAXIMUM DAMAGE!"
		var/dice = get_attack_damage()
		var/list/splitted = splittext(dice,"d")
		var/num_of_dice = text2num(splitted[1])
		var/sides_of_dice = 0
		var/bonus = 0
		var/list/splitted2 = splittext(splitted[2], "-")
		if(splitted2.len == 1)
			splitted2 = splittext(splitted[2], "+")
			if(splitted2.len > 1)
				sides_of_dice = text2num(splitted2[1])
				bonus = text2num(splitted2[2])
			else
				sides_of_dice = text2num(splitted[2])
		else
			bonus = -1 * text2num(splitted2[2])

		var/damage = max(0,num_of_dice * sides_of_dice + bonus)
		world << "They deal [damage] damage!"
		a.adjust_health(damage)
	else
		world << "DO THE REST LATERRRR"
		deal_damage(a)