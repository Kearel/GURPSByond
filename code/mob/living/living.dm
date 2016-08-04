//a 'pawn' in the game. Can be destroyed.

/mob/living
	name = "living"
	desc = "if you seein' this something is missing its description."

	icon = 'icons/mob/basic.dmi'

	delete_on_death = 0
	var/list/allowed_control = list("everyone") //ckeys of who is controlling this guy
	var/controlled_by = null//the key of who is controlling us
	var/portrait_state = "default"
	var/portrait_icon = 'icons/portraits/portrait_large.dmi'
	var/combat_flags = 0 //flags specifically for combat and combat related states.
	var/fatigue = 0
	var/maxFatigue = 0
	var/posture = POSTURE_STAND
	var/stunned = 0 //If this is greater than 0, then they are stunned
	var/attack_disabled = 0 //If this is greater than 0, then they cannot attack
	var/working = 0
	var/life_tick = 0

/mob/living/New()
	..()
	living_mobs += src

/mob/living/Destroy()
	living_mobs -= src
	turn_controller.remove_mob(src)
	if(allowed_control && allowed_control.len)
		for(var/a in allowed_control)
			var/client/C = directory["[a]"]
			if(C && C.controlling == src)
				C.controlling = null
	..()

/mob/living/Death()
	..()
	world << "[get_inline()] falls down, dead."
	turn_controller.remove_mob(src)

/mob/living/Life()
	. = stat != DEAD
	if(.)
		life_tick++
		if(combat_state == COMBAT_OFF)
			status_manager.process_event(STATUS_EVENT_ENDTURN)
			status_manager.process_event(STATUS_EVENT_STARTTURN)

			if(life_tick%5 == 2)
				health_check()
				disable_check()

/mob/living/proc/get_portrait(var/size)
	return "<IMG CLASS=icon SRC=\ref[portrait_icon] ICONSTATE='[portrait_state]' style='width:[size]px;height:[size]px;'>"

/mob/living/proc/get_inline()
	return "[get_portrait(32)] <b>\the [src]</b>"

//In case we want to obfusicate this information eventually.
/mob/living/proc/get_blurb()
	return desc

/*/mob/living/proc/attack(var/atom/movable/A, var/surprise_attack)
	start_combat()
	if(istype(A,/mob/living))
		var/mob/living/L = A
		if(!surprise_attack)
			return
*/

//Gets called everytime a turn starts.
/mob/living/proc/TurnStart()
	combat_flags |= COMBAT_FLAG_TURN|COMBAT_FLAG_ACTION
	build_overlays()
	health_check()
	disable_check()
	if(stat || stunned)
		world << "[get_inline()] is disabled and cannot do their turn!"
		turn_controller.next_turn()
	return

//Gets called everytime a turn ends.
/mob/living/proc/TurnEnd()
	combat_flags = 0
	wipe_movement_list()
	build_overlays()

	return

//Gets called when combat begins/ends.
/mob/living/proc/PrepareCombat()
	walk_to(src,0)
	combat_flags = 0
	build_overlays()
	wipe_movement_list()


/mob/living/proc/adjust_fatigue(var/amount)
	var/health_drop = 0

	var/previousFatigue = fatigue
	fatigue -= amount
	if(fatigue < 0)
		health_drop += amount
		if(previousFatigue > 0)
			health_drop = min(0, health_drop + previousFatigue)
	if(fatigue < -maxFatigue)
		var/difference = fatigue + maxFatigue
		health_drop += difference
	if(fatigue == -maxFatigue)
		pass_out()
	adjust_health(health_drop)

/mob/living/adjust_health(var/amount)
	if(maxHealth && stat != DEAD && amount != 0) //we have some sort of health
		if(amount > 0)
			src.add_status_effect(/status_effect/duration/shock, list("amount" = min(4,amount)))
		status_manager.process_event(STATUS_EVENT_DAMAGE, amount)
		var/previousHealth = health
		health = max(5 * death_threshold,min(maxHealth,health - amount))
		if(health <= maxHealth/3 && previousHealth > maxHealth / 3)
			src.add_status_effect(/status_effect/reeling)
		if(health < 0)
			for(var/i in 1 to 5)
				if(health <= death_threshold * i)
					if(previousHealth > death_threshold * i)
						var/roll = roll_skill("Health")
						if(i == 5 || roll == "CRIT FAIL" || roll > 0)
							Death()
					break
	return 1


/mob/living/proc/health_check()
	if(!stat && health <= 0)
		var/roll = roll_skill("Health", quiet_roll = (combat_state == COMBAT_OFF))
		if(roll == "CRIT FAIL" || roll > 0)
			pass_out()

/mob/living/proc/pass_out()
	world << "[get_inline()] passes out!"
	stat = DISABLED
	build_overlays()

/mob/living/proc/disable_check()
	if(stat != DISABLED)
		return
	stat = (health > 0 && fatigue > 0)