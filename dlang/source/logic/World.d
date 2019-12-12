module nomads.logic.World;

import nomads;

import std.algorithm;
import std.math;
import std.random;

//The characteristic ratio of width to height
// = w/h of the world
immutable double aspectRatio = 1.7;

immutable int townDensity = 500; //The space that each town has on the map
immutable double townMargin = 0.25; //The padding around each town

/**
 * The world containing and creating a network of towns
 * Acts as a sort of game class, containing also players
 */
class World {

    Town[][] allTowns; ///All of the towns in the world

    /**
     * Generates the world and all of its towns
     * Generates the given number of towns
     * Doesn't generate that number exactly due to size ratios, but generates roughly that many
     * Uses the aspect ratio satisfying the two equations: a = x/y, t = xy
     */
    this(int numTowns) {
        int x = cast(int) (aspectRatio * sqrt(numTowns / aspectRatio));
        int y = cast(int) sqrt(numTowns / aspectRatio);
        for(int i = 0; i < x; i++) {
            allTowns ~= null;
            for(int j = 0; j < y; j++) {
                allTowns[i] ~= new Town(new iVector(
                        cast(int) (townDensity * (i + uniform(0, 2 * townMargin) + townMargin)),
                        cast(int) (townDensity * (j + uniform(0, 2 * townMargin) + townMargin))), french);
            }
        }
    }

}