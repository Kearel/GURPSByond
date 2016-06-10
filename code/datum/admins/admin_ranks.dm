var/list/admin_ranks = list()								//list of all ranks with associated rights

//load our rank - > rights associations
/proc/load_admin_ranks()
	admin_ranks.Cut()

	var/previous_rights = 0

	//load text from file
	var/list/Lines = file2list("config/admin_ranks.txt")

	//process each line seperately
	for(var/line in Lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		var/list/List = splittext(line,"+")
		if(!List.len)					continue

		var/rank = ckeyEx(List[1])
		switch(rank)
			if(null,"")		continue
			if("Removed")	continue				//Reserved

		var/rights = 0
		for(var/i=2, i<=List.len, i++)
			switch(ckey(List[i]))
				if("@","prev")					rights |= previous_rights
				if("admin")						rights |= R_ADMIN
				if("ban")						rights |= R_BAN
				if("varedit")					rights |= R_VAREDIT
				if("everything","host","all")	rights |= (R_ADMIN | R_BAN | R_VAREDIT | R_SPAWN | R_GAMEMASTER)
				if("spawn","create")			rights |= R_SPAWN
				if("gamemaster")				rights |= R_GAMEMASTER

		admin_ranks[rank] = rights
		previous_rights = rights



/hook/startup/proc/loadAdmins()
	load_admins()
	return 1

/proc/load_admins()
	//clear the datums references
	admin_datums.Cut()
	for(var/client/C in admins)
		C.remove_admin_verbs()
		C.holder = null
	admins.Cut()

	load_admin_ranks()

	//load text from file
	var/list/Lines = file2list("config/admins.txt")

	//process each line seperately
	for(var/line in Lines)
		if(!length(line))				continue
		if(copytext(line,1,2) == "#")	continue

		//Split the line at every "-"
		var/list/List = splittext(line, "-")
		if(!List.len)					continue

		//ckey is before the first "-"
		var/ckey = ckey(List[1])
		if(!ckey)						continue

		//rank follows the first "-"
		var/rank = ""
		if(List.len >= 2)
			rank = ckeyEx(List[2])

		//load permissions associated with this rank
		var/rights = admin_ranks[rank]

		//create the admin datum and store it for later use
		var/datum/admins/D = new /datum/admins(rank, rights, ckey)

		//find the client for a ckey if they are connected and associate them with the new admin datum
		D.associate(directory[ckey])