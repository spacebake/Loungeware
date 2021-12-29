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
		if (KEY_PRIMARY_PRESSED) {
			rebind_index++;	
			
			if (rebind_index == array_length(rebinds))
				rebinding = false;
		}
	}
}

show_debug_message(state);

t++;