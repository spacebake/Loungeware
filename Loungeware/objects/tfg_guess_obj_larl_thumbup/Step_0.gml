if (tfg_animation_end()) {
	image_speed = -1;
}

if (tfg_animation_begin()) {
	if (image_speed == -1) {
		image_speed = 0;
		
		if (sprite_index == tfg_spr_larl_thumbup) microgame_win();
		
		microgame_end_early();
		
		exit;
	}	
}
//if (tfg_animation_end()) ended = true;

//if (ended) {
//	image_speed = 0;
//	image_alpha -= 0.02;
//}

//if (image_alpha == 0) instance_destroy();