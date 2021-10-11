/// @desc Update position.
var dir_x = KEY_RIGHT - KEY_LEFT;
var dir_y = KEY_DOWN - KEY_UP;
var dir_angle = KEY_SECONDARY - KEY_PRIMARY;
var scale_x = 1;
var scale_y = 0.75;
offX += dir_x;
offY += dir_y;
angle += dir_angle * 2;
vX[@ 0] = scale_x * -lengthdir_y(1, angle);
vX[@ 1] = scale_y * -lengthdir_x(1, angle);
vY[@ 0] = scale_x * lengthdir_x(1, angle);
vY[@ 1] = scale_y * -lengthdir_y(1, angle);
/*
var cam_trail_threshold = 10;
var mag = point_distance(trailX, trailY, offX, offY);
if (mag > cam_trail_threshold) {
    targetAngle = point_direction(trailX, trailY, offX, offY);
    trailX = offX - lengthdir_x(cam_trail_threshold, targetAngle);
    trailY = offY - lengthdir_y(cam_trail_threshold, targetAngle);
    targetAngle = -targetAngle - 90;
}
// interpolate to angle
var angle_diff = angle_difference(angle, targetAngle);
angle -= angle_diff * 0.1;
*/