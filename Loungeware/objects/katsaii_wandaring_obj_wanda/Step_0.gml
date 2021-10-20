/// @desc Update position and angle.
if (respawnTimer != -1) {
    respawnTimer += 0.025;
    if (respawnTimer >= 2) {
        microgame_end_early();
    }
}
zprevious = z;
var dir_x = katsaii_wandaring_input_direction(keyboard_check, [vk_right, ord("D")], [vk_left, ord("A")]);
var dir_y = katsaii_wandaring_input_direction(keyboard_check, [vk_down, ord("S")], [vk_up, ord("W")]);
if (instance_exists(katsaii_wandaring_obj_gameend)) {
    dir_x = 0;
    dir_y = 0;
}
targetAngle += 45 * katsaii_wandaring_input_direction(keyboard_check_pressed, [ord("Q")], [ord("E")]);
x += dir_y * -dsin(katsaii_wandaring_obj_control.angle) + dir_x * dcos(katsaii_wandaring_obj_control.angle);
y += dir_y * dcos(katsaii_wandaring_obj_control.angle) + dir_x * dsin(katsaii_wandaring_obj_control.angle);
var diff = -angle_difference(katsaii_wandaring_obj_control.angle, targetAngle);
katsaii_wandaring_obj_control.angle += diff * 0.1;
if (instance_exists(katsaii_wandaring_obj_gameend)) {
    exit;
}
// jump
if (allowJump) {
    if (jumpTimer == -1 && katsaii_wandaring_input(keyboard_check, [vk_space, ord("X"), vk_enter])) {
        allowJump = false;
        jumpTimer = 0;
        jumpZ = z;
        jumpParity = !jumpParity;
        var snd = sfx_play(katsaii_wandaring_snd_jump, 0, false);
        audio_sound_gain(snd, choose(1.5, 1.75), 0);
        audio_sound_pitch(snd, choose(0.8, 1.25, 1.5));
    }
} else if (katsaii_wandaring_input(keyboard_check_released, [vk_space, ord("X"), vk_enter])) {
    allowJump = true;
}
// update sprite
var moving = x != xprevious || y != yprevious;
if (moving) {
    movementAngle = point_direction(xprevious, yprevious, x, y);
}
var facing = floor((angle_difference(-katsaii_wandaring_obj_control.angle, movementAngle) + 360 + 45) % 360 / 90) % 4;
var sprites = subimages[facing];
flip = sprites.flip;
if (jumpTimer != -1) {
    jumpTimer += 0.03;
    image_index = sprites.jump[jumpParity ? 0 : 1];
    z = jumpZ - jumpHeight * (1 - (2 * jumpTimer - 1) * (2 * jumpTimer - 1));
    if (z > 0 && respawnTimer == -1) {
        // death
        respawnTimer = 0;
        var snd = sfx_play(katsaii_wandaring_snd_death, 0, false);
        audio_sound_gain(snd, choose(1, 1.75), 0);
        audio_sound_pitch(snd, choose(0.8, 1.25, 1.5));
    }
} else if (moving) {
    var frame_idx = (current_time * 0.005) % 4;
    image_index = sprites.walk[frame_idx];
} else {
    image_index = sprites.idle;
}
// collision check
var hitbox_radius = 5;
var grounded = false;
with (katsaii_wandaring_obj_platform) {
    var pos_x = clamp(other.x, x, x + CELL_SIZE);
    var pos_y = clamp(other.y, y, y + CELL_SIZE);
    var pos_distance = point_distance(pos_x, pos_y, other.x, other.y);
    if (pos_distance >= hitbox_radius) {
        // outside of collider
        continue;
    }
    if (abs(other.z - z) < 1) {
        grounded = true;
    }
    if (other.z > z && other.zprevious <= z) {
        other.z = z;
        other.jumpTimer = -1;
        other.lastPlatform = id;
    } else if (other.z > z) {
        var push_angle = point_direction(pos_x, pos_y, other.x, other.y);
        var push_distance = hitbox_radius - pos_distance;
        other.x += lengthdir_x(push_distance, push_angle);
        other.y += lengthdir_y(push_distance, push_angle);
    }
}
if (!grounded && jumpTimer == -1) {
    jumpTimer = 0.5;
    jumpZ = z + jumpHeight;
    jumpParity = !jumpParity;
}
if (respawnTimer == -1) {
    katsaii_wandaring_obj_control.posX = x;
    katsaii_wandaring_obj_control.posY = y;
    katsaii_wandaring_obj_control.posZ = z;
}
// collide with stars
var hitbox_radius_collectible = 20;
with (katsaii_wandaring_obj_star) {
    if (point_distance_3d(other.x, other.y, other.z, x, y, z) >= hitbox_radius_collectible) {
        // outside of star
        continue;
    }
    if (follow == noone) {
        follow = katsaii_wandaring_obj_wanda;
        var prev_star = other.heldStar;
        if (prev_star != noone) {
            prev_star.follow = id;
        }
        other.heldStar = id;
        other.starsCollected += 1;
        var snd = sfx_play(katsaii_wandaring_snd_collect, 0, false);
        audio_sound_gain(snd, choose(2, 2.75), 0);
        audio_sound_pitch(snd, choose(0.8, 1.25, 1.5));
    }
}
if (starsCollected >= instance_number(katsaii_wandaring_obj_star)) {
    // WINNER!
    instance_create_layer(0, 0, layer, katsaii_wandaring_obj_gameend);
}