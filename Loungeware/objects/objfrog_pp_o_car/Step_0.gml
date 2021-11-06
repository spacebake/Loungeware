depth = -y;

#region Acceleration


	if (KEY_PRIMARY) {
		velocity += acceleration;
	} else if (KEY_SECONDARY) {
		velocity -= acceleration;
	} else {
		velocity = approach(velocity, 0, fric);
	}

	velocity = clamp(velocity, max_reverse_speed, max_forward_speed);
	
	
#endregion
#region Rotation


	if (KEY_RIGHT) {
		rotation_direction = -1 * sign(velocity); // sign(velocity) is to flip direction in reverse
	} else if (KEY_LEFT) {
		rotation_direction = 1 * sign(velocity); // sign(velocity) is to flip direction in reverse
	} else {
		rotation_direction = 0;	
	}
	

#endregion
#region Collisions
	
	
	var hsp = lengthdir_x(velocity, direction);
	var vsp = lengthdir_y(velocity, direction);
	
	if (place_meeting(x + hsp, y, objfrog_pp_o_collision_parent)) {
		while (!place_meeting(x + sign(hsp), y, objfrog_pp_o_collision_parent)) {
			x += sign(hsp);
		}
		hsp = 0;
		velocity = 0;
	}
	x += hsp;
	
	if (place_meeting(x, y + vsp, objfrog_pp_o_collision_parent)) {
		while (!place_meeting(x, y + sign(vsp), objfrog_pp_o_collision_parent)) {
			y += sign(vsp);
		}
		vsp = 0;
		velocity = 0;
	}
	y += vsp;
	
	
	// Turn slower as you're moving slower
	direction += rotation_direction * (abs(hsp) + abs(vsp)) * 1.5;
	image_angle = direction;
	
	
#endregion