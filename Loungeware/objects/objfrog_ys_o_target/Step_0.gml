if (hit) {
	
	// Shrink and destroy
	height -= sprite_height/5;
	if (height < 0) {
		instance_destroy();	
	}
	
} else {

	// Spawn and stuff
	height_timer += (height_timer < 1) ? .05 : 0;

	var ac_channel = animcurve_get_channel(objfrog_ys_ac_curve, ac_channel_name);
	var curve_value = animcurve_channel_evaluate(ac_channel, height_timer);

	height = curve_value * sprite_height;

}