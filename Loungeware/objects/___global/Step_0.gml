
// stops songs that are marked for deletion when they hit 0 volume
for (var i = 0; i < ds_list_size(___song_stop_list); i++){
	var _sng = ___song_stop_list[| i];
	var _vol = audio_sound_get_gain(_sng);
	if (_vol <= 0){
		audio_stop_sound(_sng);
		ds_list_delete(___song_stop_list, i);
		i--;
	}
}




// controller updates
var _deadzone = 0.5;
for (var i=0;i<gamepad_get_device_count();i++) {
	controller_values[i].active = gamepad_is_connected(i);
	if (controller_values[i] == false) continue;
	var axes_hor = default_controller_axes.horizontal;
	var axes_vert = default_controller_axes.vertical;
	
	// horizontal
	var _hor_axis_max_value = 0;
	for (var j=0;j<array_length(axes_hor);j++) {
		var _axis_value = gamepad_axis_value(i,axes_hor[j]);
		if (abs(_axis_value) > abs(_hor_axis_max_value)) { 
			_hor_axis_max_value = _axis_value;
		}
	}
	controller_values[i].axes.horizontal = _hor_axis_max_value;
	
	// vertical
	var _vert_axis_max_value = 0;
	for (var j=0;j<array_length(axes_vert);j++) {
		var _axis_value = gamepad_axis_value(i,axes_vert[j]);
		if (abs(_axis_value) > abs(_vert_axis_max_value)) { 
			_vert_axis_max_value = _axis_value;
		}
	}
	controller_values[i].axes.vertical = _vert_axis_max_value;
	
	// up
	if (___gamepad_check_button_multiple(i,default_controller_keys.up)
		|| abs(_vert_axis_max_value) > _deadzone && sign(_vert_axis_max_value) == -1) {
		//
		if (controller_values[i].state.pressed.up == false) {
			if (controller_values[i].state.held.up == false) {
				controller_values[i].state.pressed.up = true;
			}
		} else {
			controller_values[i].state.pressed.up = false;
		}
		controller_values[i].state.held.up = true;
	} else {
		controller_values[i].state.pressed.up = false;
		controller_values[i].state.released.up = false;
		if (controller_values[i].state.held.up) {
			controller_values[i].state.released.up = true;
		}
		controller_values[i].state.held.up = false;
	}
	
	// down
	if (___gamepad_check_button_multiple(i,default_controller_keys.down)
		|| abs(_vert_axis_max_value) > _deadzone && sign(_vert_axis_max_value) == 1) {
		//
		if (controller_values[i].state.pressed.down == false) {
			if (controller_values[i].state.held.down == false) {
				controller_values[i].state.pressed.down = true;
			}
		} else {
			controller_values[i].state.pressed.down = false;
		}
		controller_values[i].state.held.down = true;
	} else {
		controller_values[i].state.pressed.down = false;
		controller_values[i].state.released.down = false;
		if (controller_values[i].state.held.down) {
			controller_values[i].state.released.down = true;
		}
		controller_values[i].state.held.down = false;
	}
	
	// left
	if (___gamepad_check_button_multiple(i,default_controller_keys.left)
		|| abs(_hor_axis_max_value) > _deadzone && sign(_hor_axis_max_value) == -1) {
		//
		if (controller_values[i].state.pressed.left == false) {
			if (controller_values[i].state.held.left == false) {
				controller_values[i].state.pressed.left = true;
			}
		} else {
			controller_values[i].state.pressed.left = false;
		}
		controller_values[i].state.held.left = true;
	} else {
		controller_values[i].state.pressed.left = false;
		controller_values[i].state.released.left = false;
		if (controller_values[i].state.held.left) {
			controller_values[i].state.released.left = true;
		}
		controller_values[i].state.held.left = false;
	}
	
	// right
	if (___gamepad_check_button_multiple(i,default_controller_keys.right)
		|| abs(_hor_axis_max_value) > _deadzone && sign(_hor_axis_max_value) == 1) {
		//
		if (controller_values[i].state.pressed.right == false) {
			if (controller_values[i].state.held.right == false) {
				controller_values[i].state.pressed.right = true;
			}
		} else {
			controller_values[i].state.pressed.right = false;	
		}
		controller_values[i].state.held.right = true;
		
	} else {
		controller_values[i].state.pressed.right = false;
		controller_values[i].state.released.right = false;
		if (controller_values[i].state.held.right) {
			controller_values[i].state.released.right = true;
		}
		controller_values[i].state.held.right = false;
	}
	
	
	// primary
	if (___gamepad_check_button_multiple(i,default_controller_keys.primary)) {
		//
		if (controller_values[i].state.pressed.primary == false) {
			if (controller_values[i].state.held.primary == false) {
				controller_values[i].state.pressed.primary = true;
			}
		} else {
			controller_values[i].state.pressed.primary = false;	
		}
		controller_values[i].state.held.primary = true;
		
	} else {
		controller_values[i].state.pressed.primary = false;
		controller_values[i].state.released.primary = false;
		if (controller_values[i].state.held.primary) {
			controller_values[i].state.released.primary = true;
		}
		controller_values[i].state.held.primary = false;
	}
	
	// secondary
	if (___gamepad_check_button_multiple(i,default_controller_keys.secondary)) {
		//
		if (controller_values[i].state.pressed.secondary == false) {
			if (controller_values[i].state.held.secondary == false) {
				controller_values[i].state.pressed.secondary = true;
			}
		} else {
			controller_values[i].state.pressed.secondary = false;	
		}
		controller_values[i].state.held.secondary = true;
		
	} else {
		controller_values[i].state.pressed.secondary = false;
		controller_values[i].state.released.secondary = false;
		if (controller_values[i].state.held.secondary) {
			controller_values[i].state.released.secondary = true;
		}
		controller_values[i].state.held.secondary = false;
	}
	
	// pause
	if (___gamepad_check_button_multiple(i,default_controller_keys.pause)) {
		//
		if (controller_values[i].state.pressed.pause == false) {
			if (controller_values[i].state.held.pause == false) {
				controller_values[i].state.pressed.pause = true;
			}
		} else {
			controller_values[i].state.pressed.pause = false;	
		}
		controller_values[i].state.held.pause = true;
		
	} else {
		controller_values[i].state.pressed.pause = false;
		controller_values[i].state.released.pause = false;
		if (controller_values[i].state.held.pause) {
			controller_values[i].state.released.pause = true;
		}
		controller_values[i].state.held.pause = false;
	}
	
}