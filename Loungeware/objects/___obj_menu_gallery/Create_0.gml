camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

state = "normal";

sng_id = audio_play_sound(___sng_gallery, 1, 1);
var _vol = VOL_MSC * VOL_MASTER * audio_sound_get_gain(___snd_gtr);
audio_sound_gain(sng_id, _vol, 0);

fnt_gallery = ___global.___fnt_gallery;
microgame_keylist = variable_struct_get_names(___global.microgame_metadata);

var _keys = ds_priority_create();
for (var i = 0; i < array_length(microgame_keylist); i++){
	var _date = variable_struct_get(___global.microgame_metadata, microgame_keylist[i]).date_added;

	_date = real(string_replace_all(_date, "/", ""));
	
	ds_priority_add(_keys, microgame_keylist[i], _date);
}
microgame_keylist = [];
while (ds_priority_size(_keys) > 0){
	array_push(microgame_keylist, ds_priority_delete_max(_keys));
}



selected = 0;
cursor = ___global.menu_cursor_gallery;
scroll_y = 0;
scroll_y_target = scroll_y;

difficulty = 1;

input_cooldown = 0;
input_cooldown_init_max = 17;
input_cooldown_max = 4;
input_is_scrolling = false;
previous_scroll_dir = 0;
col_bar = make_color_rgb(43, 36, 56);
col_bg = make_color_rgb(31, 27, 37);
col_date = make_color_rgb(99, 81, 110);
cart_float_dir = 0;
top_cover_prog = 0;
bottom_cover_prog = 1;
bottom_cover_prog_target = bottom_cover_prog;

// open 
cover_alpha = 1;

cart_x = 0;
cart_y = 0;

gameboy_x = ((VIEW_W - sprite_get_width(___spr_gameboy_back))/2) + 6;
gameboy_y = VIEW_H;

// close
close_wait_before = 0;
close_circle_prog = 1;
surf_circle = noone;
close_wait = 20;
fadeout_began = false;
fadeout_ended = false;
fadeout_do = function(){};



function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}



function draw_dotted_line(_x1, _y1, _x2, _y2, _dot_size, _gap_size){
	// swap x1 and x2 if x2 is smaller
	var _xx = _x1;
	var _yy = _y1;
	var _direction = point_direction (_x1, _y1, _x2, _y2);
	
	var _dist = point_distance(_x1, _y1, _x2, _y2);
	var _seg_count = floor((_dist + _gap_size) / (_dot_size + _gap_size)) + 1;
	repeat(_seg_count){
		
		draw_rectangle_fix(_xx - (_dot_size/2), _yy - (_dot_size/2), _xx+(_dot_size/2), _yy + (_dot_size/2));
		_xx += lengthdir_x(_gap_size + _dot_size, _direction);
		_yy += lengthdir_y(_gap_size + _dot_size, _direction);
	}
	
}

function date_nicify(_date_string){
	
		
	static month_names = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
	
	var _date = date_as_numeric_array(_date_string);
	var _str = "";
	var _year = _date[0];
	var _month = _date[1];
	var _day = _date[2];
	
	_str += month_names[_month-1] + " ";
	
	var _day_as_string = string(_day);
	if (string_length(_day_as_string) < 2) _day_as_string = "0" + _day_as_string;
	_str += _day_as_string;

	_str += ", 20" + string(_year);
	
	return _str;
}


function date_as_numeric_array(_date_string){
	var _date = ___global.___split_string_by_char(_date_string, "/", true);
	for (var i = 0; i < array_length(_date); i++){
		_date[i] = real(_date[i]);
	}
	return _date;
}