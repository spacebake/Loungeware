function objfrog_pp_draw_self_3d(){
	for(var i = 0; i < image_number; i++) {
		draw_sprite_ext(sprite_index, i, x, y-i, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
}
