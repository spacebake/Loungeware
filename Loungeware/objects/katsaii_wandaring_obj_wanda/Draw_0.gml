/// @desc Draw wanda billboard.
katsaii_wandaring_rf3d_draw_begin(sprite_index, image_index);
katsaii_wandaring_rf3d_add_billboard(x, y, z, c_white, 1, flip);
katsaii_wandaring_rf3d_draw_end();
// dithering when occluded
katsaii_wandaring_shader_set_effect_dissolve();
katsaii_wandaring_rf3d_draw_begin(sprite_index, image_index);
katsaii_wandaring_rf3d_add_billboard(x, y, z, c_white, 1, flip, -1000);
katsaii_wandaring_rf3d_draw_end();
shader_reset();