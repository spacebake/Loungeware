//var dir = (KEY_RIGHT || KEY_LEFT || KEY_UP || KEY_DOWN) 
//	? point_direction(0, 0, KEY_RIGHT - KEY_LEFT, KEY_UP - KEY_LEFT)
//	: undefined;
update_time_held();
cursor.spd_when_held_t++;

var x_dir = (KEY_RIGHT_PRESSED || time_held.right > cursor.buffer_time) - (KEY_LEFT_PRESSED || time_held.left > cursor.buffer_time);
var y_dir = (KEY_DOWN_PRESSED || time_held.down > cursor.buffer_time) - (KEY_UP_PRESSED || time_held.up > cursor.buffer_time);
var hold = time_held.right > cursor.buffer_time || time_held.left > cursor.buffer_time || time_held.down > cursor.buffer_time || time_held.up > cursor.buffer_time;

if (is_edit_menu_draw) {
	edit_menu_select = mod2(edit_menu_select + x_dir, array_length(edit_menu));
	log(edit_menu_select);
	
	
} else {
	if (hold) {
		if (cursor.spd_when_held_t % cursor.spd_when_held == 0) {
			cursor.x += x_dir;
			cursor.y += y_dir;
		}
	} else {
		cursor.x += x_dir;
		cursor.y += y_dir;
	}
	
	cursor.x = clamp(cursor.x, 0, line_cols(cursor.y) - 1);
	cursor.y = clamp(cursor.y, 0, rows);
	if (any_dir_key()) {
		cursor.t = 0;
		cursor.drawing = true;
	}
}



cursor.t++;

if ((cursor.t % cursor.flash_delay) == 0)
	cursor.drawing = !cursor.drawing;

if (KEY_SECONDARY_PRESSED) {
	is_edit_menu_draw = !is_edit_menu_draw;
	edit_menu_select = 0;	
}