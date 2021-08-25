/// @desc Destroy particle if it exits the view.
var cam = KATSAII_WITCH_WANDA_VIEW_CAM;
var cam_left = camera_get_view_x(cam);
var cam_top = camera_get_view_y(cam);
var cam_right = cam_left + camera_get_view_width(cam);
var cam_bottom = cam_top + camera_get_view_height(cam);
var destroy = false;
if (x > cam_right) {
    destroy = true;
} else if (x < cam_left || y < cam_top || y > cam_bottom) {
    if not (immunityToBeingDestroyed) {
        destroy = true;
    }
} else {
    immunityToBeingDestroyed = false;
}
if (destroy) {
    instance_destroy();
}