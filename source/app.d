module app;

import nomads;

void main() {
	Display display = new Display(1000, 600);
    display.activity = new GameActivity(display);
    display.run();
}
