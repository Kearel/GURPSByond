/datum/stat_system
	var/list/items = list()
	var/encumberance = -1
	var/atom/movable/container = new

/datum/stat_system/proc/get_item(var/num)
	if(num < 1 || num > items.len)
		return null
	return items[num]

/datum/stat_system/proc/get_encumberance()
	if(encumberance < 0)
		encumberance = 0
		for(var/i in items)
			world << encumberance
			var/obj/item/I = i
			encumberance += I.get_weight()
			world << "([encumberance])"
	return encumberance

/datum/stat_system/proc/get_encumberance_level()
	var/lift = calculate_basic_lift(get_attribute_level("Strength",1))
	var/enc = get_encumberance()
	for(var/i in 1 to encumberance_levels.len)
		var/max = encumberance_levels[encumberance_levels[i]] * lift
		if(enc <= max)
			return i
	return 6

/datum/stat_system/proc/add_item(var/obj/item/I)
	encumberance = get_encumberance() + I.get_weight()
	for(var/i in items)
		var/obj/item/O = i
		if(O.can_stack(I))
			O.num++
			qdel(I)
			return 1
	items += I
	I.num = 1
	I.forceMove(container)
	return 1

/datum/stat_system/proc/remove_item(var/num, var/target_turf)
	var/obj/item/I = items[num]
	encumberance = get_encumberance() - I.get_singular_weight()
	I.num -= 1

	if(!I.num)
		items -= I
		I.forceMove(target_turf)
	else
		var/type = I.type
		new type(target_turf)