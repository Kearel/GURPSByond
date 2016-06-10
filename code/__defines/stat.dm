
/* How this is used for each type:

mobs: Simple. Alive is alive, Dead is dead. Disabled is unconscious.

turfs/obj: Can this thing be damaged? Then it is Alive. Otherwise its dead. If it can't function, then it is disabled.

*/


#define ALIVE    0
#define DISABLED 1
#define DEAD     2