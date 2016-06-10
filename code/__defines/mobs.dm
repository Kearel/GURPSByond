// Invisibility constants.
#define INVISIBILITY_LIGHTING             20
#define INVISIBILITY_LEVEL_ONE            35
#define INVISIBILITY_LEVEL_TWO            45
#define INVISIBILITY_OBSERVER             60
#define INVISIBILITY_EYE		          61
#define INVISIBILITY_GAMEMASTER           62


#define SEE_INVISIBLE_LIVING              25
#define SEE_INVISIBLE_NOLIGHTING 15
#define SEE_INVISIBLE_LEVEL_ONE           35
#define SEE_INVISIBLE_LEVEL_TWO           45
#define SEE_INVISIBLE_CULT		          60
#define SEE_INVISIBLE_OBSERVER            61
#define SEE_INVISIBLE_GAMEMASTER          63

#define SEE_INVISIBLE_MINIMUM 5
#define INVISIBILITY_MAXIMUM 100


//combat flags (/mob/living/var/combat_flags)
#define COMBAT_FLAG_TURN  1 //Is it our turn to move?
#define COMBAT_FLAG_ACTION 2 //Have we selected an action yet?
#define COMBAT_FLAG_DONE  4 //Have we done all we could?



//Posture, these effect certain things (like movement)
#define POSTURE_STAND    "standing"
#define POSTURE_SIT      "sitting"
#define POSTURE_KNEEL    "kneeling"
#define POSTURE_CRAWL    "crawling"
#define POSTURE_PRONE    "lying prone"
#define POSTURE_BACK     "on back"