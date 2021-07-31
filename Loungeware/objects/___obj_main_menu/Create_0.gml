camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)

sng_id = audio_play_sound(___snd_gtr, 1, 1);
var _vol = VOL_MSC * VOL_MASTER * audio_sound_get_gain(___snd_gtr);
audio_sound_gain(sng_id, _vol, 0)
wait = 60;
menu_y = VIEW_H * 1.5;
v_move = 0;
last_v_mode = 0;
confirmed = false;
end_wait_max = 30;
end_wait = end_wait_max;
confirm_shake_time = 15;

menu_active = false;
skip_intro = false;

// close
close_wait_before = 20;
close_circle_prog = 1;
circle_surf = noone;
close_wait = 20;
close_col = make_color_rgb(31,27,37);
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
	"EXIT"
]


noop = function(){};

menu_method = [
	function(){},
	noop,
	noop,
	noop,
	noop,
	function(){game_end()},
]


menu_method[0] = function(){
	instance_create_layer(0, 0, layer, ___MG_MNGR);
	instance_destroy();
}
menu_method[1] = function(){
	instance_create_layer(0, 0, layer, ___obj_menu_gallery);
	instance_destroy();
}