if (KEY_ANY_PRESSED) {
	//see jsdoc for microgame_win()
	microgame_win();
	image_index = 1;
}

//MICROGAME_WON returns whether microgame_win has been called
if (MICROGAME_WON) {
	t++;
}

if (t > 60) {
	//exit early if 
	microgame_end_early();
}