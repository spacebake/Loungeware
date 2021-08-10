
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);
z_spd -= grav;
z += z_spd;
scale_x -= 0.001;
scale_y = scale_x;
scale_z = scale_x;
if (z < 0) or (scale_x < 0) instance_destroy();