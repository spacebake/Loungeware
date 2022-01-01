___state_handler()

if (state == "normal") {
	var dy = ___keyboard_check_pressed("down") - ___keyboard_check_pressed("up");

	cursor = (cursor + dy) % array_length(menu);

	if (___keyboard_check_pressed("primary") || ___keyboard_check_pressed("secondary")) {
		confirmed = true
		menu[cursor].op();
	}

} else if (state == "key_controls") {
	
	if (listening && keyboard_check_pressed(vk_anykey) && !___array_exists(keyboard_rebinds_values_right(rebind_index), keyboard_lastkey)) {
		listening = false;
		
		add_key(rebind_index, keyboard_lastkey, false);
	}
	
	//ADD A KEY
	if (KEY_PRIMARY_PRESSED && rebinds_t != 0 && !just_listening) {
		listening = true;
	}
	
	//CLEAR REBINDS
	if (KEY_SECONDARY_PRESSED && !just_listening) {
		clear_rebinds(rebind_index, false);
		
		listening = false;
		just_listening = false;
	}
	
	
	if (!just_listening) {
		var dy = KEY_DOWN_PRESSED - KEY_UP_PRESSED;
		
		rebind_index = ___mod2(rebind_index + dy, array_length(keyboard_rebinds));
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
		
		if (listening && last_gamepad_axis != undefined && !___array_exists(gamepad_rebinds_values_right(rebind_index).indexes, last_gamepad_axis)) {
			listening = false;
		
			add_key(rebind_index, last_gamepad_axis, true);
		}
		
	} else {
		
		var last_gamepad_button = undefined;
	
		for (var i=0;i<array_length(___global.controller_values);i++) {
			if (!___global.controller_values[i].active) continue;
		
			for ( var j = gp_face1; j < gp_axisrv; j++ ) {
			    if ( gamepad_button_check( i, j ) ) {
					last_gamepad_button = i;
					break;
				}
			}
		}
		
		if (listening && last_gamepad_button != undefined && !___array_exists(gamepad_rebinds_values_right(rebind_index).indexes, last_gamepad_button)) {
			listening = false;
		
			add_key(rebind_index, last_gamepad_button, true);
		}
	}
	
	//ADD A KEY
	if (KEY_PRIMARY_PRESSED && rebinds_t != 0 && !just_listening) {
		listening = true;
	}
	
	//CLEAR REBINDS
	if (KEY_SECONDARY_PRESSED && !just_listening) {
		clear_rebinds(rebind_index, false);
		
		listening = false;
		just_listening = false;
	}
	
	
	if (!just_listening) {
		var dy = KEY_DOWN_PRESSED - KEY_UP_PRESSED;
		
		rebind_index = ___mod2(rebind_index + dy, array_length(gamepad_rebinds));
	}
	
	
	rebinds_t++;
	
	just_listening = listening;
}

if (state == "key_controls" || state == "gamepad_controls") {
	if (___KEY_PAUSE) {
		___state_change("normal");
		
		rebinds_t = 0;
		just_listening = false;
		listening = false;
		confirmed = false;
	}
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
