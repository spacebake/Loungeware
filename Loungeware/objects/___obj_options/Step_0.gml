___state_handler()

if (state == "normal") {
	var dy = KEY_DOWN_PRESSED - KEY_UP_PRESSED;

	cursor = (cursor + dy) % array_length(menu);

	if (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
		confirmed = true
		menu[cursor].op();
	}

} else if (state == "controls") {	
	if (___KEY_PAUSE_PRESSED)
		___state_change("normal");
	else if (KEY_ANY_PRESSED)
		rebinding = true;
	
	if (rebinding) {
		// primary + right -> cycle next
		ok = true;
		if (KEY_PRIMARY) {
			if (KEY_ANY_RELEASED) {
				log(___global.keycode_to_str[___global.last_key])
				
				array_push(___global.curr_input_keys[$ rebinds[rebind_index]], ___global.last_key);
				listen_for_rebind = false;
			}
			
		} else {
			//exit
			if (KEY_SECONDARY) {
				rebinding = false;
				rebind_index = 0;
			}
			
			//reset mappings
			if (KEY_UP) {
				___global.curr_input_keys[$ rebinds[rebind_index]] = [];	
			}
			
			var dx = KEY_RIGHT_PRESSED - KEY_LEFT_PRESSED;
			rebind_index = clamp(rebind_index + dx, 0, array_length(rebinds) - 1);
		}
		
		
		//if (listen_for_rebind && KEY_ANY_PRESSED) {
		//	log(___global.keycode_to_str[___global.last_key])
			
		//	array_push(___global.curr_input_keys[$ rebinds[rebind_index]], ___global.last_key);
		//	listen_for_rebind = false;
		//}	
		
		//if (KEY_PRIMARY_PRESSED) {
		//	listen_for_rebind = true;
		//}
		
		//if (KEY_SECONDARY_PRESSED) {
		//	rebind_index++;
			
		//	if (rebind_index == array_length(rebinds)) {
		//		rebinding = false;
		//		rebind_index = 0;	
		//	}
		//}
	}
}

show_debug_message(state);

t++;