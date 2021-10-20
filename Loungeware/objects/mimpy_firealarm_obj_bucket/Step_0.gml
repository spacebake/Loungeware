var input = KEY_RIGHT - KEY_LEFT;
if (input != 0) {
	hsp = clamp(hsp + input * accel, -max_spd, max_spd);
}
else {
	hsp = median(hsp - sign(hsp) * accel, hsp, 0);
}
x = clamp(x + hsp, 0, room_width);

image_angle = -3 * hsp;

if (KEY_PRIMARY_PRESSED && ammo > 0) {
	ammo--;
	image_index = 5 - ammo;
	var inst = instance_create_layer(x + lengthdir_x(48, image_angle - 90), y + lengthdir_y(48, image_angle - 90), "Droplet", mimpy_firealarm_obj_droplet);
	sfx_play(mimpy_firealarm_drop, 1, false);
}