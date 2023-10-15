___state_handler()
var _cursor_previous = cursor;
var _rebind_index_previous = rebind_index;

if (KEY_UP_RELEASED || KEY_DOWN_RELEASED || KEY_UP_PRESSED || KEY_DOWN_PRESSED) {
	can_scroll = true;	
}

if (state == "normal") {
	var dy = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
	cursor = (cursor + dy) % array_length(menu);
	if (cursor < 0) {cursor = array_length(menu)-1;}
	
	if (KEY_PRIMARY_PRESSED) {
		op_result = menu[cursor].op();
		if (op_result != "noop") {
			confirmed = true;
			___sound_menu_select();
		} else {
			___sound_menu_back();	
		}
	}

	if (KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape)) {
		state = "fadeout_back";
		fadeout_do = back_to_main;
		if (!is_undefined(sng_id)) {audio_sound_gain(sng_id, 0, 100);}
	}	
} else if (state == "key_controls") {
	
	if (listening && keyboard_check_pressed(vk_anykey) && !___array_exists(rejects, keyboard_lastkey)) {
		can_scroll = false;
		var _reject_bind = false;
		var _bind_already_set = false;
		for (var i=0;i<array_length(keyboard_rebinds);i++) {
			if (___array_exists(keyboard_rebinds_values_right(i), keyboard_lastkey)) {
				if (i == rebind_index) {
					_bind_already_set = true;
					continue;
				} else {
					//_reject_bind = true;
					for (var j=0;j<array_length(keyboard_rebinds_values_right(i));j++) {
						if (keyboard_rebinds_values_right(i)[j] == keyboard_lastkey) {
							array_delete(keyboard_rebinds_values_right(i), j, 1);
							break;
						}
					}
				}
			}
		}
		if (!_reject_bind) {
			if (!_bind_already_set) {add_key(rebind_index, keyboard_lastkey, false);}
			___sound_menu_select();
			listening = false;
		} else {
			___sound_menu_error();	
		}
	}
	
	//ADD A KEY
	if (KEY_PRIMARY_PRESSED && rebinds_t != 0 && !just_listening) {
		listening = true;
		___sound_menu_tick_horizontal();
	}
	
	//CLEAR REBINDS
	if (KEY_SECONDARY_PRESSED && !just_listening) {
		clear_rebinds(rebind_index, false);
		___sound_menu_back();
		listening = true;
		___sound_menu_tick_horizontal();
	}
	
	if (!just_listening) {
		var dy = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		if (can_scroll) {
			rebind_index = ___mod2(rebind_index + dy, array_length(keyboard_rebinds));
		}
	}
	
	
	rebinds_t++;
	
	just_listening = listening;

} else if (state == "gamepad_controls") {
	
	var isAxis = gamepad_rebinds[rebind_index] == "h axis" || gamepad_rebinds[rebind_index] == "v axis";
	
	if (isAxis) {
		
		var last_gamepad_axis = undefined;
	
		for (var i=0;i<array_length(___global.controller_values);i++) {
			if (!___global.controller_values[i].active) continue;
		
			for (var j = 0; j < gamepad_axis_count(i); j++) {
				if (gamepad_axis_value(i, j) != 0) {
					last_gamepad_axis = j;
					break;
				}
			}
		}
		
		//if (listening && keyboard_check_pressed(vk_anykey) && !___array_exists(rejects, keyboard_lastkey) && 
		//!___array_exists(keyboard_rebinds_values_right(rebind_index), keyboard_lastkey)) {
		
		if (listening && last_gamepad_axis != undefined) {
			listening = false;
			can_scroll = false;
			if (!___array_exists(gamepad_rebinds_values_right(rebind_index).indexes, last_gamepad_axis)) {
				add_key(rebind_index, last_gamepad_axis, true);
			}
		}
		
	} else {
		
		var last_gamepad_button = undefined;
	
		for (var i=0;i<array_length(___global.controller_values);i++) {
			if (!___global.controller_values[i].active) continue;
		
			//someone has better way of checking all buttons? this doesnt get all of them
			for ( var j = gp_face1; j < gp_axisrv; j++ ) {
			    if ( gamepad_button_check_pressed( i, j ) ) {
					last_gamepad_button = i;
					break;
				}
			}
			
			//for (var j = 0; j < gamepad_button_count(i); j++) {
			//	if (gamepad_button_check(i, j)) {
			//		last_gamepad_button = i;
			//		break;
			//	}
			//}
		}
		
		//if (listening && keyboard_check_pressed(vk_anykey) && !___array_exists(rejects, keyboard_lastkey) && 
		//!___array_exists(keyboard_rebinds_values_right(rebind_index), keyboard_lastkey)) {
		if (listening && last_gamepad_button != undefined) {
			listening = false;
			can_scroll = false;
			if (!___array_exists(gamepad_rebinds_values_right(rebind_index).indexes, last_gamepad_button)) {
				add_key(rebind_index, last_gamepad_button, true);
			}
		}
	}
	
	//ADD A KEY
	if (KEY_PRIMARY_PRESSED && rebinds_t != 0 && !just_listening) {
		listening = true;
		___sound_menu_tick_horizontal();
	}
	
	//CLEAR REBINDS
	if (KEY_SECONDARY_PRESSED && !just_listening) {
		clear_rebinds(rebind_index, false);
		___sound_menu_error();
		listening = false;
		just_listening = false;
	}
	
	
	if (!just_listening) {
		var dy = ___menu_sign_timed_input_vertical(-KEY_UP + KEY_DOWN);
		if (can_scroll) {
			rebind_index = ___mod2(rebind_index + dy, array_length(gamepad_rebinds));
		}
	}
	
	
	rebinds_t++;
	
	just_listening = listening;
	
	if (___KEY_PAUSE_PRESSED) {___sound_menu_back();}
} else if (state == "fadeout_back") {
	close_circle_prog = max(0, close_circle_prog - (1/20));
	if (close_wait_before > 0){
		close_wait_before -=1;
	} else {
		if (close_circle_prog <= 0) close_wait--;
		if (close_wait <= 0 && !fadeout_ended){
			fadeout_do();
			fadeout_ended = true;
		}
	}
}


