___state_setup("normal");

controls_t = 0
xpos = room_width / 2;
ypos = room_height / 2 - 200;
menu_y = ypos + 200;
prompt_ypos = ypos + 70;

confirmed = false;
cursor = 0;
title_txt = {
	normal: "OPTIONS",
	key_controls: "KEYBOARD MAPPING",
	pad_controls: "GAMEPAD MAPPING",
};
	
menu = [
	{ 
		text: "KEYBOARD MAPPING",
		prompt: "Press [A] to add a key, or [B] to clear keys",
		op: method(self, function() { ___state_change("key_controls") }), 
	},
	{ 
		text: "GAMEPAD_MAPPING",
		prompt: "Press [A] to add a key, or [B] to clear keys",
		op: method(self, function() { ___state_change("pad_controls") }), 
	},
];

// -> [Int]
function rebinds_values_right(index) {
	return ___global.curr_input_keys[$ rebinds[index]]
}

rebinding = false;
rebind_hold = 0;
last_last_key = -1;
rebinds = ["right", "up", "left", "down", "primary", "secondary", "pause"];
rebinds_menu_left = [ { text: "right" }, { text: "up" }, { text: "left" }, { text: "down" }, { text: "primary" }, { text: "secondary" }, { text: "pause" }];
function rebinds_menu_right() {
	var arr_to_str = function(arr) {
		var s = "";
		
		for (var ii = 0; ii < array_length(arr); ii++) {
			s += ___global.keycode_to_str[arr[ii]];	
			
			if (ii != array_length(arr) - 1)
				s += ", ";
		}
		
		return s;
	}	
	
	var res = [];
	for (var i = 0; i < array_length(rebinds); i++) {
		array_push(res, { text: arr_to_str(rebinds_values_right(i)) });
	}
	
	return res;
}
rebind_left_xpos = xpos - 220;
rebind_right_xpos = xpos + 220;
rebind_index = 0;
rebind_y = ypos + 120;
rebind_curr_y = rebind_y + 100;
rebind_gap = 20;
listening = false;
just_listening = false;
listening_ypos = room_height - 50;
function add_key(index, keycode, is_gamepad) {
	if (is_gamepad)
		array_push(___global.curr_controller_keys[$ rebinds[index]], keycode);
	else 
		array_push(___global.curr_input_keys[$ rebinds[index]], keycode);
}

function clear_rebinds(index, is_gamepad) {
	if (is_gamepad)
		___global.curr_controller_keys[$ rebinds[index]] = [];
	else
		___global.curr_input_keys[$ rebinds[index]] = [];
}

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}
