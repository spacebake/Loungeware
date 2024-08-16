// sandveech_bg_obj_arm.create

#region initialization

	image_speed		= 0;
	x				= room_width / 2;

	xx				= x;
	yy				= y;

	sprite			= 0;

	hspd			= 0;
	vspd			= 0;

#endregion

#region states

	enum HAND_STATE {
		FREE,
		GRAB,
	
		SIZE
	}

	state_set = function(_state) {
		state = _state;
	};
	state_get = function() {
		return state;	
	};

	state_set(HAND_STATE.FREE);

#endregion

#region sprites

	enum HAND_SPRITE {
		FREE,
		GRAB,
		
		SIZE
	};
	
	sprite_set = function(_sprite) {
		sprite = _sprite;	
	};

#endregion

#region gameplay

	arm_speed		= 0;
	min_arm_speed	= 0;
	max_arm_speed	= 12;
	arm_randx		= 0;
	arm_randy		= 0;
	acceleration	= 0.09;
	held_item		= noone;
	near = noone;
	item = noone;

	grab		= function() {
		if (item) && (near) && (!near.added){
			near.isGrabbed = true;
			held_item = near;
	
			sprite_set(HAND_SPRITE.GRAB);
			state_set(HAND_STATE.GRAB);
		}
	};
	release		= function() {
		if (!held_item.added) {
			held_item.isGrabbed = false;
			held_item.slide_speed = clamp(arm_speed, min_arm_speed, 6);
			held_item = noone;
	
			sprite_set(HAND_SPRITE.FREE);
			state_set(HAND_STATE.FREE);	
		}
	};
	accelerate	= function() {
		arm_speed = lerp(arm_speed, max_arm_speed, acceleration);
	};
	decelerate	= function() {
		arm_speed = lerp(arm_speed, min_arm_speed, acceleration);
	};

#endregion