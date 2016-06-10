
//Creates a new turf
/turf/proc/ChangeTurf(var/turf/N, var/force_lighting_update = 0)
	if (!N)
		return

	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/list/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay

	new N( locate(src.x, src.y, src.z) )

	lighting_overlay = old_lighting_overlay
	affecting_lights = old_affecting_lights
	if((old_opacity != opacity) || (dynamic_lighting != old_dynamic_lighting) || force_lighting_update)
		reconsider_lights()
	if(dynamic_lighting != old_dynamic_lighting)
		if(dynamic_lighting)
			lighting_build_overlays()
		else
			lighting_clear_overlays()
