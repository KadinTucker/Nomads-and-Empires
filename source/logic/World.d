module nomads.logic.World;

import nomads;

import std.algorithm;
import std.math;
import std.random;

//The characteristic width and height of a world
//Sets the rough arrangement of towns
immutable int aspectWidth = 4;
immutable int aspectHeight = 3; 

/**
 * The world containing and creating a network of towns
 * Acts as a sort of game class, containing also players
 */
class World {

    Town[] allTowns; ///All of the towns in the world

    /**
     * Generates the world and all of its towns
     * Generates the given number of towns
     * Doesn't generate that number exactly due to size ratios, but generates roughly that many
     */
    this(int numTowns) {
        double baseDimension = sqrt(numTowns / cast(double) (aspectHeight * aspectWidth));
        for(int x = 0; x < cast(int) (baseDimension * aspectWidth + 1); x++) {
            for(int y = 0; y < cast(int) (baseDimension * aspectHeight + 1); y++) {
                this.allTowns ~= new Town(new iVector(townSpace * x + uniform(townSpace / 4, townSpace * 3 / 4), 
                        townSpace * y + uniform(townSpace / 4, townSpace * 3 / 4)), french);
            }
        }
    }

}