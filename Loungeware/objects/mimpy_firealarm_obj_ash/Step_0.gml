y -= spd;
spd *= 0.8;
size -= 0.1;
image_xscale = size;
image_yscale = size;

if (size <= 0) {
	instance_destroy();
}