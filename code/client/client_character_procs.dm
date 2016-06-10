var/list/client_character_verbs = list(/client/proc/End_Turn, /client/proc/MoveOnly, /client/proc/Aim, /client/proc/All_Out_Attack, /client/proc/All_Out_Defense, /client/proc/ChangePosture)

//Returns the current mob on use.
/client/proc/can_use_character_verb(var/check_action = 1, var/check_done = 1)
	if(combat_state == COMBAT_OFF)
		src << "\red Combat is not on!"
		return null

	var/mob/living/L = turn_controller.get_current_mob()
	if(!L || !src)
		return null

	if(L.working)
		src << "\red \The [L] is currently doing something."
		return null

	if(L.controlled_by && L.controlled_by != ckey)
		src << "\red \The [L] is currently being controlled by [key]."
		return null

	if(check_done && (L.combat_flags & COMBAT_FLAG_DONE))
		src << "\red \The [L] has already completed their turn!."
		return null

	if(check_action && !(L.combat_flags & COMBAT_FLAG_ACTION))
		src << "\red \The [L] has already started doing an action."
		return null

	if(check_rights(R_ADMIN) || src.gamemaster || ("everyone" in L.allowed_control) || (src.key in L.allowed_control))
		return L

	src << "\red You do not have control of \the [L] to end its turn."
	return null

/client/proc/End_Turn()
	set name = "End Turn"
	set desc = "Ends a character's turn during combat."
	set category = "Character"

	if(can_use_character_verb(check_action = 0, check_done = 0))
		turn_controller.next_turn()

/client/proc/Aim()
	set name = "Aim"
	set desc = "Use your turn to aim, gaining bonuses to hit."
	set category = "Character"

	var/mob/living/L = can_use_character_verb()
	if(L)
		L.aim()

/client/proc/All_Out_Attack()
	set name = "All-Out-Attack"
	set desc = "Use your turn to attack with great vigor."
	set category = "Character"

	var/mob/living/L = can_use_character_verb()
	if(L)
		L.take_control(key)
		L.all_out_attack()

/client/proc/All_Out_Defense()
	set name = "All-Out-Defense"
	set desc = "Use your turn to defend, and only defend."
	set category = "Character"

	var/mob/living/L = can_use_character_verb()
	if(L)
		L.all_out_defense()


/client/proc/MoveOnly()
	set name = "Move"
	set desc = "Use your turn to move fully."
	set category = "Character"

	var/mob/living/L = can_use_character_verb()
	if(L)
		L.take_control(key)
		L.move()


/client/proc/ChangePosture()
	set name = "Change Posture"
	set desc = "Use your turn to change your posture."
	set category = "Character"

	var/mob/living/L
	if(combat_state == COMBAT_OFF)
		L = controlling
	else
		L = can_use_character_verb()
	if(L)
		//Figure out a better way to do this.
		var/choice = input(src,"Current posture is [L.posture]. Change to:","Posture",null) as null|anything in list(POSTURE_STAND, POSTURE_SIT, POSTURE_KNEEL, POSTURE_CRAWL, POSTURE_PRONE, POSTURE_BACK) - L.posture
		if(choice)
			L.take_control(key)
			L.change_posture(choice)