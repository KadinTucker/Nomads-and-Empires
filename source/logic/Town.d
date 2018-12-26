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
    iRectangle boundingBox; ///The bounding box of the town for selection
    Surface nameLabel; ///The label of the town's name
    Surface nameShadow; ///The label of the town's name's shadow
    Surface nameBackground; ///The background of the name label

    Player owner; ///The player owning this town
    string name; ///The name of this town
    int level; ///The level of this town

    /**
     * Constructs a new town a the given location,
     * generating a random name from the given name set
     */
    this(iVector location, NameSet nameset) {
        this.location = location;
        this.boundingBox = new iRectangle(location.x, location.y, 50, 50);
        this.name = generateName(nameset);
        this.setNameLabel();
    }

    /**
     * Sets the town's labels for its name
     * Updates whenever owner or name should change
     */
    void setNameLabel() {
        Font font = new Font("res/Cantarell-Regular.ttf", 24);
        this.nameLabel = font.renderTextSolid(this.name, Color(255, 255, 255));
        this.nameShadow = font.renderTextSolid(this.name);
        Color nameColor = (this.owner is null)? Color(125, 125, 125) : this.owner.color;
        this.nameBackground = new Surface(this.nameLabel.dimensions.x, this.nameLabel.dimensions.y);
        this.nameBackground.drawColor = nameColor;
        this.nameBackground.fillRect(new iRectangle(0, 0, this.nameLabel.dimensions.x, this.nameLabel.dimensions.y));
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

NameSet french = NameSet("pa ris mar seille ly on tou louse nice nan tes stras bourg mont pelli er bor deaux lille ren nes reims 
        le hav re tou lon gre no ble di jon an gers le mans or le ans rou en avi gnon char tres".split(),
        2, 3);

NameSet greek = NameSet("a thens thes sa ly pat ras la ris sa her ak li on".split(), 2, 4);