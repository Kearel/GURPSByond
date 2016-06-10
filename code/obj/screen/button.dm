/obj/screen/button
	name = "button"
	icon = 'icons/screen/buttons.dmi'
	icon_state = "blank"
	var/button_state

/obj/screen/button/New()
	..()
	update_icon()

/obj/screen/button/update_icon()
	overlays.Cut()
	if(button_state)
		overlays += image(icon = src.icon, icon_state = button_state)

/obj/screen/button/Click()
	usr << "You clicked me!"
	return