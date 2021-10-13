/// @desc Update position.
var dir_strafe = freezePlayer ? 0 : KEY_RIGHT - KEY_LEFT;
var dir_up = freezePlayer ? 0 : KEY_UP - KEY_DOWN;
var scale_x = 1;
var scale_y = 0.5;
offX += lengthdir_x(dir_up, angle) - lengthdir_y(dir_strafe, angle);
offY += lengthdir_y(dir_up, angle) + lengthdir_x(dir_strafe, angle);
vX[@ 0] = scale_x * -lengthdir_y(1, angle);
vX[@ 1] = scale_y * -lengthdir_x(1, angle);
vY[@ 0] = scale_x * lengthdir_x(1, angle);
vY[@ 1] = scale_y * -lengthdir_y(1, angle);
// update camera angle
if (fallTimer == -1) {
    var cam_trail_threshold = 20;
    if (point_distance(trailX, trailY, offX, offY) > cam_trail_threshold) {
        targetAngle = point_direction(trailX, trailY, offX, offY);
        trailX = offX - lengthdir_x(cam_trail_threshold, targetAngle);
        trailY = offY - lengthdir_y(cam_trail_threshold, targetAngle);
    }
}
var angle_diff = angle_difference(angle, targetAngle);
angle -= angle_diff * 0.025;
// update sprite
if (fallTimer != -1) {
    fallTimer += 0.01;
    flipY = false; // always look forwards
    if (fallTimer < 0.5) {
        image_index = 1;
    }
} else if (dir_up == 0 && dir_strafe == 0) {
    image_index = 0;
} else {
    if (dir_up != 0) {
        flipY = dir_up > 0;
    }
    if (dir_strafe != 0) {
        flipX = dir_strafe < 0;
    }
    var images = [1, 2, 3, 2];
    image_index = images[floor(current_time * 0.005 % 4)];
}