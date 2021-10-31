// Controls
if (KEY_RIGHT) {
	direction -= spin_speed;	
}

if (KEY_LEFT) {
	direction += spin_speed;	
}

if (KEY_PRIMARY_PRESSED) {
	// Create bullet
	var bullet_depth = (image_index == 1) ? depth + 2 : depth - 1;
	var bullet_x = x + lengthdir_x(16, direction);
	var bullet_y = y + lengthdir_y(16, direction);
	var bullet = instance_create_depth(bullet_x, bullet_y - gun_height, bullet_depth, objfrog_ys_o_bullet);
	bullet.direction = direction;
	bullet.image_angle = direction;
	bullet.speed = 10;
	
	// Create muzzle flash
	var muzzle_flash_depth = (image_index == 1) ? depth + 1 : depth - 2;
	var muzzle_flash = instance_create_depth(bullet_x, bullet_y - gun_height, muzzle_flash_depth, objfrog_ys_o_muzzle_flash);
	muzzle_flash.image_angle = direction;
	
	audio_play_sound(objfrog_ys_sfx_shoot, 0, false);
}

// Rotation
image_index = (direction + 45) div 90;
