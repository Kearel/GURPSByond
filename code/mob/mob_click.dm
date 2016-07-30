/mob/ClickOn(var/location, var/params)
	if(client && client.build)
		client.build.Click(location,params)
		return
	..()