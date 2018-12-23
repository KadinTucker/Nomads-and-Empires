module nomads.graphics.activity.GameActivity;

import nomads;

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
    World world; ///the world in this game
    iVector pan; ///The panning on the map

    this(Display container) {
        super(container);
        this.townTexture = new Texture(loadImage("res/town.png"), container.renderer);
        this.world = new World(12);
        this.pan = new iVector(0, 0);
    }

    override void draw() {
        this.container.renderer.drawColor = Color(95, 115, 55);
        foreach(town; this.world.allTowns) {
            this.container.renderer.copy(this.townTexture, town.location.x + this.pan.x, town.location.y + this.pan.y);
        }
        if(this.container.keyboard.allKeys[SDLK_UP].isPressed) {
            this.pan.y += 14;
        }
        if(this.container.keyboard.allKeys[SDLK_RIGHT].isPressed) {
            this.pan.x -= 14;
        }
        if(this.container.keyboard.allKeys[SDLK_DOWN].isPressed) {
            this.pan.y -= 14;
        }
        if(this.container.keyboard.allKeys[SDLK_LEFT].isPressed) {
            this.pan.x += 14;
        }
    }

}