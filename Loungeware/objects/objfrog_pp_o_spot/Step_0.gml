// Alpha
if (decrease) {
	image_alpha -= .02;
	if (image_alpha < .3) {
		decrease = false;	
	}
} else {
	image_alpha += .02;
	if (image_alpha > .9) {
		decrease = true;	
	}
}


// Win microgame
if (!triggered && point_distance(x, y, objfrog_pp_o_car.x, objfrog_pp_o_car.y) < 10) {
	// Hooray :D
	microgame_win();
	sfx_play(objfrog_pp_sfx_yeehawww, 1, false);
	triggered = true;
}
