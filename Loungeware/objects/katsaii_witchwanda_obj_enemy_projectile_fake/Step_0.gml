/// @desc Destroy projectile if it exits the view.
var cam = KATSAII_WITCH_WANDA_VIEW_CAM;
var cam_left = camera_get_view_x(cam);
var cam_top = camera_get_view_y(cam);
var cam_right = cam_left + camera_get_view_width(cam);
var cam_bottom = cam_top + camera_get_view_height(cam);
if (x > cam_right || x < cam_left || y < cam_top || y > cam_bottom) {
    instance_destroy();
}
image_angle += rot;