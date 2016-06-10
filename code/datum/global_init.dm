var/global/datum/global_init/init = new

/datum/global_init/New()
	load_config()
	qdel(src)

/datum/global_init/Destroy()
	return 1