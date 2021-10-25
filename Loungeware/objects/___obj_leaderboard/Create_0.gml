camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
___state_setup("load");
wait = 0;


fnt_gallery = ___global.___fnt_gallery;
col_bar = make_color_rgb(45, 41, 66);
col_pos = make_color_rgb(59, 56, 83);

leaderboard_data = [];
data_retrieved = false;
request_id = noone;
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


scroll_offset = 0;
scroll_offset_target = 0;

max_highlighted_score_count = 3;
max_score_count = 100;

song_id = noone;

show_board = false;

score_height_minor = 0;
total_scoreboard_height = -1;
scroll_max = -1;
scrolling_enabled = false;
arrow_float_dir = 0;
arrow_1_alpha = 0;
arrow_2_alpha = 1;
button_guide_alpha = 0;
button_guide_show = false;
latest_arrow_dir = 0;
button_guide_frame = 0;

surf_circle = noone;
close_circle_prog = 1;

function try_again(){
	___state_change("load");
}

exit_goto_room = ___rm_main_menu;
exit_goto_object = ___obj_main_menu;
function exit_leaderboard(){
	___state_change("exit_leaderboard");
}

http_error_show = false;
http_error_menu = [
	{text : "TRY AGAIN", action : try_again},
	{text : "CANCEL", action : exit_leaderboard},
];
http_error_title = "ERROR";
http_error_menu_cursor = 0;
http_error_menu_confirmed = false;
http_error_shake_timer = 0;
http_error_alpha = 0;
http_error_allow_try_again = true;
http_error_shake_timer = 0;
http_error_shake_timer_max = 15;
http_error_menu_y_offset_max = 300;
http_error_menu_y_offset = http_error_menu_y_offset_max;
http_error_msg = "server is not responding";

function get_scores(){
	request_id = http_get(___API_BASE_URL + "larold-board");
};

function throw_http_error(_msg){
	http_error_msg = _msg;
	___state_change("error_screen");
	http_error_shake_timer = http_error_shake_timer_max;
	http_error_menu_y_offset = http_error_menu_y_offset_max;
	___sound_menu_error();
}

surf_board = noone;

function is_player(_score_struct){
	return (_score_struct.player_id == ___global.player_id);
}

function is_latest_score(_score_struct){

	return (_score_struct.score_id_local == variable_struct_get(___global.score_last_as_obj, "score_id_local"));
}

function stringify_position(_position_num){
		var _position_str = string(_position_num);
		while (string_length(_position_str) < 2) _position_str = "0" + _position_str;
		return "#" + _position_str;
}

function fill_blanks(_array, _max_size){
	for (var i = 0; i < _max_size; i++){
		if (i >= array_length(_array)){
			
			_array[i] = {
				id: "",
				name:"----",
				score: -1,
				sprite: "___spr_leaderboard_icon_noexist",
				frame: 0,
				score_id_local:"",
				player_id: "blank",
				timestamp:0,
			}
		} else {
			
			// apply default sprite if sprite does not exist in project (for example if more sprites have been added since an update)
			var _asset_index = asset_get_index(_array[i].sprite);
			var _asset_exists = false, _asset_is_sprite = false, _asset_has_frame = false;
			_asset_exists = _asset_index != -1;
			_asset_is_sprite = sprite_exists(_asset_index);
			if (_asset_is_sprite){
				_asset_has_frame = (_array[i].frame < sprite_get_number(_asset_index)) && (_array[i].frame >= 0);
			}
			if (!_asset_exists || !_asset_is_sprite || !_asset_has_frame){
				_array[i].sprite = "___spr_leaderboard_icon_noexist";
				_array[i].frame = 0;
			}
		}
		
		// give scale val
		_array[i].scale = 0;
		_array[i].scale_dir = 0;
		_array[i].scale_wait_max = i * (4/(1 + (i/20)));
		_array[i].scale_wait = _array[i].scale_wait_max;
		_array[i].scale_done = false;
			
	}
	return _array;
}

