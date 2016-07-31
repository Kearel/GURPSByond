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