___state_setup("normal");

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
		text: "GAMEPAD MAPPING",
		prompt: "Press [A] to add a key, or [B] to clear keys",
		op: method(self, function() { ___state_change("pad_controls") }), 
	},
];

// -> [Int]
function keyboard_rebinds_values_right(index) {
	return ___global.curr_input_keys[$ keyboard_rebinds[index]]
}

rebinding = false;
rebind_hold = 0;
keyboard_rebinds = ["right", "up", "left", "down", "primary", "secondary", "pause"];
gamepad_rebinds = ["h axis", "v axis", "right", "up", "left", "down", "primary", "secondary", "pause"];
var generate_rebinds_menu = function(rebinds) {
	var res = array_create(array_length(rebinds));
	
	for (var i = 0; i < array_length(rebinds); i++) {
		res[i] = { text: rebinds[i], };
	}
	
	return res;
}
keyboard_rebinds_menu_left = generate_rebinds_menu(keyboard_rebinds);
gamepad_rebinds_menu_left = generate_rebinds_menu(gamepad_rebinds);
function keyboard_rebinds_menu_right() {
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
	for (var i = 0; i < array_length(keyboard_rebinds); i++) {
		array_push(res, { text: arr_to_str(keyboard_rebinds_values_right(i)) });
	}
	
	return res;
}
rebind_left_xpos = xpos - 220;
rebind_right_xpos = xpos + 220;
rebind_index = 0;
rebind_y = ypos + 120;
rebind_curr_y = rebind_y + 100;
rebind_gap = 20;
rebinds_t = 0;
listening = false;
just_listening = false;
listening_ypos = room_height - 50;
function add_key(index, keycode, is_gamepad) {
	if (is_gamepad) {
		if (variable_struct_exists(___global.curr_controller_keys, gamepad_rebinds[index]))
			array_push(___global.curr_controller_keys[$ gamepad_rebinds[index]], keycode);
		else {
			if (gamepad_rebinds[index] == "h axis")
				array_push(___global.curr_controller_axes.horizontal, keycode);
			else if (gamepad_rebinds[index] == "v axis")
				array_push(___global.curr_controller_axes.vertical, keycode);
			
		}
		
	} else 
		array_push(___global.curr_input_keys[$ keyboard_rebinds[index]], keycode);
}

function clear_rebinds(index, is_gamepad) {
	if (is_gamepad) {
		if (variable_struct_exists(___global.curr_controller_keys, gamepad_rebinds[index]))
			___global.curr_controller_keys[$ gamepad_rebinds[index]] = [];
		else {
			if (gamepad_rebinds[index] == "h axis")
				___global.curr_controller_axes.horizontal = [];
			else if (gamepad_rebinds[index] == "v axis")
				___global.curr_controller_axes.vertical = [];
			
		}
		
	}
	else
		___global.curr_input_keys[$ keyboard_rebinds[index]] = [];
}

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}
