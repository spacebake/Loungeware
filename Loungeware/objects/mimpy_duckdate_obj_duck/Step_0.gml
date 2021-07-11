// Inherit the parent event
event_inherited();

if (array_length(tweens) == 0) {
	time += angry ? 20 : 1;
	image_angle = sin(time / 60) * 5;
		
	if (angry) {
		time2++;
		image_yscale = 1.2 - cos(time2 / 5) * 0.2;
		image_xscale = 1 + sin(time2 / 5) * 0.2;
	}
}

if (!angry && TIME_REMAINING < 60 && !loved) {
	loved = true;
	image_index = 2;
	instance_create_layer(x + 60, y - 30, "Heart", mimpy_duckdate_obj_heart);
	sfx_play(mimpy_duckdate_snd_love, 1, false);
}