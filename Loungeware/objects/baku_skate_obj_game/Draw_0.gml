
// Backgrounds
with baku_skate_obj_bg event_perform(ev_draw, 0);

// Mimpy
var _mimpy_x = mimpy_x_display + lengthdir_x(sin(current_time / (777 / DIFFICULTY)) * 8, 45) + lengthdir_x(cos(current_time / (1333 / DIFFICULTY)) * 16, world_angle);
var _mimpy_y = mimpy_y_display + lengthdir_y(sin(current_time / (777 / DIFFICULTY)) * 8, 45) + lengthdir_y(cos(current_time / (1333 / DIFFICULTY)) * 16, world_angle);
draw_sprite(baku_skate_spr_mimpy_idle, 0, _mimpy_x, _mimpy_y);

// HUD
// draw_text(10, 19, string(DIFFICULTY));