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

	specializations = list("Aerobatics", "Aquabatics")
	defaults = list("Acrobatics (Aerobatics)" = -4, "Acrobatics (Aquabatics)" = -4, "Acrobatics" = -4)

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

	defaults = list("Intelligence" = -5, "Performance" = -2, "Public Speaking" = -5)