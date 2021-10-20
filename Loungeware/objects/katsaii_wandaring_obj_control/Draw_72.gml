/// @desc Set up 3d and draw background.
katsaii_wandaring_rf3d_set_origin(posX, posY, posZ);
katsaii_wandaring_rf3d_set_orientation(angle, pitch);
if (instance_exists(katsaii_wandaring_obj_gameend)) {
    katsaii_wandaring_rf3d_set_orientation(angle + katsaii_wandaring_obj_gameend.timer * 180, pitch + katsaii_wandaring_obj_gameend.timer * 60);
}
// draw the background
var cam = view_camera[view_current];
var width = camera_get_view_width(cam);
var height = camera_get_view_height(cam);
var left = camera_get_view_x(cam);
var top = camera_get_view_y(cam);
var right = left + width;
var bottom = top + height;
var size = 0.05;
var col_parity = false;
var wrap_dist_x = 90;
var wrap_dist_y = 150;
var off_x = floor(lerp(0, 2 * size * width, -angle % wrap_dist_x / wrap_dist_x));
var off_y = floor(lerp(0, 2 * size * height, -posZ % wrap_dist_y / wrap_dist_y));
for (var i = 2 * -size; i <= 1 + 2 * size; i += size) {
    for (var j = 2 * -size; j <= 1 + 2 * size; j += size) {
        var x1 = off_x + lerp(left, right, i);
        var y1 = off_y + lerp(top, bottom, j);
        var x2 = off_x + lerp(left, right, i + size);
        var y2 = off_y + lerp(top, bottom, j + size);
        col_parity = !col_parity;
        var col = col_parity ? make_colour_rgb(117, 98, 156) : make_colour_rgb(183, 148, 209);
        draw_rectangle_colour(x1, y1, x2, y2, col, col, col, col, false);
    }
}
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(left, top, c_white, 0);
draw_vertex_color(right, top, c_white, 0);
draw_vertex_color(left, bottom, c_white, 0.5);
draw_vertex_color(right, bottom, c_white, 0.5);
draw_primitive_end();
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_cullmode(cull_counterclockwise);