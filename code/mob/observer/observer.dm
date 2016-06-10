/mob/observer
	name = "observer"
	desc = "A ghost! How spoooky!"

	icon = 'icons/mob/basic.dmi'
	icon_state = "ghost"

	invisibility = INVISIBILITY_OBSERVER
	sight = SEE_TURFS|SEE_MOBS|SEE_OBJS|SEE_SELF
	density = 0
	alpha = 125

	var/see_darkness = 1
	var/vision_type = SEE_INVISIBLE_OBSERVER

/mob/observer/New()
	..()
	see_invisible = vision_type

/mob/observer/Login()
	..()
	name = ckey

/mob/observer/proc/update_vision()
	see_invisible = (see_darkness ? vision_type : SEE_INVISIBLE_NOLIGHTING)

