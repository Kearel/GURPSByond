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
	page_number = "179"

	defaults = list("Dexterity" = -4, "Beam Weapons" = -4, "Beam Weapons" = -4, "Beam Weapons" = -4)
	defaults_spec = list("2" = "Pistol", "3" = "Projector", "4" = "Rifle")
	specializations = list("Pistol", "Projector", "Rifle") //@TODO default amongst one another at -4, Pistol/Rifle gun specs also do for the same spec for beam

/datum/skill/bicycling
	name = "Bicycling"
	desc = "This is the ability to ride a bicycle\
long distances, at high speeds, in ral-\
lies, etc. Roll at +4 if all you want to do\
is struggle along without falling off.\
An IQ-based Bicycling roll allows you\
to make simple repairs, assuming\
tools and parts are available"
	stat = "Dexterity"
	difficulty = SKILL_EASY
	page_number = "180"

	defaults = list("Dexterity" = -4, "Driving" = -4)
	defaults_spec = list("2" = "Motorcycle")

/datum/skill/bioengineering
	name = "Bioengineering"
	desc = "This is the ability to engineer living\
organisms with specific characteris-\
tics, or to create biotechnological\
products. You must specialize:\
Cloning: The creation and growth\
of clones.\
Genetic Engineering: The manipu-\
lation and modification of genes.\
Tissue Engineering: The manufac-\
ture of organs and tissues.\
These specialties default to each\
other at -4."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "180"

	defaults = list("Biology" = -5)

/datum/skill/biology //@TODO let choose planet
	name = "Biology"
	desc = "This is the scientific study of the\
structure, behavior, and habitats of liv-\
ing organisms. You must specialize in\
the life of a particular planet type (see\
box). If you do not specify a planet\
type, your native planet type is\
assumed. The IQ default applies only\
to the planet type you grew up on. The\
default between different planet-type\
specialties is -4."
	stat = "Intelligence"
	difficulty = SKILL_VERY_HARD
	page_number = "180"

	defaults = list("Intelligence" = -6, "Naturalist" = -6)

/datum/skill/blind_fighting //@TODO do specialized stuff
	name = "Blind Fighting"
	desc = "You have learned to fight blindfold-\
ed or in absolute darkness. As a result,\
you can \"sense\" your targets without\
having to see them.\
This skill enables you to use senses\
other than vision - mainly hearing, but\
also touch and even smell -	 to pinpoint\
exactly where your opponents are. A\
successful roll allows one melee attack\
or active defense without any penalties\
for lighting (even total darkness),\
blindness (temporary or permanent),\
or an invisible foe. However, attacks\
made in total darkness, while blind, or\
against invisible enemies have an extra\
-2 to target specific hit locations."
	stat = "Perception"
	difficulty = SKILL_VERY_HARD
	page_number = "180"

	prerequests = list("Trained By A Master", "Weapon Master")
	prerequest_mode = SKILL_REQUIRE_ONE

/datum/skill/blowpipe //@TODO do +2 bonus thing
	name = "Blowpipe"
	desc = "This is the ability to use a blow-\
pipe. You can use this weapon to\
shoot small, usually poisoned, darts.\
You can also use it to blow powders at\
targets within one yard. Treat this as a\
melee attack, not as a ranged attack.\
Such attacks are always at +2 to hit."
	stat = "Dexterity"
	difficulty = SKILL_HARD
	page_number = "180"

	defaults = list("Dexterity" = -6)

/datum/skill/boating
	name = "Boating"
	desc = "This is the ability to handle a spe-\
cific type of small watercraft. For large\
vessels that require multiple crewmen\
on a \"bridge,\" use Seamanship (see\
Crewman, p. 185) and Shiphandling\
(p. 220).\
Make a roll to get underway, to\
dock, and whenever you encounter a\
hazard. If using this skill at default,\
also roll when you first enter the boat\
- to avoid falling in the water!"
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "180"

	defaults = list("Dexterity" = -5, "Intelligence" = -5)
	specializations = list("Large Powerboat", "Motorboat", "Sailboat", "Unpowered")

