camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

___state_setup("entry");

wait = 0;
exit_goto_room = ___rm_main_menu;
exit_goto_object = ___obj_main_menu;
function exit_leaderboard(){
	___state_change("exit_menu");
}

song_id = noone;

title_text = "ENTER YOUR NAME";
fnt_gallery = ___global.___fnt_gallery;
col_bar = make_color_rgb(45, 41, 66);
col_green = make_color_rgb(168, 160, 38);
submission_successful = false;

name = "";
name_max_chars = 11;
name_min_chars = 3;
name_zoom_offset = 320;
first_wait = 10;

allowed_letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
allowed_numbers = "0123456789";
allowed_special = "-_";
allowed_chars = allowed_letters + allowed_numbers + allowed_special;


score_int = variable_struct_get(___global.score_last_as_obj, "points");
score_id_local = variable_struct_get(___global.score_last_as_obj, "score_id_local");
score_string = "";

letter_count = 0;
num_count = 0;
special_count = 0;

ignore_next_key_input_timer = false;


keyboard_string = "";
keyboard_string_prev = "";

last_letter_timer = 0;
last_letter_timer_max = 10;
cursor_flash_timer = 0;
cursor_flash_timer_max = 60;

allow_double_specials = true;
allow_starting_with_special = true;
last_key_snd = noone;

draw_input_box = false;
draw_input_prompt = false;
input_y_offset = 0;
input_prompt_alpha = 1;
input_lettershake = 0;

input_error_msg = "";
input_error_show = false;
input_error_shake = 0;
input_error_shake_max = 10;
input_error_alpha = 0;


confirmation_alpha = 0;

input_text_col = c_gbwhite;

draw_confirm_menu = false;
confirm_menu_y_hidden = VIEW_H + 20;
confirm_menu_y_show = VIEW_H - 165;
confirm_menu_y = confirm_menu_y_hidden;
confirm_menu_y_target = confirm_menu_y;
confirm_icon_alpha = 0;
confirm_score_alpha = 0;
confirm_menu_navigation_enabled = false;
confirm_menu_confirmed = false;
confirm_prompt_text = "CONFIRM AND SUBMIT?";
confirm_shake_time = 0;



confirm_menu = [
	{text : "SUBMIT SCORE", action : function(){/*not noop*/}}, 
	{text : "EDIT INFO", action : function(){/*not noop*/}},
];
confirm_cursor = 0;

surf_circle = noone;
close_circle_prog = 1;

ee_alpha = 0;
ee_show = false;
ee_frame = 0;

// icons
icon_selection_scale = 0;
icon_selection_scale_dir = 0;
icon_selection_scale_done = false;
icon_selection_draw_enabled = false;
isd_cursor_enabled = false;
isd_show_prompt = false;
isd_prompt_alpha = 1;

isd_scale = 2;
isd_icons_per_row = 5;
isd_visible_rows = 5;
isd_icon_spr = ___spr_leaderboard_icons;
isd_icon_w = sprite_get_width(isd_icon_spr) * isd_scale;
isd_icon_count = sprite_get_number(isd_icon_spr);
isd_surface = noone;
isd_surf_y_base = 144;
isd_cursor_xpos = 0;
isd_cursor_ypos = 0;
isd_cursor_index = 0;
isd_scroll_y = 0;
isd_scroll_y_target = isd_scroll_y;
isd_line_count = ((isd_icon_count div isd_icons_per_row)) + (isd_icon_count mod isd_icons_per_row > 0);
isd_surf_width = VIEW_W - 198;
isd_sep = (isd_surf_width - (isd_icon_w * isd_icons_per_row)) / (isd_icons_per_row+1);
isd_icon_size_with_sep = isd_icon_w + isd_sep;
isd_surf_height = (isd_visible_rows * isd_icon_size_with_sep) + isd_sep;
isd_confirmed = false;
isd_scale_speed = 5;

// confirm


isd_cursor_display_x = 0;
isd_cursor_display_y = 0;
isd_cursor_bounce_rad = 0;
isd_cursor_bounce_rad_max = 4;
isd_cursor_bounce_dir = -1;

isd_prompt_text = "CHOOSE AN ICON";

isd_draw_scrollbar = false;
isd_record_max_scroll = ((max((isd_line_count-1)-4, 0) * (isd_icon_size_with_sep)));

backfade_alpha = 0;
backfade_alpha_time = 20;

request_time_max = 60*4;
request_time = request_time_max;
max_retries = 3;
retries = max_retries;
show_loader_timer = 60*2;
loader_scale = 0;
loader_scale_dir = 0;
loader_scale_done = false;
loader_dir = 0;
loader_dir_speed_dir = 0;

