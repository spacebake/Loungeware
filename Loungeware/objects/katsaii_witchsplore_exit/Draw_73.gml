/// @desc Draw arrow in direction of goal.
var cam = view_camera[view_current];
var left = camera_get_view_x(cam);
var top = camera_get_view_y(cam);
var right = left + camera_get_view_width(cam);
var bottom = top + camera_get_view_height(cam);
var pad = 20;
var pos_x = floor(clamp(x, left + pad, right - pad));
var pos_y = floor(clamp(y - 25, top + pad, bottom - pad));
draw_set_colour(c_white);
draw_circle(pos_x, pos_y, 10, false);
var dir = point_direction(pos_x, pos_y, x, y);
draw_line_width(pos_x, pos_y, pos_x + lengthdir_x(20, dir), pos_y + lengthdir_y(20, dir), 5);