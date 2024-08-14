// sandveech_bg_obj_arm.step

#region movement

	hspd = KEY_RIGHT - KEY_LEFT;
	vspd = KEY_DOWN - KEY_UP;
		
	xx += hspd * arm_speed;
	yy += vspd * arm_speed;
	
	// acceleration & deceleration
	if (hspd != 0 || vspd != 0) {
		accelerate();
	}
	else {
		decelerate();	
	}
	
	arm_randx = 0;
	arm_randy = 0;
	
	if (state_get() == HAND_STATE.GRAB) && (held_item != noone) {
		arm_randx = irandom_range(-1, 1);
		arm_randy = irandom_range(-1, 1);
	}
	
	// out of bounds prevention
	xx = clamp(xx, 24, room_width - 24) + arm_randx;
	yy = clamp(yy, 24, room_height - 16) + arm_randy;

	// smoother hand movement
	x = lerp(x, xx, 0.3);
	y = lerp(y, yy, 0.3);

#endregion

#region gamemplay

	near = instance_nearest(x, y, sandveech_bg_obj_item);
	item = instance_place(x, y, sandveech_bg_obj_item);
	
	// grab item
	if (KEY_PRIMARY_PRESSED) {
		if (state_get() == HAND_STATE.FREE && held_item == noone) {
			grab();	
		}
	}

	// release item from hand
	if (KEY_SECONDARY_PRESSED) {
		if (state_get() == HAND_STATE.GRAB && held_item != noone) {
			release();	
		}
	}

#endregion