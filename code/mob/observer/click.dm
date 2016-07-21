/mob/observer/ClickOn(var/atom/a, params)
	var/list/pa = params2list(params)
	if(!client) //Better to just check it here, honestly.
		return
	if(client.build)
		client.build.Click(a,src,params)
		return
	if(client.controlling)
		if(pa["ctrl"])
			if(a == client.controlling)
				client.controlling.stop_control()
				src << "You stop controlling \the [a]."
				return
		client.controlling.order(a, src)
		return
	if(istype(a, /mob/living))
		var/mob/living/L = a
		if(pa["ctrl"])
			client << "You add a status effect to \the [L]."
			L.add_status_effect(/status_effect/duration/stat/strength/bonus)
			return
		if(L.can_control(client.ckey))
			if(client.controlling)
				client.controlling.stop_control()
			L.take_control(client.ckey)
			client << "You take control of \the [L]."
			return
	return ..()