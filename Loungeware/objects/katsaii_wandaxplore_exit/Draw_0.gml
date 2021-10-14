/// @desc Draw the broom.
var t = current_time * 0.25;
var wave1 = dsin(t);
var wave2 = dsin(t + 90);
var pos_x = x;
var pos_y = y - 10 + 4 * wave1;
draw_sprite_ext(sprite_index, image_index, pos_x, pos_y, 1, 1, 10 * wave2, c_white, 1);
gpu_set_blendmode(bm_add);
draw_sprite_ext(katsaii_wandaxplore_shield, 0, pos_x, pos_y, 0.5, 0.5, current_time * 0.1, c_white, 1);
gpu_set_blendmode(bm_normal);