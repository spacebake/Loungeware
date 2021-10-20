/// @desc Update particles.
x += xspeed;
y += yspeed;
z += zspeed;
time += 1 / game_get_speed(gamespeed_fps);
xspeed += wobble * dsin((time + 0 * 270) * wobbleSpeed);
yspeed += wobble * dsin((time + 1 * 270) * wobbleSpeed);
zspeed += wobble * dsin((time + 2 * 270) * wobbleSpeed);
if (time > lifetime) {
    instance_destroy();
}