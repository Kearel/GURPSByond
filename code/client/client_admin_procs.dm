/client/proc/set_gamemaster(var/mob/observer/O)
	set name = "Set GameMaster"
	set desc = "Toggles gamemaster on and off for a selected player."
	set category = "Admin"

	if(!istype(O))
		return

	if(!check_rights(R_ADMIN))
		return

	var/client/C = O.client
	if(!C)
		return
	if(C.gamemaster)
		C << "You've been relieved of GameMaster by [src.ckey]."
		O.vision_type = SEE_INVISIBLE_OBSERVER
		O.invisibility = INVISIBILITY_OBSERVER
	else
		C << "You have been made GameMaster by [src.ckey]."
		O.vision_type = SEE_INVISIBLE_GAMEMASTER
	C.gamemaster = !C.gamemaster
	C.refresh_admin_verbs()
	O.update_vision()
