module app;

import nomads;

void main() {
	Display display = new Display(500, 400);
    display.activity = new GameActivity(display);
    display.run();
}
