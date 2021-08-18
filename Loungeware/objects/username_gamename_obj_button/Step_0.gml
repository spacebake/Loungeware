if (KEY_ANY_PRESSED) {
	//Whenever the player performs the action that should 
	//mark the game has having been 'won', you should call this 
	//function. It's okay to call it more than once, and it's 
	//also okay to toggle back and forth.
	
	//see jsdoc for microgame_win for more information
	microgame_win();
	image_index = 1;
}

//MICROGAME_WON returns whether microgame_win has been called
if (MICROGAME_WON) {
	t = t + 1;
}

if (t > 60) {
	//end the microgame early if we've won the microgame for more
	//than 60 frames
	microgame_end_early();
}