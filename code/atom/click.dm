/atom/Click(var/location, var/control, var/params)
	if(src)
		usr.ClickOn(src, params)

/atom/proc/ClickOn(var/atom/A, params)
	return