/datum/skill/body_control
	name = "Body Control"
	desc = "This ability lets you affect involun-\
tary bodily functions such as heart\
rate, blood flow, and digestion. One\
use of this skill is to enter a deathlike\
trance, during which only those who\
can win a Quick Contest of Diagnosis\
vs. your Body Control skill even real-\
ize that you are alive. This requires (30\
- skill) seconds of concentration, min-\
imum one second.\
You can also use this skill to flush\
poisons from your body. To do so, you\
must first roll against Poisons (or\
Alchemy, Pharmacy, etc., as appropri-\
ate) to identify the poison. You cannot\
attempt this roll until you know you\
have been poisoned. In most cases,\
you only discover this when the first\
symptoms show! A successful Body\
Control roll - adjusted by any modifi-\
er to the HT roll to resist the poison -\
flushes the poison in 1d hours, after\
which it has no further effect.\
Finally, you may use the higher of\
this skill and basic HT to resist any\
Affliction, magic spell, or psionic\
attack that is normally resisted by HT."
	stat = "Health"
	difficulty = SKILL_VERY_HARD
	page_number = "181"

	prerequests = list("Trained By A Master", "Breath Control", "Meditation")

/datum/skill/body_language
	name = "Body Language"
	desc = "This is the ability to interpret a\
person’s facial expressions and body\
posture in order to gauge his feelings.\
You can use it like the Empathy\
advantage (p. 51) or Detect Lies skill\
(p. 187), but only on a subject you can\
see. You can also use it to get a rough\
idea of what a party member is doing\
or about to do in a situation where he\
cannot communicate with you direct-\
ly (for instance, when using Stealth).\
You can only observe one subject at a\
time."
	stat = "Perception"
	difficulty = SKILL_AVERAGE
	page_number = "181"

	defaults = list("Detect Lies" = -4, "Psychology" = -4)

/datum/skill/body_sense //@TODO modifiers. Actualy, modifiers in general.
	name = "Body Sense"
	desc = "This is the ability to adjust quickly\
after teleportation or similar \"instant\
movement.\" A successful roll lets you\
act normally on your next turn. A\
failed roll means disorientation: you\
may take no action other than defense\
for one turn. A critical failure means\
you fall down, physically stunned!"
	stat = "Dexterity"
	difficulty = SKILL_HARD
	page_number = "181"

	defaults = list("Dexterity" = -6, "Acrobatics" = -3)

/datum/skill/bolas
	name = "Bolas"
	desc = "This is the ability to throw the\
bolas: a length of cord with two or\
more weights attached. Its primary\
uses are to stop herd animals and to\
hunt small game, but it can also\
entangle opponents in combat. See\
Special Ranged Weapons (p. 410) for\
bolas rules."
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "181"

/datum/skill/bow
	name = "Bow"
	desc = "This is the ability to use the long-\
bow, short bow, and all similar bows.\
It also covers the compound bow,\
although a person who had never seen\
a compound bow would suffer a -2\
unfamiliarity penalty."
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "182"

	defaults = list("Dexterity" = -5)

/datum/skill/boxing
	name = "Boxing"
	desc = "This is the skill of trained punch-\
ing. Roll against Boxing to hit with a\
punch. Boxing does not improve kick-\
ing ability – use Brawling (p. 182) or\
Karate (p. 203) for that.\
Boxing improves damage: if you\
know Boxing at DX+1 level, add +1 per\
die to basic thrust damage when you\
calculate punching damage. Add +2\
per die if you know Boxing at DX+2 or\
better! Work out damage ahead of\
time and record it on your character\
sheet.\
When you defend with bare hands,\
Boxing allows you to parry two differ-\
ent attacks per turn, one with each\
hand. Your Parry score is (skill/2) + 3,\
rounded down. Boxing parries are at\
-2 vs. kicks and -3 vs. weapons other\
than thrusting attacks. Boxing also\
gives an improved retreating bonus\
when you parry; see Retreat (p. 377).\
For more on barehanded parries, see\
Parrying Unarmed (p. 376)."
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "182"

