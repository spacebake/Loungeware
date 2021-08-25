/// @desc Draw projectile.
draw_self();
gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), 1.3 * image_xscale, 1.3 * image_yscale, image_angle, image_blend, image_alpha * 0.25);
gpu_set_blendmode(bm_normal);