http_error_msg = "Server is not responding";
http_error_show = false;
http_error_alpha = 0;

redo_info = function(){
	___state_change("entry");
	backfade_alpha = 1;
}
http_error_action_retry = function(){
	___state_change("submit");
}
http_error_action_exit = function(){
	___state_change("exit_confirmation");
	___sound_menu_error();
}

http_error_menu = [
	{text : "RETRY", action : http_error_action_retry},
	{text : "EDIT DETAILS", action : redo_info},
	{text : "CANCEL AND EXIT", action : http_error_action_exit},
];
http_error_menu_cursor = 0;
http_error_menu_confirmed = false;
http_error_shake_timer = 0;
http_error_shake_timer_max = 15;
http_error_menu_y_offset_max = 300;
http_error_menu_y_offset = http_error_menu_y_offset_max;

button_guide_show = false;
button_guide_alpha = 0;
button_guide_frame = 0;

ec_alpha = 0;
ec_show = false;
ec_action_0 = function(){
	___state_change("entry");
	backfade_alpha = 1;
}
ec_action_1 = function(){
	___state_change("exit_menu");
}
ec_menu_title = "YOU WILL NOT GET ANOTHER\nCHANCE TO SUBMIT THIS SCORE\n\nARE YOU SURE YOU \nWANT TO EXIT?";
ec_menu = [
	{text : "SUBMIT MY SCORE", action : ec_action_0},
	{text : "EXIT WITHOUT SUBMITTING", action : ec_action_1},
];
ec_menu_cursor = 0;
ec_menu_y_offset_max = 300;
ec_menu_y_offset = 0;
ec_menu_confirmed = false;
ec_shake_max = 15;
ec_shake = 0;

ss_show = false;
ss_alpha = 0;
ss_title = "SCORE SUBMITTED SUCCESSFULLY"
ss_title_scale = 0;
ss_title_scale_dir = 0;
ss_title_scale_done = false;
ss_action_0 = function(){
	exit_goto_object = ___obj_leaderboard;
	___state_change("exit_menu");
}
ss_menu = [
	{text : "VIEW LEADERBOARD", action : ss_action_0},
	{text : "GO TOO MAIN MENU", action : ec_action_1},
];
ss_menu_cursor = 0;
ss_menu_confirmed = false;
ss_menu_offset_max = 200;
ss_menu_offset = 0;


function string_has_char(_string_to_check, _char){
	return (string_pos(_char, _string_to_check) != 0);
}

function snd_play_key(_backspace=false){
	
	var _snd = choose(___snd_key_press_01, ___snd_key_press_02, ___snd_key_press_03);
	while(_snd == last_key_snd) _snd = choose(___snd_key_press_01, ___snd_key_press_02, ___snd_key_press_03);
	
	var _vol = 0.5 + random(0.2);
	var _pitch = 0.95 + random(0.05);
	if (_backspace) { _snd = ___snd_key_press_backspace;  _pitch = 0.75 + random(0.25);}
	
	___play_sfx(_snd, _vol, _pitch, false);
	last_key_snd = _snd;
}


function string_contains(_string_to_check, _substring_array, _match_length=false){
	_string_to_check = string_upper(_string_to_check);
	for (var i = 0; i < array_length(_substring_array); i++){
		var _substr = string_upper(_substring_array[i]);
		if (_match_length && string_length(_string_to_check) != string_length(_substr)) continue;
		
		if (string_pos(_substr, _string_to_check) != 0) return true;
	}
	return false;
}


