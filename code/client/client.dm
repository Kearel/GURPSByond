/client
	var/datum/admins/holder
	var/mob/living/controlling = null //who we are currently controlling
	var/datum/build_mode/build = null
	var/gamemaster = 0 //a simple bitcheck to see if someone is gamemaster or not.
	var/image/controlling_image = null

/client/New()
	..()
	clients += src
	directory[ckey] = src
	holder = admin_datums[ckey]
	if(holder)
		admins += src
		holder.owner = src
		add_admin_verbs()


/client/Del()
	if(holder)
		holder.owner = null
		admins -= src
	directory -= ckey
	clients -= src
	return ..()

/client/AllowUpload(var/filename, var/filelength)
	if(filelength > 5000000)
		src << "[filename] is too large (max 5mb)"
		return 0
	return 1

/client/Topic(href, href_list, hsrc)
	if(!usr || usr != mob)
		return

	switch(href_list["_src_"])
		if("vars")		return view_var_Topic(href,href_list,hsrc)
	..()