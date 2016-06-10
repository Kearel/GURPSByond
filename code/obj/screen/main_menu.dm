/var/obj/screen/main_menu/lobby_screen = new()

/obj/screen/main_menu
	name = "main_menu"
	icon = 'icons/screen/main_menu.dmi'
	icon_state = "menu"
	screen_loc = "WEST,SOUTH"


/obj/screen/New()
	..()
	name = "[config.world_name]"