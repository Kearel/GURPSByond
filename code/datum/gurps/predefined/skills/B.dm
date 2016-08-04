/datum/skill/battlesuit
	name = "Battlesuit"
	desc = "All kinds of powered\
battle armor and exoskeletons. Battle\
armor and exoskeletons are similar\
but not identical. If you only have\
experience with one, you are at -2 to\
operate the other until you gain\
familiarity (see Familiarity, p. 169)."
	stat= "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "179"

	defaults = list("Dexterity" = -5, "NBC Suit" = -2, "Vacc Suit" = -2)

/datum/skill/beam_weapons
	name = "Beam Weapons"
	desc = "This is the ability to use beam\
small arms. You must specialize by\
weapon type."
	stat = "Dexterity"
	difficulty = SKILL_EASY

	defaults = list("Dexterity" = -4)
	specializations = list("Pistol", "Projector", "Rifle") //@TODO default amongst one another at -4, Pistol/Rifle gun specs also do for the same spec for beam




/datum/skill/brawling
	name = "Brawling"
	desc = "This is the skill of \"unscientific\" \
unarmed  combat.  Roll  against \
Brawling to hit with a punch, or \
Brawling-2 to hit with a kick. \
Brawling can also replace DX when \
you attack with teeth, claws, horns, or \
other \"natural weapons.\""
	stat = "Dexterity"
	difficulty = SKILL_EASY