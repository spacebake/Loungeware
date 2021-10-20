camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)

sng_id = noone;
sng_index = noone;
function main_menu_theme_play(_skipintro=false){
	sng_index = ___snd_gtr_intro;
	var _loop = false;
	if (_skipintro){
		sng_index = ___snd_gtr;
		_loop = true;
	}
	sng_id = audio_play_sound(sng_index, 1, _loop);
	var _vol = VOL_MSC * VOL_MASTER;
	audio_sound_gain(sng_id, _vol, 0);
}


function main_menu_theme_stop(){
	audio_stop_sound(sng_id);
}

wait = 60;
menu_y = VIEW_H * 1.5;

input_cooldown = 0;
input_cooldown_init_max = 14;
input_cooldown_max = 7;
input_is_scrolling = false;
v_move = 0;
last_v_move = 0;

confirmed = false;
end_wait_max = 30;
confirm_shake_time = 15;
menu_active = false;

skip_intro = false;
step = 0;

// close
close_wait_before = 20;
close_circle_prog = 1;
circle_surf = noone;
close_wait = 20;
goodbye_played = false;



state = "begin";
substate = 0;
cursor = ___global.menu_cursor_main;
menu = [
	"PLAY",
	"GALLERY",
	"LEADERBOARD",
	"OPTIONS",
	"CREDITS",
]
noop = function(){};

menu_method = [
	function(){},
	noop,
	noop,
	noop,
	noop,
]

if (!HTML_MODE){
	array_push(menu, "EXIT");
	array_push(menu_method,  function(){game_end()});
}


menu_method[0] = function(){
	instance_create_layer(0, 0, layer, ___MG_MNGR);
	instance_destroy();
}
menu_method[1] = function(){
	instance_create_layer(0, 0, layer, ___obj_menu_gallery);
	instance_destroy();
}

menu_method[2] = function(){
	instance_create_layer(0, 0, layer, ___obj_leaderboard);
	instance_destroy();
}