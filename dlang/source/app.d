module app;

import nomads;

void main() {
	Display display = new Display(1000, 600, SDL_WINDOW_SHOWN|SDL_WINDOW_RESIZABLE);
    display.activity = new GameActivity(display);
    display.run();
}
