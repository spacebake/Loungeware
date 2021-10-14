/// @desc Check collisions.
if (jumpTimer != -1) {
    exit;
}
var collision = false;
var off_x = offX;
var off_y = offY;
var hitbox_radius = 5;
with (katsaii_wandaxplore_collider) {
    var pos_x = clamp(off_x, xstart - width / 2, xstart + width / 2);
    var pos_y = clamp(off_y, ystart - height / 2, ystart + height / 2);
    if (point_distance(off_x, off_y, pos_x, pos_y) < hitbox_radius) {
        collision = true;
    }
}
if (!collision && fallTimer == -1) {
    microgame_fail();
    fallTimer = 0;
    freezePlayer = true;
    alarm[0] = 2 * game_get_speed(gamespeed_fps);
    targetAngle += 180;
}