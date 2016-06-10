/mob
	name = "Mob"
	desc = "This is definitely some kind of bug...."

/mob/New()
	..()
	mob_list += src

/mob/Destroy()
	mob_list -= src
	..()

/mob/proc/Life()
	return