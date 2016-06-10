/obj/landmark
	name = "landmark"
	desc = "This is a landmark representing a spawn location. Or something similar."
	icon = 'icons/obj/landmark.dmi'
	icon_state = "x2"
	invisibility = 101
	var/delete_this


/obj/landmark/New()
	switch(name)
		if("player spawn")
			if(!spawn_locations)
				spawn_locations = list()
			spawn_locations += loc
			delete_this = 1

	..()
	if(delete_this)
		del(src)