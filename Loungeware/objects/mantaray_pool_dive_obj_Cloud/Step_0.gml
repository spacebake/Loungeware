x += dir * spd;

if (x < -sprite_width || x > room_width+sprite_width) {
	instance_destroy();
}
