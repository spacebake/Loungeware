/// @desc Update position.
var dir_strafe = freezePlayer ? 0 : KEY_RIGHT - KEY_LEFT;
var dir_up = freezePlayer ? 0 : KEY_UP - KEY_DOWN;
if (allowJump) {
    if (!freezePlayer && jumpTimer == -1 && KEY_PRIMARY) {
        allowJump = false;
        jumpTimer = 0;
        sfx_play(katsaii_wandaxplore_jump, 0.25, false);
        // set image index prematurely
        image_index = flipY ? 13 : 12;
        flipY = false; // silly hack because of how the jump animation is set up
    }
} else if (KEY_PRIMARY_RELEASED) {
    allowJump = true;
}
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
angle -= angle_diff * 0.01;
// update sprite
if (jumpTimer != -1) {
    var jump_prev = jumpTimer;
    jumpTimer += 0.03;
    if (jump_prev < 0.5 && jumpTimer >= 0.5) {
        image_index = image_index == 13 ? 5 : 1;
    }
    if (jumpTimer > 1) {
        jumpTimer = -1;
        flipY = image_index == 13 || image_index == 5;
        image_index = 0;
    }
} else if (fallTimer != -1) {
    var last_time = fallTimer;
    fallTimer += 0.01;
    if (last_time < 0.5 && fallTimer >= 0.5) {
        var snd = sfx_play(katsaii_wandaxplore_fail, 1, false);
        audio_sound_pitch(snd, choose(1.2, 1.3, 1.1));
    }
    flipY = false; // always look forwards
    if (fallTimer < 0.5) {
        image_index = 1;
    } else {
        depth = 1000; // so that depth sorting with islands works correctly
        image_index = floor(lerp(8, 11.5, (fallTimer - 0.5) * 2));
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