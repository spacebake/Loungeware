
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
z_spd -= grav;
z += z_spd;
scale -= 0.001;
if (z < 0) or (scale <= 0) instance_destroy();