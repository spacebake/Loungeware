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
		if (listen_for_rebind)
			time_since_listen_for_rebind++;
		else
			time_since_listen_for_rebind = 0;
		
		if (time_since_listen_for_rebind >= 2 && KEY_ANY_PRESSED) {
			log(___global.keycode_to_str[___global.last_key])
			
			array_push(___global.curr_input_keys[$ rebinds[rebind_index]], ___global.last_key);
			listen_for_rebind = false;
			time_since_listen_for_rebind = 0;
		}	
		
		if (KEY_PRIMARY_PRESSED) {
			listen_for_rebind = true;
		}
		
		if (KEY_SECONDARY_PRESSED) {
			rebind_index++;	
			
			if (rebind_index == array_length(rebinds)) {
				rebinding = false;
				rebind_index = 0;	
			}
		}
	}
}

show_debug_message(state);

t++;