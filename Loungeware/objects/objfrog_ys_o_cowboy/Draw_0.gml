#region Arms and body


	if (image_index == 1) {
		draw_sprite_ext(objfrog_ys_s_arms, image_index, x, y - gun_height, 1, 1, direction, c_white, 1);	
	}

	draw_self();

	if (image_index != 1) {
		draw_sprite_ext(objfrog_ys_s_arms, image_index, x, y - gun_height, 1, 1, direction, c_white, 1);	
	}


#endregion
