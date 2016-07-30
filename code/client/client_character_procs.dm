var/list/client_character_verbs = list(/client/proc/End_Turn, /client/proc/MoveOnly, /client/proc/Aim, /client/proc/All_Out_Attack, /client/proc/All_Out_Defense, /client/proc/ChangePosture, /client/proc/CharacterSheet)

//Returns the current mob on use.
/client/proc/can_use_character_verb(var/check_action = 1)
	if(combat_state != COMBAT_OFF && controlling != turn_controller.get_current_mob())
		src << "\red It is not \the [controlling]'s turn!"
		return 0
	if(!controlling || !src)
		return 0

	if(controlling.working)
		src << "\red \The [controlling] is currently doing something."
		return 0

	if(check_action && combat_state != COMBAT_OFF && !(controlling.combat_flags & COMBAT_FLAG_ACTION))
		src << "\red \The [controlling] has already started doing an action."
		return 0

	return 1

/client/proc/End_Turn()
	set name = "End Turn"
	set desc = "Ends a character's turn during combat."
	set category = "Character"

	if(combat_state != COMBAT_OFF && can_use_character_verb(check_action = 0))
		turn_controller.next_turn()

/client/proc/Aim()
	set name = "Aim"
	set desc = "Use your turn to aim, gaining bonuses to hit."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.aim()

/client/proc/All_Out_Attack()
	set name = "All-Out-Attack"
	set desc = "Use your turn to attack with great vigor."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.all_out_attack()

/client/proc/All_Out_Defense()
	set name = "All-Out-Defense"
	set desc = "Use your turn to defend, and only defend."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.all_out_defense()


/client/proc/MoveOnly()
	set name = "Move Only"
	set desc = "Use your turn to move fully."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.move()


/client/proc/ChangePosture()
	set name = "Change Posture"
	set desc = "Use your turn to change your posture."
	set category = "Character"
	//Figure out a better way to do this.
	var/choice = input(src,"Current posture is [controlling.posture]. Change to:","Posture",null) as null|anything in list(POSTURE_STAND, POSTURE_SIT, POSTURE_KNEEL, POSTURE_CRAWL, POSTURE_PRONE, POSTURE_BACK) - controlling.posture
	if(choice)
		controlling.change_posture(choice)

/client/proc/CharacterSheet()
	set name = "Indepth Character Sheet"
	set desc = "See this character's character sheet."
	set category = "Character"

	var/dat = "SUP"
	src << browse(dat)