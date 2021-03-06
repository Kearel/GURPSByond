/mob/living/proc/build_overlays()
	overlays.Cut()
	if(stat == DEAD)
		overlays += image(icon = 'icons/effects/overlays.dmi', icon_state = "death", layer = MOB_OVERLAY_OVER)
		return
	if(stat == DISABLED)
		overlays += image(icon = 'icons/effects/overlays.dmi', icon_state = "unconscious", layer = MOB_OVERLAY_OVER)


	if(combat_flags & COMBAT_FLAG_TURN)
		overlays += image(icon = 'icons/effects/overlays.dmi',icon_state = "current_turn", layer = MOB_OVERLAY_BEHIND)

	if(combat_flags & COMBAT_FLAG_ATTACK)
		overlays += image(icon = 'icons/effects/overlays.dmi', icon_state = "attack", layer = MOB_OVERLAY_BEHIND)
	return

/mob/living/Death()
	..()
	build_overlays()