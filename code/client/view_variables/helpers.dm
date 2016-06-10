
// Keep these two together, they *must* be defined on both
// If /client ever becomes /datum/client or similar, they can be merged
/client/proc/get_view_variables_header()
	return "<b>[src]</b>"
/datum/proc/get_view_variables_header()
	return "<b>[src]</b>"

/atom/get_view_variables_header()
	return {"
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=name'><b>[src]</b></a>
		<br><font size='1'>
		<a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=left'><<</a>
		<a href='?_src_=vars;datumedit=\ref[src];varnameedit=dir'>[dir2text(dir)]</a>
		<a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=right'>>></a>
		</font>
		"}

/mob/living/get_view_variables_header()
	return {"
		<a href='?_src_=vars;rename=\ref[src]'><b>[src]</b></a><font size='1'>
		<br><a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=left'><<</a> <a href='?_src_=vars;datumedit=\ref[src];varnameedit=dir'>[dir2text(dir)]</a> <a href='?_src_=vars;rotatedatum=\ref[src];rotatedir=right'>>></a>
		<br><a href='?_src_=vars;datumedit=\ref[src];varnameedit=ckey'>[ckey ? ckey : "No ckey"]</a>
		<br>
		PUT DAMAGE HERE
		</font>
		"}

// Same for these as for get_view_variables_header() above
/client/proc/get_view_variables_options()
	return ""
/datum/proc/get_view_variables_options()
	return ""

/mob/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;mob_player_panel=\ref[src]'>Show player panel</option>
		<option>---</option>
		<option value='?_src_=vars;godmode=\ref[src]'>Toggle Godmode</option>
		<option value='?_src_=vars;build_mode=\ref[src]'>Toggle Build Mode</option>

		<option value='?_src_=vars;direct_control=\ref[src]'>Assume Direct Control</option>
		<option value='?_src_=vars;drop_everything=\ref[src]'>Drop Everything</option>

		<option value='?_src_=vars;addlanguage=\ref[src]'>Add Language</option>
		<option value='?_src_=vars;remlanguage=\ref[src]'>Remove Language</option>
		<option value='?_src_=vars;addorgan=\ref[src]'>Add Organ</option>
		<option value='?_src_=vars;remorgan=\ref[src]'>Remove Organ</option>

		<option value='?_src_=vars;addverb=\ref[src]'>Add Verb</option>
		<option value='?_src_=vars;remverb=\ref[src]'>Remove Verb</option>
		"}

/obj/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;delall=\ref[src]'>Delete all of type</option>
		<option value='?_src_=vars;explode=\ref[src]'>Trigger explosion</option>
		<option value='?_src_=vars;emp=\ref[src]'>Trigger EM pulse</option>
		"}

/turf/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;explode=\ref[src]'>Trigger explosion</option>
		<option value='?_src_=vars;emp=\ref[src]'>Trigger EM pulse</option>
		"}
