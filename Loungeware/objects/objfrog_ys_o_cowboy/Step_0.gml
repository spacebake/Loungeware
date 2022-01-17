#region Spinning

	
	if (KEY_RIGHT) {
		spin_amount -= spin_accel;	
	} else if (KEY_LEFT) {
		spin_amount += spin_accel;
	} else {
		spin_amount = approach(spin_amount, 0, 2);
	}
	
	var minimum = -5 + (5 - DIFFICULTY) * 0.4;
	var maximum = 5 - (5 - DIFFICULTY) * 0.4;
	spin_amount = clamp(spin_amount, minimum, maximum);
	direction += spin_amount

	// Body rotation
	image_index = (direction + 45) div 90;


#endregion
#region Shooting


	if (KEY_PRIMARY_PRESSED && shooting_allowed) {
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
	
		shooting_allowed = false;
		alarm[0] = room_speed * .2;
	
		sfx_play(objfrog_ys_sfx_shoot, 1, false);
	}
	
	
#endregion
