/mob/observer/ClickOn(var/atom/a, params)
	if(!client) //Better to just check it here, honestly.
		return
	if(client.build)
		client.build.Click(a,src,params)
		return
	if(istype(a, /obj))
		qdel(a)
		return
	if(client.controlling)
		if(a == client.controlling)
			client.controlling.stop_control()
			src << "You stop controlling \the [a]."
			return
		client.controlling.order(a, src)
		return
	if(istype(a, /mob/living))
		var/mob/living/L = a
		if(L.can_control(client.ckey))
			if(client.controlling)
				client.controlling.stop_control()
			L.take_control(client.ckey)
			client << "You take control of \the [L]."
			return
	return ..()