t++;

var _str = mantaray_pool_dive_fnc_projectile_motion(t, 10, 45, 5);
if (y<=ystart) {
	x = xstart + _str.x;
	y = ystart - _str.y;
	image_angle += 0.1;
}

