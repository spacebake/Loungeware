// sandveech_bg_obj_item.create

#region Initialization

	// scatters item randomly around the play area
	x		= irandom_range(32, room_width - 32);
	y		= irandom_range(32, room_height - 32);
	
	vdir	= 0;
	hdir	= 0;

#endregion

#region gameplay

	slide_speed = 0;
	min_slide_speed = 0;
	max_slide_speed = 4;
	acceleration = 0.09;
	isGrabbed = false;
	
	knockback = 4;
	angle = 0;
	
	decelerate			= function() {
		slide_speed = lerp(slide_speed, min_slide_speed, acceleration);
		angle = lerp(angle, angle + max_slide_speed, slide_speed);
	};
	add_to_plate		= function() {
		var _game = sandveech_bg_obj_game;
		
		if (instance_exists(_game)) {
			array_push(_game.plate_list, object_index);	
		}
	};
	check_correct_item	= function() {
		var _game = sandveech_bg_obj_game;
		
		for (var i = 0; i < array_length(_game.order_list); i++) {
			if (object_index == _game.order_list[i]) {
				return true;	
			}
		}
		
		return false;
	};

#endregion