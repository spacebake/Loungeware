/// @desc Draw essence.
draw_sprite_ext(katsaii_witchwanda_spr_heart, image_index, floor(x), floor(y), 2 * image_xscale, 2 * image_yscale, image_angle, image_blend, 1 - lifeTimer);
gpu_set_blendmode(bm_add);
draw_sprite_ext(katsaii_witchwanda_spr_heart, image_index, floor(x), floor(y), 3 * image_xscale, 3 * image_yscale, image_angle, image_blend, 1 - lifeTimer);
gpu_set_blendmode(bm_normal);