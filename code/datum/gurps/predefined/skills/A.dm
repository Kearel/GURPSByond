//These files go alphabetically.
/datum/skill/accounting
	name = "Accounting"
	desc = "This is the ability to keep books of \
account, to examine the condition of a \
business, etc. A successful Accounting \
roll (requires at least two hours of \
study, and possibly months to audit a \
large corporation) can tell you whether \
financial records are correct, and possi- \
bly reveal evidence of forgery, tamper- \
ing, and similar criminal activity."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "174"

	defaults = list("Intelligence" = -6, "Finance" = -4,
					"Mathematics (Statistics)" = -5, "Merchant" = -5)

/datum/skill/acrobatics
	name = "Acrobatics"
	desc = "This is the ability to perform gym- \
nastic stunts, roll, take falls, etc. This \
can be handy on an adventure, as \
tightrope walking, human pyramids, \
and trapeze swinging all have useful \
applications. Each trick requires a sep- \
arate skill roll, at whatever penalties the \
GM sees fit. If you are performing \
stunts on a moving vehicle or mount, \
roll against the lower of Acrobatics and \
the appropriate Driving or Riding skill."
	stat = "Dexterity"
	difficulty = SKILL_HARD
	page_number = "174"

	defaults = list("Aerobatics" = -4, "Aquabatics" = -4)

/datum/skill/acting
	name = "Acting"
	desc = "This is the ability to counterfeit \
moods, emotions, and voices, and to lie \
convincingly over a period of time. A \
successful Acting roll lets you pretend \
to feel something that you do not. The \
GM may also require an Acting roll \
whenever you try to fool someone, play \
dead in combat, etc."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "174"

	defaults = list("Intelligence" = -5, "Performance" = -2, "Public Speaking" = -5)

/datum/skill/administration
	name = "Administration"
	desc = "This is the skill of running a large\
organization. It is often a prerequisite\
for high Rank (p. 29). A successful\
Administration roll gives you a +2 reac-\
tion bonus when dealing with a\
bureaucrat, and allows you to predict\
the best way to go about dealing with a\
bureaucracy."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "174"

	defaults = list("Intelligence" = -5, "Merchant" = -3)

/datum/skill/aerobatics
	name = "Aerobatics"
	desc = "The ability to execute\
tight turns, loops, power dives, etc. in\
flight. You must be able to fly to learn\
this skill - although how you fly (magic,\
wings, jet pack, etc.) is irrelevant.\
Natural fliers might find flight to be as\
effortless as humans find walking, but\
they must still learn Aerobatics in order\
to engage in complex acrobatics. Add\
+2 to skill if you have 3D Spatial Sense\
(p. 34)."
	stat = "Dexterity"
	difficulty = SKILL_HARD
	page_number = "174"

	defaults = list("Acrobatics" = -4, "Aquabatics" = -4)

/datum/skill/airshipman
	name = "Airshipman"
	desc = "The skill of han-\
dling ballast, gas valves, mooring\
lines, etc. on a blimp, zeppelin, or\
other large airship. Also see Crewman (p. 185)\
for more information."
	stat = "Intelligence"
	difficulty = SKILL_EASY
	page_number = "174"

	defaults = list("Intelligence" = -4)

/datum/skill/alchemy
	name = "Alchemy"
	desc = "This is the study of magical trans-\
formations and transmutations. In a\
magical game world, an alchemist\
would be able to identify concoctions\
with magical effects (\"elixirs\"), such as\
love potions and healing unguents,\
and prepare them from suitable ingre-\
dients. This is a mechanical process,\
using the mana inherent in certain\
things; therefore, those without\
Magery can learn and use Alchemy,\
and Magery confers no benefit."
	stat = "Intelligence"
	difficulty = SKILL_VERY_HARD
	page_number = "174"

/datum/skill/animal_handling
	name = "Animal Handling"
	desc = "This is the ability to train and work\
with animals. You must specialize in a\
category of animals - the more intelli-\
gent the animals, the narrower the\
category. Examples of interest to\
adventurers: Big Cats (jaguars, lions,\
tigers, etc.), Dogs, Equines (horses\
and donkeys), and Raptors (eagles,\
falcons, and hawks). The default\
between specialties is -2 within the\
same order (e.g., Dogs to Big Cats), -4\
across orders (e.g., Dogs to Equines),\
and -6 for larger differences (e.g., Dogs\
to Raptors)."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "175"

	defaults = list("Intelligence" = -5)
	specializations = list("Big Cats", "Dogs", "Equines", "Raptors", "Editable")

/datum/skill/anthropology
	name = "Anthropology"
	desc = "This is the science of evolution and\
culture. An anthropologist is knowl-\
edgeable in the ways of primitive\
(and not-so-primitive) societies. An\
Anthropology roll might explain,\
or even predict, unusual rituals and\
folk customs. This skill requires\
specialization by species (if left\
unspecified, assume the anthropolo-\
gist’s own species). Specialties usually\
default to one another at -2 to -5,\
although there may be no default for\
completely alien species."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "175"

	defaults = list("Intelligence" = -6, "Paleontology (Paleoanthropology)" = -2, "Sociology" = -3)
	specializations = list("Human", "Editable")

