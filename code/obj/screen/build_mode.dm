/obj/screen/button/find_by_type
	name = "find by type"
	button_state = "type"

/obj/screen/button/Click()
	var/client/C
	var/mob/M = usr
	if(istype(M))
		C = M.client
	else if(istype(usr,/client))
		C = usr
	if(!C)
		return
	if(!C.build)
		return

	var/type = text2path(input("Please type in the path of the object you wish to target.") as text)
	if(!ispath(type))
		usr << "\red That path does not exist."
		return

	C.build.selected_type = type
	usr << "Type set to: [type]"