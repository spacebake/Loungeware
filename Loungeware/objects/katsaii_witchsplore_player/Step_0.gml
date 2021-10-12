/// @desc Update position.
var dir_strafe = KEY_RIGHT - KEY_LEFT;
var dir_up = KEY_UP - KEY_DOWN;
var scale_x = 1;
var scale_y = 0.75;
offX += lengthdir_x(dir_up, angle) - lengthdir_y(dir_strafe, angle);
offY += lengthdir_y(dir_up, angle) + lengthdir_x(dir_strafe, angle);
vX[@ 0] = scale_x * -lengthdir_y(1, angle);
vX[@ 1] = scale_y * -lengthdir_x(1, angle);
vY[@ 0] = scale_x * lengthdir_x(1, angle);
vY[@ 1] = scale_y * -lengthdir_y(1, angle);
// update camera angle
var cam_trail_threshold = 20;
if (point_distance(trailX, trailY, offX, offY) > cam_trail_threshold) {
    targetAngle = point_direction(trailX, trailY, offX, offY);
    trailX = offX - lengthdir_x(cam_trail_threshold, targetAngle);
    trailY = offY - lengthdir_y(cam_trail_threshold, targetAngle);
}
var angle_diff = angle_difference(angle, targetAngle);
angle -= angle_diff * 0.025;