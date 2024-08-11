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
	
	// out of bounds prevention
	xx = clamp(xx, 24, room_width - 24);
	yy = clamp(yy, 24, room_height - 16);

	// smoother hand movement
	x = lerp(x, xx, 0.3);
	y = lerp(y, yy, 0.3);

#endregion

#region gamemplay

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