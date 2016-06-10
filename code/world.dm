world
	view = "15x15"

	mob = /mob/new_player
	turf = /turf
	area = /area
	cache_lifespan = 0

world/New()
	callHook("startup")
	processScheduler = new
	spawn(1)
		processScheduler.setup()
		processScheduler.start()
	return