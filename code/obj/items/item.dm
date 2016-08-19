/obj/item
	var/value = 0
	var/weight = 0
	var/page_number
	var/num = 1
	var/list/attack_data

/obj/item/New()
	..()
	if(attack_data)
		var/list/new_data = list()
		for(var/data in attack_data)
			var/list/the_list = params2list(data)
			var/type = attack_data[data]
			new_data += new type(the_list)
		attack_data.Cut()
		attack_data = new_data

/obj/item/proc/can_stack(var/atom/a)
	return istype(a,type)

/obj/item/proc/get_weight()
	return get_singular_weight() * num

/obj/item/proc/get_singular_weight()
	return weight