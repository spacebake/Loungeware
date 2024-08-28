/// @description Insert description here
// You can write your code in this editor


if(!___MG_MNGR.microgame_won) {
	draw_set_color(c_white);
	draw_set_alpha(lerp(1, 0, shrink.getPosition()));
	draw_rectangle(lerp(start, x, shrink.getPosition()), bbox_top+4, x, bbox_bottom-4, false);
	draw_set_alpha(1);

	gpu_set_fog(true, c_white,-16000, 16000)
	draw_self();
	gpu_set_fog(false, 0, 0, 0);

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, shrink.getPosition());
} else {
	draw_set_color(c_white);
	draw_rectangle(lerp(xstart, x, escapeShrink.getPosition()), bbox_top+4, x, bbox_bottom-4, false);

	gpu_set_fog(true, c_white,-16000, 16000)
	draw_self();
	gpu_set_fog(false, 0, 0, 0);

	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1 - escape.getPosition());
}


