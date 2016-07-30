/datum/stat/attribute/strength
	name = "Strength"
	desc = "Lifting, punching, and all things in between."

/datum/stat/attribute/dexterity
	name = "Dexterity"
	desc = "Being fast and nimble."

/datum/stat/attribute/intelligence
	name = "Intelligence"
	desc = "Knowing things, and knowing how to figure out things."

/datum/stat/attribute/health
	name = "Health"
	desc = "Living through stuff. Not dying."

/datum/stat/attribute/tiny/hp
	name = "HP"
	desc = "Physical health values. You lose this, you will die. Probaby."
	whole_numbers_only = 1

/datum/stat/attribute/tiny/fp
	name = "FP"
	desc = "Fatigue. Don't lose this or you'll end up unconscious, or worse!"
	whole_numbers_only = 1

/datum/stat/attribute/large/basic_speed
	name = "Basic Speed"
	desc = "This tells you how fast your character is."
	base_level_mult = 0.5
	bonuses_from = list("Dexterity" = 0.25)

/datum/stat/attribute/large/basic_move
	name = "Basic Move"
	desc = "This tells you how far you can move per turn."
	base_level_mult = 0
	bonuses_from = list("Basic Speed" = 1)
	whole_numbers_only = 1

/datum/stat/dodge
	name = "Dodge"
	desc = "This is how well you can dodge an attack."
	base_level = 3
	base_level_mult = 0.3
	bonuses_from = list("Basic Speed" = 1)
	whole_numbers_only = 1
	can_level = 0