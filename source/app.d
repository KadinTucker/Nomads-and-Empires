module app;

import nomads.graphics.activity.GameActivity;

import d2d;

void main() {
	Display display = new Display(500, 400);
    display.activity = new GameActivity(display);
    display.run();
}