/datum/skill/brain_hacking
	name = "Brain Hacking"
	desc = "This is the \"black art\" of technolog-\
ical personality alteration and mind\
control. Only intelligence, military,\
and security services teach it - and\
only to individuals with suitable Rank\
or Security Clearance. Even then, it is\
rare outside police states (except per-\
haps during wartime). Brain hacking could be considered\
the illegal version of brainwashing."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "182"

	prerequests = list("Psychology")

/datum/skill/brainwashing
	name = "Brainwashing"
	desc = "This is the \"black art\" of technolog-\
ical personality alteration and mind\
control. Only intelligence, military,\
and security services teach it - and\
only to individuals with suitable Rank\
or Security Clearance. Even then, it is\
rare outside police states (except per-\
haps during wartime)."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "182"

	prerequests = list("Psychology")

/datum/skill/brawling
	name = "Brawling"
	desc = "This is the skill of \"unscientific\" \
unarmed  combat.  Roll  against \
Brawling to hit with a punch, or \
Brawling-2 to hit with a kick. \
Brawling can also replace DX when \
you attack with teeth, claws, horns, or \
other \"natural weapons.\"\
Brawling improves damage: if you\
know Brawling at DX+2 level or bet-\
ter, add +1 per die to basic thrust dam-\
age when you calculate damage with\
Brawling attacks - punches, kicks,\
claws, bites, etc. Work out damage\
ahead of time and record it on your\
character sheet.\
Brawling includes the ability to use\
the blackjack or sap. An attack with\
such a fist load is considered a punch\
at +1 to damage.\
When you defend with bare hands,\
Brawling allows you to parry two dif-\
ferent attacks per turn, one with each\
hand. Your Parry score is (skill/2) + 3,\
rounded down. Brawling parries are\
at -3 vs. weapons other than thrusting\
attacks. For more on barehanded par-\
ries, see Parrying Unarmed (p. 376)."
	stat = "Dexterity"
	difficulty = SKILL_EASY
	page_number = "183"

/datum/skill/breaking_blow
	name = "Breaking Blow"
	desc = "This skill allows you to find the\
weakest spot in any object when mak-\
ing a barehanded attack. Each attack\
requires a separate Breaking Blow\
roll. Roll against skill after you hit.\
Breaking Blow costs 1 FP per attempt,\
whether or not you hit.\
On a success, your attack gains an\
armor divisor of (5) against any\
braced, inanimate, homogenous tar-\
get  (see  Injury  to  Unliving,\
Homogenous, and Diffuse Targets,\
p. 380), and you may treat the target\
as if it were Fragile (Brittle) (p. 136)\
for this one attack."
	stat = "Intelligence"
	difficulty = SKILL_HARD
	page_number = "182"

	prerequests = list("Trained By A Master")

/datum/skill/breath_control
	name = "Breath Control"
	desc = "This is the ability to breathe at\
maximum efficiency. On a successful\
skill roll, you can increase the time\
you can hold your breath for any rea-\
son (e.g., underwater) by 50%, or\
regain one FP in only two minutes\
(you cannot combine this with magic\
spells that restore FP)."
	stat = "Health"
	difficulty = SKILL_HARD
	page_number = "182"

/datum/skill/broadsword
	name = "Broadsword"
	desc = "Any bal-\
anced, 2- to 4-foot blade wielded in\
one hand - broadsword, cavalry saber,\
scimitar, etc. This skill also covers any\
stick or club of similar size and bal-\
ance to these blades, as well as bastard\
swords, katanas, and longswords used\
one-handed. Defaults: Force Sword-4,\
Rapier-4, Saber-4, Shortsword-2, or\
Two-Handed Sword-4."
	stat = "Dexterity"
	difficulty = SKILL_AVERAGE
	page_number = "182"

	defaults = list("Force Sword" = -4, "Rapier" = -4, "Saber" = -4, "Shortsword" = -2, "Two-Handed Sword" = -4)