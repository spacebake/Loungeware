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
#region Collisions
	
	
	var hsp = lengthdir_x(velocity, direction);
	var vsp = lengthdir_y(velocity, direction);
	
	hsp_remaining += hsp;
	repeat(abs(hsp_remaining)) {
      
	  hsp_remaining = approach(hsp_remaining, 0, 1);
	  var _dir = sign(hsp);
      
	  // Check for tile collision
	  if (place_meeting(x + _dir, y, objfrog_pp_o_collision_parent)) {
	    hsp = 0;
	    hsp_remaining = 0;
		rotation_direction = 0;
	    break;
	  }
	  x += _dir;
	}
	
	vsp_remaining += vsp;
	repeat(abs(vsp_remaining)) {
      
	  vsp_remaining = approach(vsp_remaining, 0, 1);
	  var _dir = sign(vsp);
      
	  // Check for tile collision
	  if (place_meeting(x, y + _dir, objfrog_pp_o_collision_parent)) {
	    vsp = 0;
	    vsp_remaining = 0;
		rotation_direction = 0;
	    break;
	  }
	  y += _dir;
	}
	
	
	
	
#endregion
#region Rotation


	if (KEY_RIGHT) {
		rotation_direction = -1 * sign(velocity); // sign(velocity) is to flip direction in reverse
	} else if (KEY_LEFT) {
		rotation_direction = 1 * sign(velocity); // sign(velocity) is to flip direction in reverse
	} else {
		rotation_direction = 0;	
	}
	
	// Turn slower as you're moving slower
	direction += rotation_direction * (abs(hsp) + abs(vsp)) * 1.5;
	image_angle = direction;
	

#endregion