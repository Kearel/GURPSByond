//a 'pawn' in the game. Can be destroyed.

/mob/living
	name = "living"
	desc = "if you seein' this something is missing its description."

	icon = 'icons/mob/basic.dmi'
	icon_state = "kobold_idle"
	var/list/allowed_control = list("everyone") //ckeys of who is controlling this guy
	var/controlled_by = null//the key of who is controlling us
	var/portrait_state = "kobold"
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

/mob/living/Life()
	. = stat != DEAD
	if(.)
		life_tick++
		if(combat_state == COMBAT_OFF)
			status_manager.process_event(STATUS_EVENT_ENDTURN)
			status_manager.process_event(STATUS_EVENT_STARTTURN)

/mob/living/proc/get_portrait(var/size)
	return "<IMG CLASS=icon SRC=\ref[portrait_icon] ICONSTATE='[portrait_state]' style='width:[size]px;height:[size]px;'>"

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

/mob/living/proc/do_attack(var/atom/A, var/datum/attack/attack)
	return

//Gets called everytime a turn starts.
/mob/living/proc/TurnStart()
	combat_flags |= COMBAT_FLAG_TURN|COMBAT_FLAG_ACTION
	build_overlays()
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
	current_path = null


/mob/living/proc/adjust_fatigue(var/amount)
	if(fatigue < 1)
		stunned--
	fatigue -= amount
	if(fatigue < 1)
		stunned++