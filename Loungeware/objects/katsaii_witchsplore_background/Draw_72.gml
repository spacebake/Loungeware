/// @desc Draw background.
var cam = view_camera[view_current];
var pad = 10;
draw_rectangle_color(camera_get_view_x(cam) - pad, camera_get_view_y(cam) - pad,
        camera_get_view_x(cam) + camera_get_view_width(cam) + pad,
        camera_get_view_y(cam) + camera_get_view_height(cam) + pad,
        KATSAII_WITCHSPLORE_SKY_BLUE, KATSAII_WITCHSPLORE_SKY_BLUE,
        KATSAII_WITCHSPLORE_SKY_PINK, KATSAII_WITCHSPLORE_SKY_PINK, false);