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
	alarm[0] = room_speed * 2.5;
	instance_create_layer(room_width/2, room_height/2, "Instances", objfrog_pp_o_win_screen);
	triggered = true;
}
