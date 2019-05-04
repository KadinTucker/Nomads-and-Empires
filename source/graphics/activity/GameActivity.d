module nomads.graphics.activity.GameActivity;

import nomads;

import std.math;
import std.random;

    // Random colors for generating stylized map
    // Color prevColor = Color(cast(ubyte) uniform(10, 100), cast(ubyte) uniform(50, 200), cast(ubyte) uniform(10, 100)); 
    // Color newColor = Color(previous.r + uniform(-(previous.r - 10) / 270, (previous.r - 10) / 270),
    //         previous.g + uniform(-(previous.g - 50) / 400, (previous.g - 50) / 400),
    //         previous.b + uniform(-(previous.b - 10) / 270, (previous.b - 10) / 270));

immutable int zoomAmt = 5; //1 / how much zoom there is relative to the component's size
immutable int zoomLimit = 4; //how many times the window size the zoom maxes out at
immutable double zoomMin = 1; //The minimum window size

/**
 * The activity handling game functions
 */
class GameActivity : Activity {

    World world; ///the world in this game
    iVector pan; ///The panning on the map
    iVector zoom; ///The dimensions of the component to display
    iVector prevMouseLocation; ///The previous location of the mouse; used for panning
    Texture worldTexture; ///The texture of the world
    Texture overlayTexture; ///The texture of the selection of a town
    Town selectedTown; ///The currently selected town

    this(Display container) {
        super(container);
        this.world = new World(24);
        this.pan = new iVector(0, 0);
        this.prevMouseLocation = new iVector(this.container.mouse.location.x, this.container.mouse.location.x);
        this.updateWorldTexture();
        this.updateOverlayTexture();
        this.zoom = this.zoom = new iVector(zoomLimit * this.container.window.size.x, zoomLimit * this.container.window.size.y);
    }

    override void draw() {
        this.container.renderer.copy(this.worldTexture, new iRectangle(this.pan.x, this.pan.y, this.zoom.x, this.zoom.y));
        this.container.renderer.copy(this.overlayTexture, new iRectangle(this.pan.x, this.pan.y, this.zoom.x, this.zoom.y));
        this.container.renderer.drawColor = Color(75, 115, 35);
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

    /**
     * Updates the world texture, containing the map and towns
     * TODO:
     */
    private void updateWorldTexture() {

    }

    /**
     * Updates the overlay, containing the armies and caravans
     */
    private void updateOverlayTexture() {

    }

    override void handleEvent(SDL_Event event) {
        //Zooming
        if(event.type == SDL_MOUSEWHEEL) {
            if(event.wheel.y > 0) {
                this.zoom += new iVector(this.container.window.size.x / zoomAmt, this.container.window.size.y / zoomAmt);
                if(this.zoom.x > zoomLimit * this.container.window.size.x|| this.zoom.y > zoomLimit * this.container.window.size.y) {
                    this.zoom = new iVector(zoomLimit * this.container.window.size.x, zoomLimit * this.container.window.size.y);
                } else {
                    this.pan -= new iVector(this.container.mouse.location.x / zoomAmt, this.container.mouse.location.y / zoomAmt);
                }
            } else if(event.wheel.y < 0) {
                this.zoom -= new iVector(this.container.window.size.x / zoomAmt, this.container.window.size.y / zoomAmt);
                if(this.zoom.x < zoomMin * this.container.window.size.x || this.zoom.y < zoomMin * this.container.window.size.y) {
                    this.zoom = new iVector(cast(int) (zoomMin * this.container.window.size.x), cast(int) (zoomMin * this.container.window.size.y));
                } else {
                    this.pan += new iVector(this.container.mouse.location.x / zoomAmt, this.container.mouse.location.y / zoomAmt);
                }
            }
        }
        if(event.type == SDL_MOUSEBUTTONDOWN) {
            if(event.button.button == SDL_BUTTON_LEFT) {
                //For panning
                this.prevMouseLocation = this.container.mouse.location - this.pan;
            }
        }
        if(event.type == SDL_MOUSEBUTTONUP) {
            if(event.button.button == SDL_BUTTON_LEFT) {
                this.prevMouseLocation = this.container.mouse.location - this.pan;
                //Selecting towns: TODO
                updateOverlayTexture();
            }
        }
        else if(event.type == SDL_MOUSEMOTION) {
            if(this.container.mouse.allButtons[SDL_BUTTON_LEFT].isPressed) {
                this.pan = this.container.mouse.location - this.prevMouseLocation;
            }
        }
    }

    /**
     * Implementation of the Camera method 'project': gets coordinates on this component from screen coordinates
     */
    iVector project(iVector location) {
        return new iVector(cast(int) (cast(double) this.worldTexture.dimensions.x / this.zoom.x * (location.x - this.pan.x)),
                cast(int) (cast(double) this.worldTexture.dimensions.y / this.zoom.y * (location.y - this.pan.y)));
    }

}