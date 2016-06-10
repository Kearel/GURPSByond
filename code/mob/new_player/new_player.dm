/mob/new_player
	name = "new player"
	desc = "If you're reading this, something has gone wrong."
	var/client/my_client

/mob/new_player/Login()
	loc = null
	src << "<h1><b>[config.world_name]</b></h1>"
	src << "[config.greet_text]"
	if(client)
		my_client = client
		client.screen += lobby_screen
	main_menu()
	..()

/mob/new_player/Logout()
	if(my_client)
		my_client.screen -= lobby_screen
		my_client = null
	key = null
	qdel(src)
	..()

/mob/new_player/proc/main_menu()
	var/dat = "<center><h3>Main Menu</h3></center><hr>"
	dat += "<center><a href='byond://?src=\ref[src];create=1'>Create/Load a Character</a></center><br>"
	dat += "<center><a href='byond://?src=\ref[src];play=1'>Join Game</a></center><br>"
	dat += "<center><a href='byond://?src=\ref[src];who=1'>Rules</a></center><br>"
	dat += "<center><a href='byond://?src=\ref[src];settings=1'>Game Settings</a></center><br>"
	src << browse(dat,"window=mainmenu;size=300x300;can_close=0")

/mob/new_player/Topic(href, href_list)
	if(href_list["create"])
		src << "You are creating/loading a character."
	if(href_list["play"])
		src << browse(null,"window=mainmenu")
		var/mob/M = new /mob/observer()
		var/turf/T = pick(spawn_locations)
		if(T)
			M.loc = T
		M.key = key
	if(href_list["who"])
		src << "You want to know who is playing."
	if(href_list["settings"])
		src << "You want to change the game settings."