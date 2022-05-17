// Draw parabola
if (!diving) {
	var _t = 1;
	do {
		var _str = mantaray_pool_dive_fnc_projectile_motion(_t, initial_velocity, angle, 5);		
		draw_set_alpha(0.8);
		draw_circle_color(round(x+_str.x), round(y-sprite_height/2-_str.y), 1, c_red, c_red, false);
		draw_set_alpha(1);
		_t += 0.5;	
	}
	until (y-sprite_height/2-_str.y >= 128);
}

// Draw self - angle determined by image_angle
draw_self();

