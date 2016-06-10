/mob/living/proc/build_overlays()
	overlays.Cut()

	if(combat_flags & COMBAT_FLAG_TURN)
		overlays += image(icon = 'icons/effects/overlays.dmi',icon_state = "current_turn", layer = MOB_OVERLAY_BEHIND)

	return