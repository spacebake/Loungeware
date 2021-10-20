/// @desc Draw billboard.
katsaii_wandaring_shader_set_effect_colour_grey();
katsaii_wandaring_rf3d_draw_begin(sprite_index, image_index);
katsaii_wandaring_rf3d_add_billboard(x, y, z, image_blend);
katsaii_wandaring_rf3d_draw_end();
shader_reset();