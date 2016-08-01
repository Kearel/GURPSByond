//Returns the current mob on use.
/client/proc/can_use_character_verb(var/check_action = 1, var/check_working = 1, var/check_turn = 1)
	if(!controlling)
		src << "\red You are not controlling anyone."
		return 0

	if(check_turn && combat_state != COMBAT_OFF && controlling != turn_controller.get_current_mob())
		src << "\red It is not \the [controlling]'s turn!"
		return 0

	if(check_working && controlling.working)
		src << "\red \The [controlling] is currently doing something."
		return 0

	if(check_action && combat_state != COMBAT_OFF && !(controlling.combat_flags & COMBAT_FLAG_ACTION))
		src << "\red \The [controlling] has already started doing an action."
		return 0

	return 1

/client/verb/End_Turn()
	set name = "End Turn"
	set desc = "Ends a character's turn during combat."
	set category = "Character"

	if(combat_state != COMBAT_OFF && can_use_character_verb(check_action = 0))
		turn_controller.next_turn()

/client/verb/Aim()
	set name = "Aim"
	set desc = "Use your turn to aim, gaining bonuses to hit."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.aim()

/client/verb/All_Out_Attack()
	set name = "All-Out-Attack"
	set desc = "Use your turn to attack with great vigor."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.all_out_attack()

/client/verb/All_Out_Defense()
	set name = "All-Out-Defense"
	set desc = "Use your turn to defend, and only defend."
	set category = "Character"

	if(!can_use_character_verb())
		return

	var/choice = input(src, "All-Out-Defense Increases a defense type by 2 for duration of your turn.", "All-Out-Defense", null) as null|anything in list("Dodge", "Block", "Parry")
	if(choice)
		controlling.all_out_defense(choice)

/client/verb/AttackOnly()
	set name = "Attack Only"
	set desc = "Use your turn to attack exclusively."
	set category = "Character"

	if(!can_use_character_verb())
		return

	controlling.attack()

/client/verb/MoveAndAttack()
	set name = "Move And Attack"
	set desc = "Use your turn to both move and attack."
	set category = "Character"

	if(!can_use_character_verb())
		return

	controlling.move_and_attack()

/client/verb/MoveOnly()
	set name = "Move Only"
	set desc = "Use your turn to move fully."
	set category = "Character"

	if(!can_use_character_verb())
		return
	controlling.move()


/client/verb/ChangePosture()
	set name = "Change Posture"
	set desc = "Use your turn to change your posture."
	set category = "Character"
	//Figure out a better way to do this.

	if(!can_use_character_verb())
		return

	var/choice = input(src,"Current posture is [controlling.posture]. Change to:","Posture",null) as null|anything in list(POSTURE_STAND, POSTURE_SIT, POSTURE_KNEEL, POSTURE_CRAWL, POSTURE_PRONE, POSTURE_BACK) - controlling.posture
	if(choice)
		controlling.change_posture(choice)

/client/verb/CharacterSheet()
	set name = "Indepth Character Sheet"
	set desc = "See this character's character sheet."
	set category = "Character"

	var/dat = "SUP"
	src << browse(dat)

/client/verb/csay(var/message as text)
	set name = "csay"
	set desc = "Let the character you are playing say something"
	set category = "Character"

	if(!can_use_character_verb(check_action = 0, check_working = 0, check_turn = 0))
		return

	controlling.say(message)

/client/verb/change_mob_image()
	set name = "Change Mob Image"
	set desc = "Change the appearance of your controlled mob."
	set category = "Character"

	if(!can_use_character_verb(check_action = 0, check_working = 0, check_turn = 0))
		return

	controlling.choose_new_icon(src.mob)