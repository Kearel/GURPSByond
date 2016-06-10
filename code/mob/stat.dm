/mob/Stat()
	..()
	if(client.holder)
		if(statpanel("Status"))
			stat("Location:", "([x], [y], [z]) [loc]")
			stat("CPU:","[world.cpu]")
			stat("Instances:","[world.contents.len]")
		if(statpanel("Processes"))
			if(processScheduler)
				processScheduler.statProcesses()