if (state == "key_controls" || state == "gamepad_controls") {
	//log(pause_t);
	
	if (keyboard_check(vk_escape)) {
		pause_t++;
		
		// mutability is the root of all evil
		if (pause_t > 40) {
			listening = false;
			if (state == "key_controls") {
				//___global.curr_input_keys = ___global.default_input_keys;
				___struct_foreach(___global.curr_input_keys, function(_key, _value) {
					
					//default is a keyword??
					var default_ = ___global.default_input_keys[$ _key];
						
					___global.curr_input_keys[$ _key] = [];
					array_copy(___global.curr_input_keys[$ _key], 0, default_, 0, array_length(default_));
				});
				
			} else if (state == "gamepad_controls") {
				
				//___global.curr_controller_keys = ___global.default_controller_keys;
				___struct_foreach(___global.curr_controller_keys, function(_key, _value) {
					
					//default is a keyword??
					var default_ = ___global.default_controller_keys[$ _key];
						
					___global.curr_input_keys[$ _key] = [];
					array_copy(___global.curr_controller_keys[$ _key], 0, default_, 0, array_length(default_));
				});
				//___global.curr_controller_axes = ___global.default_controller_axes;
				___struct_foreach(___global.curr_controller_axes, function(_key, _value) {
					
					//default is a keyword??
					var default_ = ___global.default_controller_axes[$ _key];
						
					___global.curr_input_keys[$ _key] = [];
					array_copy(___global.curr_controller_axes[$ _key], 0, default_, 0, array_length(default_));
				});
			}
			if (!rebinds_just_reset) {
				___sound_menu_error();
			}
			rebinds_just_reset = true;
		}
		
	} else if (keyboard_check_released(vk_escape) && !rebinds_just_reset) {
		___state_change("normal");
		
		rebinds_t = 0;
		just_listening = false;
		listening = false;
		confirmed = false;
		pause_t = 0;
		rebinds_just_reset = false;
		
	} else {
		pause_t = 0;
		rebinds_just_reset = false;
	}
}

if (cursor != _cursor_previous || rebind_index != _rebind_index_previous) {
	___sound_menu_tick_vertical();
}


	//if (___KEY_PAUSE_PRESSED)
	//	___state_change("normal");
	//else if (KEY_ANY_PRESSED)
	//	rebinding = true;
	
	//if (rebinding) {
	//	//
	//	//if (KEY_PRIMARY) {
	//	//	if (KEY_ANY_RELEASED) {
	//	//		log(___global.keycode_to_str[___global.last_key])
				
	//	//		var arr = ___global.curr_input_keys[$ rebinds[rebind_index]];
				
	//	//		if (!___array_exists(arr, ___global.last_key)) {
	//	//			array_push(arr, ___global.last_key);
	//	//		}
	//	//	}
	//	//if (KEY_ANY && last_last_key == ___global.last_key) {
	//	//	rebind_hold++;
	//	//} else {
	//	//	rebind_hold = 0
			
	//	//	if (KEY_UP) 
	//	//		___global.curr_input_keys[$ rebinds[rebind_index]] = [];	
	//	//}
		
	//	//last_last_key = ___global.last_key;
		
	//	//if (rebind_hold > 10) {
	//	//	rebind_hold = 0;
			
	//	//	var arr = ___global.curr_input_keys[$ rebinds[rebind_index]];
			
	//	//	log(arr)
	//	//	if (!___array_exists(arr, ___global.last_key)) {
	//	//		array_push(arr, ___global.last_key);
	//	//	}
	//	//}
			
	//	////exit
	//	//if (KEY_SECONDARY_RELEASED && !___array_exists(arr, ___global.last_key)) {
	//	//	rebinding = false;
	//	//	rebind_index = 0;
	//	//}
			
	//	////reset mappings
	//	//if (KEY_UP_RELEASED) {
	//	//	___global.curr_input_keys[$ rebinds[rebind_index]] = [];	
	//	//}
			
	//	//var dx = KEY_RIGHT_PRESSED - KEY_LEFT_PRESSED;
	//	//rebind_index = clamp(rebind_index + dx, 0, array_length(rebinds) - 1);
		
		
	//	//if (listen_for_rebind && KEY_ANY_PRESSED) {
	//	//	log(___global.keycode_to_str[___global.last_key])
			
	//	//	array_push(___global.curr_input_keys[$ rebinds[rebind_index]], ___global.last_key);
	//	//	listen_for_rebind = false;
	//	//}	
		
	//	//if (KEY_PRIMARY_PRESSED) {
	//	//	listen_for_rebind = true;
	//	//}
		
	//	//if (KEY_SECONDARY_PRESSED) {
	//	//	rebind_index++;
			
	//	//	if (rebind_index == array_length(rebinds)) {
	//	//		rebinding = false;
	//	//		rebind_index = 0;	
	//	//	}
	//	//}
	//}
