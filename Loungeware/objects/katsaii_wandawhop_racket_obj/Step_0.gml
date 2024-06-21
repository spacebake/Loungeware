var xdir = KEY_RIGHT - KEY_LEFT;
var ydir = KEY_DOWN - KEY_UP;

hspeed += xdir;
if (abs(hspeed) > 0.01) {
	hspeed -= 0.5 * sign(hspeed);
} else {
	hspeed = 0;
}

vspeed += ydir;
if (abs(vspeed) > 0.01) {
	vspeed -= 0.5 * sign(vspeed);
} else {
	vspeed = 0;
}

if (x < 0 || x > room_width) {
	hspeed = -hspeed;
	x = clamp(x, 0, room_width);
}

if (y < 0 || y > room_height) {
	vspeed = -vspeed;
	y = clamp(y, 0, room_height);
}

image_angle = -hspeed + 0.5 * vspeed;

bounce += bounceTimer;
if (bounce > 1) {
    bounce = 1;
}