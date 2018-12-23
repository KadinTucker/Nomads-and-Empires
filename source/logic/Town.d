module nomads.logic.Town;

import nomads;

import std.algorithm;
import std.array;
import std.random;

/**
 * A town in the world
 * Connects to other towns, and generates wealth for its owner
 */ 
class Town {

    iVector location; ///The location of the town on the map
    Town[] connections; ///All of the connections to other towns
    string name; ///The name of this town

    this(iVector location, NameSet nameset) {
        this.location = location;
        this.name = generateName(nameset);
    }

}

/**
 * A set of syllables to generate random names with
 */
struct NameSet {

    string[] syllables;
    int minSyllable;
    int maxSyllable;

}

/** 
 * Generates a random name given a name
 */
string generateName(NameSet nameset) {
    int syllables = uniform!"[]"(nameset.minSyllable, nameset.maxSyllable);
    string name = "";
    for(int i = 0; i < syllables; i++) {
        name ~= nameset.syllables.choice();
    }
    return name;
}

NameSet french = NameSet("pa ris mar seille ly on tou louse nice nan tes stras bourg mont pell ier bor deaux lille ren nes reims 
        le hav re tou lon gre nob le di jon an gers le mans or le ans rou en a vi gnon char tres".split(),
        2, 3);

NameSet greek = NameSet("a thens thes sa ly pat ras la ris sa her ak li on".split(), 2, 4);