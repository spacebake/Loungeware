/// @desc Draw the platforms. (TEMPORARY)

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
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_cullmode(cull_counterclockwise);

katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 0);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
    katsaii_wandaring_rf3d_add_sprite_pos(
            x1, y1, z_top,
            x2, y1, z_top,
            x2, y2, z_top,
            x1, y2, z_top, col);
}
katsaii_wandaring_rf3d_draw_end();
katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 1);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
    if not (_occlude & KATSAII_WANDARING_CELL_LEFT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y1, z_top,
                x1, y2, z_top,
                x1, y2, z_bot,
                x1, y1, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_BOTTOM) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y2, z_top,
                x2, y2, z_top,
                x2, y2, z_bot,
                x1, y2, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_RIGHT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y2, z_top,
                x2, y1, z_top,
                x2, y1, z_bot,
                x2, y2, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_TOP) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y1, z_top,
                x1, y1, z_top,
                x1, y1, z_bot,
                x2, y1, z_bot, col_cliff);
    }
}
katsaii_wandaring_rf3d_draw_end();
katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass_edge, 0);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
    var hang = 3;
    if not (_occlude & KATSAII_WANDARING_CELL_LEFT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y1, z_top,
                x1, y2, z_top,
                x1 - hang, y2, z_top + hang,
                x1 - hang, y1, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_BOTTOM) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y2, z_top,
                x2, y2, z_top,
                x2, y2 + hang, z_top + hang,
                x1, y2 + hang, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_RIGHT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y2, z_top,
                x2, y1, z_top,
                x2 + hang, y1, z_top + hang,
                x2 + hang, y2, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_TOP) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y1, z_top,
                x1, y1, z_top,
                x1, y1 - hang, z_top + hang,
                x2, y1 - hang, z_top + hang, col);
    }
}
katsaii_wandaring_rf3d_draw_end();