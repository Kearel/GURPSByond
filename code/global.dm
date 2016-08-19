var/global/list/spawn_locations = list()

var/list/living_mobs = list()
var/list/mob_list = list()
var/list/skills = list()
var/list/icon_files = list()

var/global/datum/turn_controller/turn_controller = new
var/global/combat_state = COMBAT_OFF


//somewhat global, yet not.
var/datum/configuration/config = null

var/list/admin_log     = list()

var/list/admins = list()
var/list/directory = list()							//list of all ckeys with associated client
var/list/clients = list() //list of all the clients

var/list/created_status_effects = list() //Name = vars

var/list/distance_penalties = list("3" = -1, "5" = -2, "7" = -3, "10" = -4)


var/list/strength_thrust_table = list("1d6-6",
									"1d6-5",
									"1d6-4",
									"1d6-3",
									"1d6-2",
									"1d6-1",
									"1d6",
									"1d6+1",
									"1d6+2",
									"2d6-1",
									"2d6",
									"2d6+1",
									"2d6+2",
									"3d6-1",
									"3d6",
									"3d6+1",
									"3d6+2",
									"4d6-1",
									"4d6",
									"4d6+1",
									"5d6",
									"5d6+2",
									"6d6",
									"7d6-1",
									"7d6+1",
									"8d6",
									"8d6+2",
									"9d6",
									"9d6+2",
									"10d6",
									"10d6+2",
									"11d6")

var/list/strength_swing_table = list("1d6-5",
									"1d6-5",
									"1d6-4",
									"1d6-4",
									"1d6-3",
									"1d6-3",
									"1d6-2",
									"1d6-2",
									"1d6-1",
									"1d6",
									"1d6+1",
									"1d6+2",
									"2d6-1",
									"2d6",
									"2d6+1",
									"2d6+2",
									"3d6-1",
									"3d6",
									"3d6+1",
									"3d6+2",
									"4d6-1",
									"4d6",
									"4d6+1",
									"4d6+2",
									"5d6-1",
									"5d6",
									"5d6+1",
									"5d6+1",
									"5d6+2",
									"5d6+2",
									"6d6-1",
									"6d6-1",
									"6d6",
									"6d6",
									"6d6+1",
									"6d6+1",
									"6d6+2",
									"6d6+2",
									"7d6-1",
									"7d6-1",
									"7d6+1",
									"8d6-1",
									"8d6+1",
									"9d6",
									"9d6+2",
									"10d6",
									"10d6+2",
									"11d6",
									"11d6+2",
									"12d6",
									"12d6+2",
									"13d6")

var/list/encumberance_levels = list("None" = 1,"Light" = 2,"Medium" = 3,"Heavy" = 6, "X-Heavy" = 10)

var/list/global_resource_cache = list()

var/list/character_sheets = list() //So that they don't get GCd