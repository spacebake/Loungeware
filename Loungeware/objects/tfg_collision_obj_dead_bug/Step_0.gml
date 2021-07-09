t++;
image_angle += abs(sin(t)) * 10;
vspeed += 0.3;

if (bbox_top > room_height) instance_destroy();

image_xscale += 0.03;
image_yscale += 0.03;