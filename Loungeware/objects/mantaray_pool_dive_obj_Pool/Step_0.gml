if (!successful_dive) {
	var _dx = 72*initial_sign*sin(t);
	x = xstart+_dx;
	t += spd;
}
else if (!splash) {	
	part_type_shape(water, pt_shape_pixel);
	part_type_size(water, 1, 2, 0, 0);
	part_type_color2(water, #6bd7ed, #66cfe5);
	part_type_speed(water, 0.3, 0.7, 0, 0);
	part_type_direction(water, 5, 175, 0, 0);
	part_type_blend(water, false);
	part_type_life(water, 30, 90);
	part_particles_create(part_system, x, y-sprite_height/4, water, 150);
	splash = true;
}
