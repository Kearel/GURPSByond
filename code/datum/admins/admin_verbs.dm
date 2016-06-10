var/list/admin_verbs_admin = list(/client/proc/debug_variables, /client/proc/callproc, /client/proc/callproc_target, /client/proc/set_gamemaster)
var/list/admin_verbs_ban = list()
var/list/admin_verbs_spawn = list()
var/list/gamemaster_verbs = list(/client/proc/debug_variables, /client/proc/callproc, /client/proc/callproc_target,
								/client/proc/toggle_buildmode, /client/proc/toggle_combat_verb, /client/proc/toggle_visibility,
								/client/proc/toggle_allow_darkness, /client/proc/edit_mob_permissions)


/client/proc/add_admin_verbs()
	if(holder)
		if(holder.rights & R_BAN)
			verbs |= admin_verbs_ban
		if(holder.rights & R_ADMIN)
			verbs |= admin_verbs_admin
		if(holder.rights & R_SPAWN)
			verbs |= admin_verbs_spawn
		if(holder.rights & R_GAMEMASTER || gamemaster)
			verbs |= gamemaster_verbs
	return

/client/proc/remove_admin_verbs()
	verbs -= admin_verbs_admin + admin_verbs_ban + admin_verbs_spawn + gamemaster_verbs

/client/proc/refresh_admin_verbs()
	remove_admin_verbs()
	add_admin_verbs()