x += hsp;

vsp += 0.2;
y += vsp;

size -= 0.05;
image_xscale = size;
image_yscale = size;
if (size <= 0)
	instance_destroy();