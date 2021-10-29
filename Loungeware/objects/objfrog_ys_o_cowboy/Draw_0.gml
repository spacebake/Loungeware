if (image_index == 1) {
	draw_sprite_ext(objfrog_ys_s_arms, image_index, x, y - 22, 1, 1, direction, c_white, 1);	
}

draw_self();

if (image_index != 1) {
	draw_sprite_ext(objfrog_ys_s_arms, image_index, x, y - 22, 1, 1, direction, c_white, 1);	
}
