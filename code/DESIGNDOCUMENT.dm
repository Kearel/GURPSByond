/*
This game is supposed to be played similarly to a tabletop RPG.

That means that when combat hits everything turns to turn-based, but in all other occassions everything is done in realtime.

I originally thought 'hey pathfinder is a cool game lets base it off of that' but there are literally hundreds of games with that premise.


So GURPS with squares. Cause fuckin' gurps.












HOW COMBAT WORKS:
Conbat controller, controls what dudes go at what time.
When its a dude's turn they get the following flags:
TURN - Its their turn.
ACTION - They can use an action.

The dude in question then uses an action, which then subtracts the ACTION flag.
They then generate their respective movement range.

They could also get the following flags:
ATTACK - They can attack
USE - They can use an item/do something besides attacking.


STATUS EFFECTS:
Status effects are controlled by a manager.
Status effects each have a tag that can be sent to the manager to get the total 'buff/drawback'
Status effects have a 'strength' to them, that effects how much they effect shit.
Status effects can be 'linked' meaning that when one dies, so does the other.

Status effects have conditions underwhich they disappear.
Some disappear after a round, after a turn, etc.
*/