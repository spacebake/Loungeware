function ShakeObject(_object, _rotate = false){
	with (_object){
		x += random_range(-2, 2);
		y += random_range(-2, 2);
		
		if (_rotate){
			image_angle += random_range(-15, 15)
		}
					
		if (alarm[0] == -1){
			alarm[0] = game_get_speed(gamespeed_fps) * 0.06;
		}
	}
}