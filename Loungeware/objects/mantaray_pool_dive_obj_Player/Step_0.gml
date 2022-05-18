if (!diving) {
	if (can_adjust) {
		if (KEY_LEFT)		angle = min(max_angle,	angle+angle_delta_spd);
		if (KEY_RIGHT)		angle = max(min_angle,	angle-angle_delta_spd);
		if (KEY_UP)			initial_velocity = min(max_initial_velocity,	initial_velocity+velocity_delta_spd);
		if (KEY_DOWN)		initial_velocity = max(min_initial_velocity,	initial_velocity-velocity_delta_spd);	
		alarm[0] = 20;
	}
	if (KEY_PRIMARY)		diving = true;
}
else {
	if (!audio_boing_played) {
		sfx_play(mantaray_pool_dive_snd_Boing, 1, false);
		audio_boing_played = true;
	}
	
	if (!stop_diving) {
		var _str = mantaray_pool_dive_fnc_projectile_motion(t_diving, initial_velocity, angle, 5);
		x = xstart + _str.x;
		y = ystart - _str.y;
		
		image_angle = point_direction(xprevious, yprevious, x, y)-90;
	
		t_diving += 0.2;
	}	
}
