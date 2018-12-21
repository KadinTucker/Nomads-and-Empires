module nomads.graphics.activity.GameActivity;

import nomads;

import d2d;
import std.random;

    // Random colors for generating stylized map
    // Color prevColor = Color(cast(ubyte) uniform(10, 100), cast(ubyte) uniform(50, 200), cast(ubyte) uniform(10, 100)); 
    // Color newColor = Color(previous.r + uniform(-(previous.r - 10) / 270, (previous.r - 10) / 270),
    //         previous.g + uniform(-(previous.g - 50) / 400, (previous.g - 50) / 400),
    //         previous.b + uniform(-(previous.b - 10) / 270, (previous.b - 10) / 270));

/**
 * The activity handling game functions
 */
class GameActivity : Activity {

    Texture townTexture; ///The texture used for towns
    iVector[] townLocations; ///The location of each town in the game
    Town[] towns; ///All of the towns in this game

    this(Display container) {
        super(container);
        this.townTexture = new Texture(loadImage("res/town.png"), container.renderer);
        //Test towns
        townLocations ~= new iVector(100, 200);
        townLocations ~= new iVector(400, 250);
    }

    override void draw() {
        this.container.renderer.drawColor = Color(95, 115, 55);
        for(int i = 0; i < this.townLocations.length; i++) {
            this.container.renderer.copy(this.townTexture, townLocations[i].x - 25, townLocations[i].y - 25);
        }
    }

}