___state_setup("begin");
//camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
//surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)

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
	if (sng_id != noone) audio_stop_sound(sng_id);
}

wait = 42;
logo_y = WINDOW_BASE_SIZE * 1.5;
logo_y_target = 160;
logo_shake_timer = 0;
menu_y = WINDOW_BASE_SIZE + 20;
menu_y_target = 280;
logo_scale = 1;
logo_scale_done = false;
logo_scale_dir = 0;
logo_disable_zoom_intro = false;

input_cooldown = 0;
input_cooldown_init_max = 14;
input_cooldown_max = 7;
input_is_scrolling = false;
last_v_move = 0;

confirmed = false;
end_wait_max = 30;
confirm_shake_time = 15;


skip_intro = false;
step = 0;

// close
close_wait_before = 20;
close_circle_prog = 1;
circle_surf = noone;
close_wait = 20;
goodbye_played = false;

bg_frame = 0;
bg_scale = 1.6;
bg_spin = 0;
bg_show = false;

button_prompt_alpha = 0;
show_button_prompt = false;

menu_action_0 = function(){
	instance_create_layer(0, 0, layer, ___MG_MNGR);
	instance_destroy();
}
menu_action_1 = function(){
	instance_create_layer(0, 0, layer, ___obj_menu_gallery);
	instance_destroy();
}
menu_action_2 = function(){
	instance_create_layer(0, 0, layer, ___obj_leaderboard);
	instance_destroy();
}

cursor = ___global.menu_cursor_main;
menu = [
	{text : "PLAY", action : menu_action_0},
	{text : "LEADERBOARD", action : menu_action_2},
	{text : "GALLERY", action : menu_action_1},
	{text : "OPTIONS", action : ___noop},
	{text : "CREDITS", action : ___noop},
]
menu_confirmed = false;
menu_active = false;


if (!HTML_MODE){
	array_push(menu, {text: "EXIT", action : function(){game_end()}});
}

