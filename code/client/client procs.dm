/client/proc/start_controlling(var/mob/living/L)
	if(controlling)
		stop_controlling()
	controlling = L
	controlling_image = image(icon = 'icons/effects/overlays.dmi',icon_state = "controlled", loc = controlling)
	src.images += controlling_image

/client/proc/stop_controlling(var/mob/living/L)
	if(!controlling)
		return
	controlling = null
	src.images -= controlling_image
	controlling_image = null

/client/proc/add_points(var/amount)
	global_points += amount
	src << "You have been granted <b>[amount] global points</b>.<br>You can transfer these to your characters using the character sheet verb."

/client/verb/say(var/message as text)
	var/color = "#ffffff"
	if(holder)
		color = "#990000"
	else if(gamemaster)
		color = "#009933"
	world << "<font color='[color]'><b>[key]</b> says, \"[message]\"</font>"

/client/verb/upload_image_file()
	set name = "Upload Image"
	set desc = "Upload an image to the server."
	set category = "Preferences"

	var/icon/file = input(src,"Upload an Image", "Image Uploading") as null|icon
	if(!file)
		return

	var/name = input(src, "What should its name be?", "Image Name") as null|text
	if(!name)
		return

	icon_files[name] = file
	src << "Image uploaded!"