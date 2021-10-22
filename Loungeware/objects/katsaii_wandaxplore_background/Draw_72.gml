/// @desc Draw background.
var cam = view_camera[view_current];
var pad = 10;
var left = camera_get_view_x(cam) - pad;
var top = camera_get_view_y(cam) - pad;
var right = camera_get_view_x(cam) + camera_get_view_width(cam) + pad;
var bottom = camera_get_view_y(cam) + camera_get_view_height(cam) + pad;
draw_rectangle_color(left, top, right, bottom,
        KATSAII_WITCHSPLORE_SKY_BLUE, KATSAII_WITCHSPLORE_SKY_BLUE,
        KATSAII_WITCHSPLORE_SKY_PINK, KATSAII_WITCHSPLORE_SKY_PINK, false);
// draw the sun
var sun_angle_blend = lerp(-3, 4, (angle_difference(katsaii_wandaxplore_player.angle, 0) + 180) / 360);
draw_circle_colour(lerp(left, right, sun_angle_blend), bottom - pad + 40 * (sun_angle_blend - 0.5) * (sun_angle_blend - 0.5),
        30, c_orange, KATSAII_WITCHSPLORE_SKY_PINK, false);
// draw islands in the distance
var far_islands = [
    [0, 0.5, 5],
    [0.05, 0.4, 3],
    [0.125, 0.6, 5],
    [0.25, 0.8, 8],
    [0.4, 0.7, 4],
    [0.5, 0.3, 10],
    [0.75, 0.9, 4],
    [0.8, 0.7, 3],
    [0.9, 0.5, 7],
];
for (var i = 0; i < array_length(far_islands); i += 1) {
    var island_data = far_islands[i];
    var angle = lerp(0, 360, island_data[0]);
    var pos_y = lerp(top, bottom, island_data[1]) - pad;
    var r = island_data[2];
    var angle_blend = lerp(-2, 3, (angle_difference(katsaii_wandaxplore_player.angle, angle) + 180) / 360);
    var pos_x = lerp(left, right, angle_blend);
    draw_rectangle_color(pos_x - r, pos_y + 40 * (angle_blend - 0.5) * (angle_blend - 0.5), pos_x + r, bottom,
            KATSAII_WITCHSPLORE_CLIFF_FAR, KATSAII_WITCHSPLORE_CLIFF_FAR,
            KATSAII_WITCHSPLORE_SKY_PINK, KATSAII_WITCHSPLORE_SKY_PINK, false);
}