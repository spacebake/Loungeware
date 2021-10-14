/// @desc Draw arrow in direction of goal.
if (katsaii_wandaxplore_player.freezePlayer) {
    exit;
}
var cam = view_camera[view_current];
var left = camera_get_view_x(cam);
var top = camera_get_view_y(cam);
var right = left + camera_get_view_width(cam);
var bottom = top + camera_get_view_height(cam);
var pad = 20;
var pos_x = floor(clamp(x, left + pad, right - pad));
var pos_y = floor(clamp(y - 20, top + pad, bottom - pad));
draw_set_colour(c_white);
draw_sprite(katsaii_wandaxplore_wanda, 11, pos_x, pos_y + 5);