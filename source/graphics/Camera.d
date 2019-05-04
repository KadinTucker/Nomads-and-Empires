module nomads.graphics.Camera;

import nomads;

import std.math;

/**
 * The camera interface allows an activity convert from physical screen coordinates
 * to virtual coordinates, and vice versa
 */
interface Camera {

    /**
     * Takes virtual coordinates and converts them to physical coordinates
     */
    dVector project(iVector); 

    /**
     * Takes physical screen coordinates and converts them to virtual coordinates
     */
    iVector unproject(dVector);

}

/**
 * Acts as a component with a camera
 * Projects from one rectangular surface to another
 * Can be transformed with zoom and pan to modify the projection
 * Represents one large rectangle that can be sliced into different pieces of potentially different sizes
 * Uses abstracted coordinates between 0 and 1
 */
class CameraComponent : Component, Camera {

    iRectangle _location; ///The physical position and dimensions of the component; projects to display to fit the below abstract fields

    dVector pan; ///The physical shifting on the surface; measured as a proportional distance along the surface
    dVector projectionSize; ///The proportional size of the window projected to the screen relative to the dimensions of the entire surface

    this(Display container, iRectangle location) {
        super(container);
        this._location = location;
    }

    /**
     * Projects physical coordinates on the screen and converts them to coordinates on the larger rectangle
     * Uses physical coordinates relative to the position of a component using this camera
     */
    dVector project(iVector physical) {
        iVector relativeLocation = this.container.mouse.location - this._location.initialPoint;
        dVector relativePosition = new dVector(cast(double) relativeLocation.x * this.projectionSize.x / this._location.extent.x,
                cast(double) relativeLocation.x * this.projectionSize.x / this._location.extent.x);
        relativePosition += pan;
        return relativePosition;
    }

    /**
     * Takes abstract/virtual component coordinates and displays them as screen coordinates
     * TODO:
     */
    iVector unproject(dVector virtual) {
        return null;
    }

    /**
     * Handles events;
     * TODO: Build in zooming and panning?
     */
    void handleEvent(SDL_Event event) {

    }

    /**
     * Draws the component to the screen
     * Has no default implementation
     */
    override void draw() {}

    override @property iRectangle location() {
        return this._location;
    }

    /**
     * Changes the zoom such that the new area of the viewport is modified by the amount given,
     * works as a change in the area seen.
     * Negative amounts reduce the area (zoom in) and positive amounts increase it (zoom out).
     * Adjusts pan appropriately to maintain the center of the screen in the same location
     * TODO: make zooming keep center on the mouse
     */
    void zoom(double amount) {
        double newY = sqrt(this.projectionSize.y * (amount + this.projectionSize.x * this.projectionSize.y) / this.projectionSize.x);
        double newX = newY * this.projectionSize.x / this.projectionSize.y;
        this.pan.x -= newX - this.projectionSize.x;
        this.pan.y -= newY - this.projectionSize.y;
        this.projectionSize = new dVector(newX, newY);
    }

}