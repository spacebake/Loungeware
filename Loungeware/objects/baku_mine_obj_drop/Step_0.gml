
squish_xy = lerp(squish_xy, 1, 0.1);
squish_z  = lerp(squish_z,  1, 0.1);

z_spd -= grav;
z += z_spd;
if z < z_og {
	z = z_og;
	if z_bounce <= 0.5 z_bounce = 0; else z_bounce /= 2;
	z_spd = z_bounce;
}

z_draw = z;