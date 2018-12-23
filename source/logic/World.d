module nomads.logic.World;

import nomads;

import std.math;

/**
 * The world containing and creating a network of towns
 * Acts as a sort of game class, containing also players
 */
class World {

    Town[] allTowns; ///All of the towns in the world

    /**
     * Generates the world and all of its towns
     * Generates the given number of towns
     * Coulombic distribution unsuccessful
     */
    this(int numTowns) {
        iVector[] velocities;
        for(int i = 0; i < numTowns; i++) {
            allTowns ~= new Town(new iVector(i, i), french);
            velocities ~= new iVector(0, 0);
        }
        for(int i = 0; i < 10; i++) {
            for(int j = 0; j < allTowns.length; j++) {
                for(int k = 0; k < allTowns.length; k++) {
                    if(i != k) {
                        iVector direction = allTowns[j].location - allTowns[k].location;
                        direction.magnitude = 50 / pow((allTowns[j].location - allTowns[k].location).magnitude, 2);
                        velocities[j] += direction;
                    }
                }
                allTowns[j].location += velocities[j];
            }
        }
    }

}