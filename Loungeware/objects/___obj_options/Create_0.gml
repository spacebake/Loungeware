___state_setup("normal");

xpos = room_width / 2;
ypos = room_height / 2 - 220;
prompt_ypos = ypos + 40;
menu_y = prompt_ypos + 80;

confirmed = false;
cursor = 0;
title_txt = {
	normal: "OPTIONS",
	key_controls: "KEYMAP",
	gamepad_controls: "GAMEPAD MAP",
};

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}

menu = [
	{ 
		text: "KEYBOARD MAPPING",
		prompt: "Press   to add a key, or   to clear keys",
		op: method(self, function() { ___state_change("key_controls") }), 
	},
	{ 
		text: "GAMEPAD MAPPING",
		prompt: "Press   to add a key, or   to clear keys",
		op: method(self, function() { ___state_change("gamepad_controls") }), 
	},
	{ 
		text: "EXIT",
		op: method(self, back_to_main), 
	},
];

// -> [Int]
function keyboard_rebinds_values_right(index) {
	return ___global.curr_input_keys[$ keyboard_rebinds[index]]
}

// -> [{ indexes:Int, isAxis:Bool }]
function gamepad_rebinds_values_right(index) {
	if (gamepad_rebinds[index] == "h axis")
		return { indexes: ___global.curr_controller_axes.horizontal, isAxes: true };
	
	if (gamepad_rebinds[index] == "v axis")
		return { indexes: ___global.curr_controller_axes.vertical, isAxes: true };
		
	return { indexes: ___global.curr_controller_keys[$ gamepad_rebinds[index]], isAxes: false };
}

function draw_all_rebinds(is_gamepad) {
	static whiteball_h = sprite_get_height(___spr_whiteball_square);
	static xx = rebind_right_xpos;
	
	if (is_gamepad) {
		for (var i = 0; i < array_length(gamepad_rebinds); i++) {
			var arr = gamepad_rebinds_values_right(i);
			draw_gamepad_rebinds(arr, xx, rebind_y + i*(whiteball_h+rebinds_bonus_sep));
		}
	} else {
		for (var i = 0; i < array_length(keyboard_rebinds); i++) {
			var arr = keyboard_rebinds_values_right(i);
			draw_keyboard_rebinds(arr, xx, rebind_y + i*(whiteball_h+rebinds_bonus_sep));
		}
	}
}

function draw_keyboard_rebinds(arr, _x, _y) {
	static whiteball_square_w = sprite_get_width(___spr_whiteball_square);
	static whiteball_rect_w = sprite_get_width(___spr_whiteball_rect);
	
	var texts = [];
	var widths = [];
	for (var i = 0; i < array_length(arr); i++) {
		var _str_or_spr = ___global.keycode_to_str[arr[i]]
		
		array_push(texts, _str_or_spr);
		
		if (is_string(_str_or_spr)) {
			draw_set_font(___fnt_lw)	
			array_push(widths, string_width(_str_or_spr));
		} else 
			array_push(widths, sprite_get_width(_str_or_spr));
	}
	
	var xx = _x;
	var was_square = false;
	for (var i = 0; i < array_length(widths); i++) {
		var text_or_spr = texts[i];
		
		if ((is_string(text_or_spr) && string_length(text_or_spr) <= 3) || 
			(text_or_spr == ___spr_arrow_down || text_or_spr == ___spr_arrow_left || text_or_spr == ___spr_arrow_right || text_or_spr == ___spr_arrow_up || text_or_spr == ___spr_backspace)) {
				
			if (!was_square) xx += whiteball_square_w / 2;
				
			draw_sprite(___spr_whiteball_square, 0, xx, _y);
			
			if (is_string(text_or_spr)) {
				draw_set_font(___fnt_key);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_text_color(xx, _y, text_or_spr, c_keyred, c_keyred, c_keyred, c_keyred, 1);
				
			} else {
				draw_sprite_ext(text_or_spr, 0, xx, _y, 1, 1, 0, c_keyred, 1);
			}
			
			xx -= whiteball_square_w + rebinds_bonus_sep;
			was_square = true;
			
		} else {
			if (i != 0 && was_square)
				xx -= whiteball_square_w / 2;
			
			draw_sprite(___spr_whiteball_rect, 0, xx, _y);
			
			if (is_string(text_or_spr)) {
				draw_set_font(___fnt_key_small);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_text_color(xx, _y, text_or_spr, c_keyred, c_keyred, c_keyred, c_keyred, 1);
				//draw_text_ext_transformed_color(xx, _y, text_or_spr, 20, 9999, 0.7, 0.7, 0, c_keyred, c_keyred, c_keyred, c_keyred, 1);
				
			} else {
				draw_sprite_ext(text_or_spr, 0, xx, _y, 1, 1, 0, c_keyred, 1);
			}
			
			xx -= whiteball_rect_w + rebinds_bonus_sep;
			was_square = false;
		}
	}
}

