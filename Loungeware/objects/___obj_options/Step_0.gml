___state_handler()

var dy = KEY_DOWN_PRESSED - KEY_UP_PRESSED;

cursor = (cursor + dy) % array_length(menu);

if (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
	confirmed = true
	menu[cursor].op();
}

show_debug_message(state);

t++;