function ee_check(){

	ee_show = true;

	// uwu
	if (string_contains(name, ["UWU"])){
		ee_frame = 1;
		return;
	}
	//baku
	if (string_contains(name, ["BAKU", "UKBA", "BEKU", "BOOKU", "BUKO"])){
		isd_prompt_text = "CHOOSE AN ICON, DORK!";
		ee_frame = 2;
		return;
	}
	//net
	if (string_contains(name, ["NET8FLOZ", "BIG_PAPPA", "BIG-PAPPA", "BIG_PAPA", "BIG-PAPA", "BIG-POPPA", "BIG_POPPA", "WIDEGURL", "WIDEGURL2000", "BIGPAPPA"]) || string_contains(name, ["NET"], true)){
		ee_frame = 3;
		return;
	}
	//mimpy
	if (string_contains(name, ["MIMP", "MIMPY", "MINTY"])){
		ee_frame = 4;
		return;
	}
	//zandy
	if (string_contains(name, ["zand", "bandy", "pansy"])){
		ee_frame = 5;
		return;
	}
	//tfg
	if (string_contains(name, ["TFG", "T-F-G", "T_F_G"])){
		ee_frame = 6;
		return;
	}
	//HNGK
	if (string_contains(name, ["HNGK"])){
		ee_frame = 7;
		return;
	}
	// anti
	if (string_contains(name, ["anti", "antidissmist"], true)){
		ee_frame = 8;
		return;
	}
	// tinks
	if (string_contains(name, ["TINKS"], true)){
		ee_frame = 9;
		return;
	}
	// larold
	if (string_contains(name, ["LAROLD"])){
		ee_frame = 10;
		return;
	}

	// KAT
	if (string_contains(name, ["KAT", "KATSAII"], true)){
		ee_frame = 11;
		return;
	}
	// MAKO
	if (string_contains(name, ["MAKO", "MAKOREN"], true)){
		ee_frame = 12;
		return;
	}
	// NAHOO
	if (string_contains(name, ["NAHOO", "NATESTAR", "SHITBOI"], true)){
		ee_frame = 13;
		return;
	}
	// MES
	if (string_contains(name, ["MES", "MESETA"], true)){
		ee_frame = 14;
		return;
	}
	
	ee_show = false;
}


function ___menu_sign_timed_input_vertical(_sign){
	static _sign_prev = 0;
	static _input_cd = 0;
	var _input_cd__max_initial = 30;
	var _input_cd_max_subsequent = 4;
	
	if (_sign == 0){
		_input_cd = 0;
		_sign_prev = _sign;
		return 0;
	} 
	
	if (_sign != _sign_prev){
		_input_cd = _input_cd__max_initial;
		_sign_prev = _sign;
		return _sign;
	}
	
	if (_sign == _sign_prev){
		if (_input_cd > 0){
			_input_cd = max(0, _input_cd - 1);
			return 0;
		} else {
			_input_cd = _input_cd_max_subsequent;
			_sign_prev = _sign;
			return _sign;
		}
	}
}

post_id = noone;


function sbmt_scr(){
	
	var _data = {
		name: name,
		points: score_int,
		str: "if you cheat at this game you're a fuggin loser",
		sprite: sprite_get_name(isd_icon_spr),
		frame: isd_cursor_index,
		score_id_local: score_id_local,
		player_id: ___global.player_id,
	}
	
	// uncomment for testing
	//_data.points = 100;
	//_data.score_id_local = ___uniqid();
	
	
	var _json = json_stringify(_data);
	var _url = ___API_BASE_URL + "larold-board";
	log(_json);
	post_id = http_post_string(_url, _json);
}


function throw_http_error(_msg){
	http_error_msg = _msg;
	___state_change("error_screen");
	http_error_shake_timer = http_error_shake_timer_max;
	http_error_menu_y_offset = http_error_menu_y_offset_max;
	___sound_menu_error();
}



function load_submitted_score_id_list(){
	
		var _file_exists = file_exists(score_list_fp);
		var _json_is_valid = false;
		var _data;
		
		if (_file_exists){
			var _file = file_text_open_read(score_list_fp);
			var _json = file_text_read_string(_file);
			try {
				_data = json_parse(_json);
				_json_is_valid = true;
			}
			catch(_exception){
				show_debug_message(_exception.message);
				file_delete(score_list_fp);
			}
		
			file_text_close(_file);
		}
		
		if (_json_is_valid){
			return _data;
		} else {
			return [];
		}
}

input_error_msg_queued = "";
function input_name_validate(_name){
	input_error_msg_queued = "";
	var _len = string_length(_name);
	var _letter_count = 0;
	var _min_letters = 3; // letters not the same as characters
	for (var i = 0; i < string_length(_name); i++){
		var _char = string_char_at(_name, i+1);
		if (string_has_char(allowed_letters, _char)){
			_letter_count += 1;

		}
	}
	
	if (_letter_count < _min_letters) input_error_msg_queued = "NAME MUST CONTAIN AT LEAST " + string(_min_letters) + " LETTERS";
	if (_len < name_min_chars) input_error_msg_queued = "NAME MUST BE AT LEAST " + string(name_min_chars) + " CHARACTERS";
	if (_len > name_max_chars) input_error_msg_queued = "IDK HOW YOU DID THAT BUT NAME MUST BE " + string(name_max_chars) + " OR FEWER";
	
	if (input_error_msg_queued != ""){
		return false;
	}
	
	input_error_show = false;
	return true;
}