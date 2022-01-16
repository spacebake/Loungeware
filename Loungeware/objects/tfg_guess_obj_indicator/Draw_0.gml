circle_curr_rot += circle_rot_speed;
t++;

draw_sprite_ext(tfg_guess_spr_circle, 0, x, y, image_xscale * circle_scale, 
	image_yscale * circle_scale, circle_curr_rot, c_white, 1);
	
draw_sprite_ext(sprite_index, image_index, x, y + curr_yoff, image_xscale,
	image_yscale, curr_rot, image_blend, image_alpha);