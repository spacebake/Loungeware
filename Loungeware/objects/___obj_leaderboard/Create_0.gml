camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
___state_setup("load");

fnt_gallery = ___global.___fnt_gallery;
col_bar = make_color_rgb(45, 41, 66);
scoreboard_url = ___BASE_URL + "/loungeware_leaderboard/get_scores.php";
leaderboard_data = [];
request_id = noone;

function get_scores(){
	request_id = http_get(scoreboard_url);
};

function throw_http_error(_msg){
	http_error_msg = _msg;
	show_message("ERROR: " + string(_msg));
}