/datum/skill/aquabatics
	name = "Aquabatics"
	desc = "The ability to engage in\
underwater acrobatics. Prerequisites:\
Swimming, or the Amphibious advan-\
tage (p. 40) or the Aquatic disadvantage\
(p. 145)."
	stat = "Dexterity"
	difficulty = SKILL_HARD
	page_number = "176"

	prerequests = list("Swimming", "Amphibious", "Aquatic")
	defaults = list("Acrobatics" = -4, "Aerobatics" = -4)

/datum/skill/archaeology
	name = "Archaeology"
	desc = "This is the study of ancient civiliza-\
tions. An archaeologist is at home with\
excavations, old potsherds, inscrip-\
tions, etc. An Archaeology roll lets you\
answer questions about ancient histo-\
ry, or identify artifacts and dead lan-\
guages. It might even reveal informa-\
tion relating to the occult; e.g., Ancient\
Secrets and Things Man Was Not\
Meant To Know . . ."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "176"

	defaults = list("Intelligence" = -6)

/datum/skill/architecture
	name = "Architecture"
	desc = "This is the ability to design build-\
ings, and to deduce the design of build-\
ings from their function (and vice\
versa). A successful Architecture roll\
lets you learn things about a strange\
building, find a secret room or door, etc."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "176"

	defaults = list("Intelligence" = -5, "Engineer (Civil)" = -4)


/datum/skill/area_knowledge
	name = "Area Knowledge"
	desc = "This skill represents familiarity\
with the people, places, and politics of\
a given region. You usually have Area\
Knowledge only for the area you con-\
sider your \"home base,\" whether that’s\
a single farm or a solar system. If\
information about other areas is avail-\
able, the GM may allow you to learn\
additional Area Knowledge skills."
	stat = "Intelligence"
	difficulty = SKILL_EASY
	page_number = "176"

	//@TODO: IQ if you know the area /only/. Geography if the area is in the region specified
	defaults = list("Intelligence" = -4, "Geography (Regional)" = -3)
	specializations = list("editable")

/datum/skill/armoury
	name = "Armoury"
	desc = "This is the ability to build, modify,\
and repair a specific class of weapons\
or armor. (It does not include skill at\
design; for that, see Engineer, p. 190.)\
A successful roll lets you find a prob-\
lem, if it isn’t obvious; a second roll\
lets you repair it. Time required is up\
to the GM."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "178"

	//@TODO make it so you can set a default to having a specific default or something
	defaults = list("Intelligence" = -5, "Engineer (same)")
	specializations = list("Battlesuits", "Body Armor", "Force Shields", "Heavy Weapons", "Missile Weapons", "Small Arms", "Vehicular Armor")

/datum/skill/artillery
	name = "Artillery"
	desc = "This is the ability to build, modify,\
and repair a specific class of weapons\
or armor. (It does not include skill at\
design; for that, see Engineer, p. 190.)\
A successful roll lets you find a prob-\
lem, if it isn’t obvious; a second roll\
lets you repair it. Time required is up\
to the GM."
	stat = "Intelligence"
	difficulty = SKILL_AVERAGE
	page_number = "178"

	//@TODO make it so you can set a default to having a specific default or something
	defaults = list("Intelligence" = -5)
	specializations = list("Beams", "Bombs", "Cannon", "Catapult", "Guided Missile", "Torpedoes")

/datum/skill/artist
	name = "Artist"
	desc = "This skill represents talent at a\
visual art. A successful roll might let\
you create a recognizable likeness of a\
person or an object, or a work beauti-\
ful enough to sell (the GM should not\
allow a default roll for this use!). Time\
required is up to the GM"
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "179"

	defaults = list("Intelligence" = -6)
	specializations = list("Body Art", "Calligraphy", "Drawing" , "Illumination", "Illusion", "Interior Decorating","Painting", "Pottery", "Scene Design", "Sculpting", "Woodworking", "editable")

/datum/skill/astronomy
	name = "Astronomy"
	desc = "This is the study of stars and other\
extraplanetary objects. An astronomer\
could answer questions about the\
Sun, the planets of the solar system,\
etc. An amateur who can locate stars\
and use a telescope, but not perform\
involved calculations, has an optional\
specialty  (p. 169):  Astronomy\
(Observational). This specialty does\
not  require  Mathematics  as  a\
prerequisite."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "179"

	prerequests = list("Mathematics (Applied)")
	defaults = list("Intelligence" = -6)

/datum/skill/autohypnosis
	name = "Autohypnosis"
	desc = "This skill allows you to tap reserves\
of inner strength by entering a trance-\
like state. It requires a concentration\
period of (20 - skill) seconds, mini-\
mum one second. You cannot talk or\
move during the initiation of the\
trance state."
	stat = "Will"
	difficulty = SKILL_HARD
	page_number = "179"

	defaults = list("Meditation" = -4)

/datum/skill/axe_mace
	name = "Axe/Mace"
	desc = "Any short-\
or medium-length, one-handed impact\
weapon, such as an axe, hatchet,\
knobbed club, or pick."
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "179"

	defaults = list("Flail" = -4, "Two-Handed Axe/Mace" = -3, "Dexterity" = -5)