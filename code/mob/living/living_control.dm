/mob/living/proc/can_control(var/key)
	return ((key in allowed_control) || ("everyone" in allowed_control)) && (controlled_by == null)

/mob/living/proc/take_control(var/key)
	if(!can_control(key))
		return
	var/client/C = directory["[key]"]
	controlled_by = key
	C.controlling = src
	C.start_controlling(src)
	update_movement_images()

/mob/living/proc/stop_control()
	var/client/C = directory["[controlled_by]"]
	if(C && C.controlling == src)
		C.stop_controlling()
	controlled_by = null
	update_movement_images()

/mob/living/proc/add_control(var/key)
	var/client/C = directory["[key]"]
	if(!C || (key in allowed_control))
		return
	C << "Control of \the [src] was added to you."
	allowed_control += key

/mob/living/proc/remove_control(var/key)
	var/client/C = directory["[key]"]
	if(!C || !(key in allowed_control))
		return
	C << "Control of \the [src] was removed from you."
	if(C.controlling == src)
		src.stop_control()
	allowed_control -= key

/mob/living/proc/toggle_control(var/key)
	if(key in allowed_control)
		remove_control(key)
	else
		add_control(key)

////////////////////
// COMBAT ACTIONS //
////////////////////

//checks for the combat flag COMBAT_FLAG_DONE. If it finds it, return 0. If it doesn't, apply it and return 1.
/mob/living/proc/action_precheck(var/change = 1)
	if(combat_state == COMBAT_OFF)
		return 1
	if(!(combat_flags & COMBAT_FLAG_ACTION))
		return 0
	if(stunned)
		return 0
	if(change)
		combat_flags ^= COMBAT_FLAG_ACTION
	return 1

//Gets called whenever a mob uses their turn to aim.
/mob/living/proc/aim()
	if(!action_precheck())
		return
	//put in aim status effect here.

	get_combat_movement(override = 1)
	world << "[get_inline()] aims!"

//Gets called whenever a mob uses their turn to attack. Still lets them defend though (from attacks n shit)
/mob/living/proc/attack()
	if(!action_precheck())
		return
	get_combat_movement(override = 1)
	toggle_attack(1)
	world << "[get_inline()] attacks!"
	return

/mob/living/proc/move_and_attack()
	if(!action_precheck())
		return
	get_combat_movement()
	toggle_attack(1)
	combat_flags |= COMBAT_FLAG_MOVE_ATTACK
	world << "[get_inline()] moves and attacks!"

//Gets called whenever a mob uses their turn to attack exclusively.
/mob/living/proc/all_out_attack()
	if(!action_precheck())
		return
	/*Can do:
	MELEE
	Determined (+4 to hit)
	Double: 2 hits (either from 2 weapons or 1 if it doesn't need readying)
	Feint: Make a feint attack and THEN attack
	Strong: Get +2 damage or +1 per dice, whichever is better. Only applies to melee attacks.

	RANGED
	Determined +1 to hit
	Suppression Fire, spray an area with fire. Must have a weapon with a RoF of 5+
	*/
	get_combat_movement(multiplier= 0.5,straight = 1)
	toggle_attack(1)
	world << "[get_inline()] all-out-attacks!"

//Gets called whenever a mob uses their turn to defend exclusively.
/mob/living/proc/all_out_defense(var/type = "Dodge")
	if(!action_precheck())
		return
	/*
	Can Do:
	Increased Defense: +2 to one of the following: Dodge, Parry, or Block.
	Double Defense: Apply two different active defenses against the same attack. (Basically 2 changes of dodging an attack)

	If Increased Dodge, move up to half Move.
	Otherwise move a step.
	*/
	switch(type)
		if("Dodge")
			get_combat_movement(multiplier = 0.5)
			add_status_effect(/status_effect/duration/stat/alloutdodge)
		else
			get_combat_movement(override = 1)

	world << "[get_inline()] all-out-defends!"




//Gets called wheneter a mob uses their turn to change their posture.
/mob/living/proc/change_posture(var/new_posture)
	if(new_posture == posture)
		return
	if(!action_precheck(0))
		return
	if((posture == POSTURE_KNEEL || new_posture == POSTURE_KNEEL) && (posture == POSTURE_STAND || new_posture == POSTURE_STAND))
		//Only costs 1 step. So give them a debuff here that subtracts 1 step.
		add_status_effect(/status_effect/duration/stat/basic_move/change_posture)
	else
		action_precheck() //we use this function because we don't want to switch it on accidently.
		//Costs a full action.
	posture = new_posture
	world << "[get_inline()] changes its posture to [posture]!"

//Gets called whenever a mob uses their turn to concentrate on something.
/mob/living/proc/concentrate()
	if(!action_precheck())
		return

	world << "[get_inline()] concentrates!"

//Gets called whenever a mob decides to evaluate a target/situation.
/mob/living/proc/evaluate()
	if(!action_precheck())
		return
	//Gives +1 to Attack, Feint, All-Out-Attack, or Move-And-Attack. Can be stacked 3 times. Wears off after a turn.

	world << "[get_inline()] evaluates a target!"

//etc etc, feint
/mob/living/proc/feint()
	if(!action_precheck())
		return

	world << "[get_inline()] feints!"

//etc etc, move.
/mob/living/proc/move_only()
	if(!action_precheck())
		return
	get_combat_movement()
	world << "[get_inline()] moves!"

/mob/living/proc/say(var/text)
	world << "[get_inline()] says, \"[text]\""