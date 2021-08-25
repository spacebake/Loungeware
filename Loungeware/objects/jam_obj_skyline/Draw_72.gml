/// @desc Draw the skyline.
var cam = KATSAII_WITCH_WANDA_VIEW_CAM;
var cam_left = camera_get_view_x(cam);
var cam_top = camera_get_view_y(cam);
var cam_width = camera_get_view_width(cam);
var cam_height = camera_get_view_height(cam);
var cam_right = cam_left + cam_width;
var cam_bottom = cam_top + cam_height;
var horizon = cam_height * 0.8;
var horizon_line = cam_top + horizon;
draw_sprite_stretched(jam_spr_skyline, 0, cam_left, cam_top, cam_width, horizon);
draw_rectangle_colour(cam_left, horizon_line, cam_right, cam_bottom, JAM_SKYLINE_TOP, JAM_SKYLINE_TOP, JAM_SKYLINE_BOTTOM, JAM_SKYLINE_BOTTOM, false);
//draw_line_colour(mouse_x - 30, mouse_y, mouse_x + 30, mouse_y, sea_top, sea_top);
jam_wanda_sealine_spawn_particles(partSys, cam_left, horizon_line, cam_right, cam_bottom);
cloudTimer -= cloudCountdown;
islandTimer -= islandCountdown;
if (cloudTimer < 0) {
    cloudTimer = 1;
    jam_wanda_skyline_spawn_particles(partSysCloud, cam_left, cam_top, cam_right, cam_bottom);
    jam_wanda_island_spawn_particles(partSys, cam_right, cam_top, cam_right, horizon_line);
}
if (islandTimer < 0) {
    islandTimer = 1;
}
var padding = sprite_get_width(jam_spr_island);
draw_sprite(jam_spr_island, 0, lerp(cam_left - padding, cam_right + padding, islandTimer), horizon_line);
part_system_drawit(partSys);