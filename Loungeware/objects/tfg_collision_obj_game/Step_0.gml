if (win == true) {
	draw_set_font(tfg_collision_fnt_jetbrains);
	var h = string_height("M");
	repeat (5) 
		instance_create_layer(random(room_width), h * cursor.y, "Layer_Above", tfg_collision_obj_confetti);
	if (!created_bug) {
		sfx_play(tfg_collision_sfx_win, 1, false);
		created_bug = true;
		with (tfg_collision_xobj) {
			sprite_index = tfg_collision_checkmark;
		}
		instance_create_layer(room_width / 2, h * cursor.y, "Layer_Above", tfg_collision_obj_dead_bug);
	}
} else if (win == false || TIME_REMAINING < 90) {
	if (!instance_exists(tfg_collision_obj_error)) {
		if (win == false) sfx_play(tfg_collision_sfx_lose, 1, false);
		tfg_collision_create_error_box(get_line());
	}
}

if (!is_undefined(win)) exit;

//var dir = (KEY_RIGHT || KEY_LEFT || KEY_UP || KEY_DOWN) 
//	? point_direction(0, 0, KEY_RIGHT - KEY_LEFT, KEY_UP - KEY_LEFT)
//	: undefined;
update_time_held();
cursor.spd_when_held_t++;

//var x_dir = (KEY_RIGHT_PRESSED || time_held.right > cursor.buffer_time) - (KEY_LEFT_PRESSED || time_held.left > cursor.buffer_time);
var y_dir = (KEY_DOWN_PRESSED || time_held.down > cursor.buffer_time) - (KEY_UP_PRESSED || time_held.up > cursor.buffer_time);
var hold = /*time_held.right > cursor.buffer_time || time_held.left > cursor.buffer_time || */time_held.down > cursor.buffer_time || time_held.up > cursor.buffer_time;


//if (is_edit_menu_draw) {
//	edit_menu_select = mod2(edit_menu_select + x_dir, array_length(edit_menu));
	
//	if (KEY_PRIMARY_PRESSED) {
//		edit_menu[edit_menu_select].callback();
//		toggle_edit_menu();
//		alarm[0] = 1;
//	}
	
//} else {
if (hold) {
	if (cursor.spd_when_held_t % cursor.spd_when_held == 0) {
		//cursor.x += x_dir;
		cursor.y += y_dir;
	}
} else {
	//cursor.x += x_dir;
	cursor.y += y_dir;
}
	
//cursor.x = clamp(cursor.x, 0, line_cols(cursor.y));
cursor.y = clamp(cursor.y, 0, rows - 1);
//if (any_dir_key()) {
//	cursor.t = 0;
//	cursor.drawing = true;
//}
//}

if (KEY_PRIMARY) {
	if (check_win()) {
		microgame_win();
		win = true;
	} else {
		microgame_fail();
		win = false;
	}
}


//cursor.t++;

//if ((cursor.t % cursor.flash_delay) == 0)
//	cursor.drawing = !cursor.drawing;
	
//if (KEY_PRIMARY_PRESSED && alarm[0] != 1) {
//	toggle_edit_menu();
//}
