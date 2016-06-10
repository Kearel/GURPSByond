/datum/turn_controller
	var/list/initiative_list //assoc array with the initiatives of all the people. (# = mob)
	var/current_mob = 0 //the index of the mob currently doing stuff.

/datum/turn_controller/proc/insert_mob(var/mob/living/L, var/value, var/forced = 0)
	for(var/i in 1 to initiative_list.len)
		var/num = text2num(initiative_list[i])
		if(num == value)
			var/who
			if(forced)
				who = 1
			else
				who = prob(50)//flip a coin
			var/mob/M
			if(who) //we go first
				var/mob/living/culled = initiative_list[initiative_list[i]]
				initiative_list["[value]"] = L
				M = culled
			else //they go first
				M = L
			insert_mob(M,value+1,1)
			return
		else if(num < value)
			initiative_list.Insert(i, "[value]")
			initiative_list["[value]"] = L
			return
	initiative_list["[value]"] = L //it goes in at the end
	return

//Does it in N time. Sucks but thats the way it works
/datum/turn_controller/proc/remove_mob(var/mob/living/L)
	if(!initiative_list || !initiative_list.len)
		return
	if(initiative_list.len == 1)
		initiative_list.Cut()
		return
	for(var/i in 1 to initiative_list.len)
		if(initiative_list[initiative_list[i]] == L)
			initiative_list[initiative_list[i]] = null
			initiative_list[i] = null
			initiative_list -= null
			return

/datum/turn_controller/proc/start_combat()
	initiative_list = list()
	for(var/M in living_mobs)
		var/mob/living/L = M
		L.PrepareCombat()
		insert_mob(L, L.get_attribute_level("Basic Move", 1))
	next_turn()

/datum/turn_controller/proc/end_combat()
	for(var/M in living_mobs)
		var/mob/living/L = M
		L.PrepareCombat()
	initiative_list.Cut()
	current_mob = 0

/datum/turn_controller/proc/next_turn()
	var/mob/living/L
	if(current_mob > 0)
		L = initiative_list[initiative_list[current_mob]]
		L.TurnEnd()
	current_mob++
	if(current_mob > initiative_list.len)
		current_mob = 1
	L = initiative_list[initiative_list[current_mob]]
	L.TurnStart()
	world << "<font size = '4'>Next Turn: <IMG CLASS=icon SRC=\ref[L.icon] ICONSTATE='[L.icon_state]' style='width:32px;height:32px;'> [L]</font>"

/datum/turn_controller/proc/get_current_mob()
	return initiative_list[initiative_list[current_mob]]