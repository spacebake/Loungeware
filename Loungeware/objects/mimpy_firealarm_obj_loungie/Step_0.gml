if (burning) {
	x += spd * dir;

	image_angle = 20 * sin(current_time / 50 + time_offset);

	// Flip when hitting the sides
	if (x < 0) {
		x = 0;
		dir = 1;
	}
	else if (x > room_width) {
		x = room_width;
		dir = -1;
	}
	
	var head = {
		x: x + lengthdir_x(48, image_angle + 90),
		y: y + lengthdir_y(48, image_angle + 90),
	}
	
	lifetime++;
	if (lifetime % 2 == 0) {
		instance_create_layer(
			head.x,
			head.y,
			"Fire",
			mimpy_firealarm_obj_fire
		);
	}
	
	if (lifetime % 5 == 0) {
		instance_create_layer(
			head.x + random_range(-16, 16),
			head.y + random_range(-16, 16),
			"Ash",
			mimpy_firealarm_obj_ash
		);
	}
}
else {
	image_angle = 0;
	image_index = 1;
	y = lerp(y, ystart + 16, 0.2);
}