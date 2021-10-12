
// -------------------------------------------------------------
//  B A C K G R O U N D
// -------------------------------------------------------------

// Trees BACK
with baku_skate_obj_trees_bg event_perform(ev_draw, 0);

// Ground
with baku_skate_obj_ground event_perform(ev_draw, 0);

// -------------------------------------------------------------
//  M I M P Y
// -------------------------------------------------------------

// Mimpy coords
var _mimpy_x = mimpy_x_display + lengthdir_x(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_x(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
var _mimpy_y = mimpy_y_display + lengthdir_y(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_y(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);

// Shadow
var _shadow_scale = clamp(map(jump_y, 0, -128, 1, 0.5), 0.5, 1);
var _shadow_alpha = clamp(map(jump_y, 0, -128, 0.25, 0.125), 0.125, 0.25);
draw_sprite_ext(baku_skate_spr_mimpy_shadow1, image_index, _mimpy_x, _mimpy_y, _shadow_scale, _shadow_scale, 0, c_white, _shadow_alpha);

// Mimpy
draw_sprite(sprite_index, image_index, _mimpy_x, _mimpy_y + jump_y);

// -------------------------------------------------------------
//  F O R E G R O U N D
// -------------------------------------------------------------

// Trees FRONT
with baku_skate_obj_trees_fg event_perform(ev_draw, 0);

// -------------------------------------------------------------
//  H U D
// -------------------------------------------------------------

// DEBUG
// draw_set_colour(c_red);
// draw_text(10, 10, string(jump_y));
// draw_text(10, 30, string(_shadow_scale));