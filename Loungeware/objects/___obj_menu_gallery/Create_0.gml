state = "normal";

sng_id = audio_play_sound(___sng_gallery, 1, 1);
var _vol = VOL_MSC * VOL_MASTER * audio_sound_get_gain(___snd_gtr);
audio_sound_gain(sng_id, _vol, 0);

fnt_gallery = ___global.___fnt_gallery;
microgame_keylist = ___microgame_get_keylist_chronological();

selected = 0;
cursor = ___global.menu_cursor_gallery;
scroll_y = 0;
scroll_y_target = scroll_y;
scroll_skip = false;

// skip to correct game if coming from a query string url
if (___global.gallery_goto_key != ""){
	for (var i = 0; i < array_length(microgame_keylist); i++){
		if (microgame_keylist[i] == ___global.gallery_goto_key){
			cursor = i;
			scroll_skip = true;
			___global.gallery_goto_key = "";
			break;
		}
	}
}

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

gameboy_x = ((WINDOW_BASE_SIZE - sprite_get_width(___spr_gameboy_back))/2) + 6;
gameboy_y = WINDOW_BASE_SIZE;

// close
close_wait_before = 0;
close_circle_prog = 1;
surf_circle = noone;
close_wait = 20;
fadeout_began = false;
fadeout_ended = false;
fadeout_do = ___noop();

// button guide
button_guide_alpha = 0;
button_guide_show = true;

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
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
