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


	// sign(velocity) is to flip direction in reverse
	var rotation_direction = (KEY_LEFT - KEY_RIGHT) * sign(velocity);
	
	var hsp = lengthdir_x(velocity, direction);
	var vsp = lengthdir_y(velocity, direction);
	var next_angle_change = rotation_direction * (abs(hsp) + abs(vsp)) * 1.6;
	
	// Do it again with the wanted direction
	hsp = lengthdir_x(velocity, direction + next_angle_change);
	vsp = lengthdir_y(velocity, direction + next_angle_change);
	
	
	hsp_remaining += hsp;
	repeat(abs(hsp_remaining)) {
      
	  hsp_remaining = approach(hsp_remaining, 0, 1);
	  var _dir = sign(hsp);
      
	  // Check for collision
	  if (place_meeting(x + _dir, y, objfrog_pp_o_collision_parent)) {
	    hsp = 0;
	    hsp_remaining = 0;
		rotation_direction = 0;
		next_angle_change = 0;
	    break;
	  }
	  x += _dir;
	}
	
	vsp_remaining += vsp;
	repeat(abs(vsp_remaining)) {
      
	  vsp_remaining = approach(vsp_remaining, 0, 1);
	  var _dir = sign(vsp);
      
	  // Check for collision
	  if (place_meeting(x, y + _dir, objfrog_pp_o_collision_parent)) {
	    vsp = 0;
	    vsp_remaining = 0;
		rotation_direction = 0;
		next_angle_change = 0;
	    break;
	  }
	  y += _dir;
	}
	
	x = clamp(x, 0, room_width);
	y = clamp(y, 0, room_height);
	
	
#endregion
#region Rotate
	
	
	if !(place_meeting(x + hsp, y, objfrog_pp_o_collision_parent) && place_meeting(x, y + vsp, objfrog_pp_o_collision_parent)) {
		direction += next_angle_change;
		image_angle = direction;
	}
	

#endregion
