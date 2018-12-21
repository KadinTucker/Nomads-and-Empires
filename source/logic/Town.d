module nomads.logic.Town;

/**
 * A town in the world
 * Connects to other towns, and generates wealth for its owner
 */ 
class Town {

    Town[] connections; ///All of the connections to other towns
    int[] connectionLevels; ///The level of each connection that measures their merit; associated with connections
    string name; ///The name of this town

}