function draw_gamepad_rebinds(struct, _x, _y) {
	static whiteball_rect_w = sprite_get_width(___spr_whiteball_rect);
	
	for (var i = 0; i < array_length(struct.indexes); i++) {
		var xx = _x+i*(whiteball_rect_w+rebinds_bonus_sep);
		var idx = struct.indexes[i];
		
		var spr = ___global.gp_to_str[? idx];
		if (spr == undefined && !struct.isAxes) {
			spr = ___spr_gp_button;
		}
		if (struct.isAxes) spr = ___spr_gp_analog;
		
		draw_sprite(___spr_whiteball_rect, 0, xx, _y);
		
		if (spr == ___spr_gp_button || spr == ___spr_gp_analog) {
			draw_set_font(___fnt_key);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text_color(xx + 18, _y, idx, c_keyred, c_keyred, c_keyred, c_keyred, 1);
		}
		
		draw_sprite(spr, 0, xx, _y);
	}
}

rebinding = false;
pause_t = 0;
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
rebinds_just_reset = false;
//function keyboard_rebinds_menu_right() {
//	var arr_to_str = function(arr) {
//		var s = "";
		
//		for (var ii = 0; ii < array_length(arr); ii++) {
//			s += ___global.keycode_to_str[arr[ii]];	
			
//			if (ii != array_length(arr) - 1)
//				s += ", ";
//		}
		
//		return s;
//	}	
	
//	var res = [];
//	for (var i = 0; i < array_length(keyboard_rebinds); i++) {
//		var txt = arr_to_str(keyboard_rebinds_values_right(i));
		
//		if (txt == "")
//			txt = "---";
			
//		array_push(res, { text: txt });
//	}
	
//	return res;
//}

var whiteball_h = sprite_get_height(___spr_whiteball_square);
draw_set_font(___global.___fnt_gallery);
//rebinds_base_sep = whiteball_h - string_height("M") + 35;
rebinds_base_sep = 40; //someone smarter than me think of a smart way to programatically calculate this
rebinds_bonus_sep = 4;

function gamepad_rebinds_menu_right() {
	//arr:[{indexes:Int, isAxes:Bool}]
	var arr_to_str = function(arr) {
		var s = "";
		
		for (var ii = 0; ii < array_length(arr.indexes); ii++) {
			if (arr.isAxes) {
				s += "AXIS " + string(arr.indexes[ii]);
			} else {
				s += "BUTTON " + string(arr.indexes[ii]);
			}
			
			if (ii != array_length(arr.indexes) - 1)
				s += ", ";
		}
		
		return s;
	}
	
	var res = [];
	for (var i = 0; i < array_length(gamepad_rebinds); i++) {
		log(gamepad_rebinds_values_right(i));
		
		var txt = arr_to_str(gamepad_rebinds_values_right(i));
		
		if (txt == "")
			txt = "---";
		
		array_push(res, { text: txt });
	}
	
	return res;
}
rebind_left_xpos = xpos - 220;
rebind_right_xpos = xpos + 220;
rebind_index = 0;
rebind_y = ypos + 90;
rebind_curr_y = rebind_y + 100;
rebinds_t = 0;
listening = false;
just_listening = false;
listening_ypos = room_height - 50;
rejects = [vk_f11, vk_f8, vk_escape]
function add_key(index, keycode, is_gamepad) {
	static push = function(is_controller, _keycode, _index) {
		var arr;
	
		if (is_controller) {
			arr = ___global.curr_controller_keys[$ gamepad_rebinds[_index]];
		} else {
			arr = ___global.curr_input_keys[$ keyboard_rebinds[_index]];
		}
		
		array_push(arr, _keycode);
		if (array_length(arr) > 4)
			array_delete(arr, 0, 1);
	}
	
	if (is_gamepad) {
		if (variable_struct_exists(___global.curr_controller_keys, gamepad_rebinds[index]))
			push(true, keycode, index);
		else {
			if (gamepad_rebinds[index] == "h axis")
				push(true, keycode, index);
			else if (gamepad_rebinds[index] == "v axis")
				push(true, keycode, index);
			
		}
		
	} else 
		push(false, keycode, index);
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

show_debug_overlay(true);
