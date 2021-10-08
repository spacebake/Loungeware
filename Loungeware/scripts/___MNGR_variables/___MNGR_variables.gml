function ___MG_MNGR_declare_variables(){

//--------------------------------------------------------------------------------------------------------
// gallery mode
//--------------------------------------------------------------------------------------------------------
gallery_mode = false;
gallery_first_pass = true;
force_substate = noone;

//--------------------------------------------------------------------------------------------------------
// intro
//--------------------------------------------------------------------------------------------------------
intro_y_start = (VIEW_H / 2) + 64;
intro_y_target = -40;
intro_y = intro_y_start;
intro_gb_scale_start = 0.25;
intro_gb_scale_end = 1;
intro_first_game_switch = false;

//--------------------------------------------------------------------------------------------------------
// window
//--------------------------------------------------------------------------------------------------------
window_scale = 0;
prev_window_scale = window_scale;
pause_cooldown = 0;
pause_enabled = true;

//--------------------------------------------------------------------------------------------------------
// score
//--------------------------------------------------------------------------------------------------------
score_total = 0;
life_max = 4;
life = 1;
games_played = 0;
games_won = 0;

//--------------------------------------------------------------------------------------------------------
// DIFFICULTY 
//--------------------------------------------------------------------------------------------------------
games_until_next_diff_up_max = 1;
games_until_next_diff_up = games_until_next_diff_up_max;
___global.difficulty_level = 1;
support_no_difficulty_up_to_level = 3; //if difficulty level is higher than this var then games which don't support difficulty will be ignored
diff_bg = ___spr_diff_bg_2;
diff_bg_frame = 0;
diff_bg_speed = 1;

//--------------------------------------------------------------------------------------------------------
// GUI resize
//--------------------------------------------------------------------------------------------------------
gui_scale = 0;
gui_x = 0;
gui_y = 0; 

//--------------------------------------------------------------------------------------------------------
// microgame vars
//--------------------------------------------------------------------------------------------------------
microgame_current_metadata = noone;
microgame_current_name = noone;
microgame_next_metadata = noone;
microgame_next_name = noone;
microgame_timer = -1;
microgame_timer_max = -1;
microgame_timer_skip = false;
microgame_won = false;
microgame_time_finished = 100000;
microgame_namelist = variable_struct_get_names(___global.microgame_metadata);
microgame_unplayed_list = ds_list_create();
microgame_populate_unplayed_list();
microgame_music = noone;
microgame_music_auto_stopped = false;
microgame_initiated = false;



//--------------------------------------------------------------------------------------------------------
// gameboy overlay
//--------------------------------------------------------------------------------------------------------
gbo_sprite = ___spr_gameboy_overlay;
gbo_padding_x = 30;
gbo_padding_y = 32;
gbo_frame = 0;
gbo_timerbar_visible = false;
gbo_timerbar_alpha = 0;
gbo_timerbar_fadespeed = 1/8;

//--------------------------------------------------------------------------------------------------------
// microgame canvas (gameboy screen)
//--------------------------------------------------------------------------------------------------------
canvas_w = 480;
canvas_h = 320;
canvas_x = gbo_padding_x;
canvas_y = gbo_padding_y;

//--------------------------------------------------------------------------------------------------------
// surfaces
//--------------------------------------------------------------------------------------------------------
surf_master = noone;
surf_gameboy = noone;
surf_transition_circle = noone;
surf_cart = noone;
surf_reflection = noone;

//--------------------------------------------------------------------------------------------------------
// end microgame transition
//--------------------------------------------------------------------------------------------------------
transition_speed = 1;
transition_end_microgame_time = 30;
transition_circle_rad_max = canvas_h;
transition_circle_rad = transition_circle_rad_max;
transition_circle_speed = transition_circle_rad / transition_end_microgame_time;
transition_appsurf_zoomscale = 1;
transition_garbo_sprites = ds_list_create();
transition_music_current = noone;
transition_music_began = false;
transition_difficulty_up = false;
wait = 0;

//--------------------------------------------------------------------------------------------------------
// larold reflection
//--------------------------------------------------------------------------------------------------------
larold_dir = 0;
larold_alpha = 3;
larold_index = 1;

//--------------------------------------------------------------------------------------------------------
// TRANSITION GAMEBOY VARS
//--------------------------------------------------------------------------------------------------------
gb_x_offset = 0;
gb_y_offset = 0;
gb_spin = 0;
gb_spin_speed = 1;
gb_show = false;
gb_x = noone;
gb_y = noone;
gb_canvas_x = noone;
gb_canvas_y = noone;
gb_scale = 1;
gb_scale_min = 0.4;
gb_scale_max = 1;
gb_store_y_offset = gb_y_offset;
gb_slot_is_empty = false;
gb_scale_true = noone;
gb_cover_cartridge = false;
gb_cart_eject_speed = -1;
gb_shake_val = 3;
gb_shake = 0;

//--------------------------------------------------------------------------------------------------------
// DIFFICULTY TRANSITION 
//--------------------------------------------------------------------------------------------------------
df_bg_show = false;
df_bg_alpha = 0;
df_bg_sprite = ___spr_difficulty_up;
df_bg_frame_max = sprite_get_number(df_bg_sprite);
df_bg_frame = 0;

//--------------------------------------------------------------------------------------------------------
// DIFFICULTY TRANSITION TEXT
//--------------------------------------------------------------------------------------------------------
dft_sprite = ___spr_difficulty_up_text;
dft_w = sprite_get_width(dft_sprite);
dft_x_min = -(dft_w/2);
dft_x_max = (WINDOW_BASE_SIZE/2)+ (dft_w/2);
dft_x_center = WINDOW_BASE_SIZE/4;
dft_x = dft_x_min
dft_y = 174;
dft_state = -1;
dft_wait = 0;
dft_wait_max = 20;
dft_shake_max = 20;
dft_shake = 0;
dft_hsp = 0;
dft_hsp_max = 10;
dft_accel = 0.3;
dft_scale_hard = 1;
//--------------------------------------------------------------------------------------------------------
// TRANSITION CARTRIDGE VARS
//--------------------------------------------------------------------------------------------------------
cart_x = noone;
cart_y = noone;
cart_metadata = microgame_current_metadata;
cart_sprite = noone;
cart_scale = noone;
cart_vsp = noone;
cart_in_slot_x = 81;
cart_in_slot_y = noone;
cart_offscreen_x = 254;
cart_offscreen_y = 30;
cart_show = false;
cart_angle = 0;
cart_out_peform_bounce = true;

//--------------------------------------------------------------------------------------------------------
// TRANSITION TITLE / AUTHOUR DISPLAY VARS
//--------------------------------------------------------------------------------------------------------
title_y = 64;
title_alpha = 0;

//--------------------------------------------------------------------------------------------------------
// TRANSITION PROMPT VARS
//--------------------------------------------------------------------------------------------------------
prompt_scale_dir = noone;
prompt_scale = noone;
prompt_scale_done = noone;
prompt = "";
prompt_sprite = noone;
prompt_alpha = noone;
prompt_timer_max = 30;
prompt_timer = 0;

//--------------------------------------------------------------------------------------------------------
// TRANSITION HEARTS
//--------------------------------------------------------------------------------------------------------
heart_dir = noone;
heart_alpha = noone;
heart_alpha_done = false;
heart_scale = noone;
heart_last_frame = noone;
heart_image_speed = noone;
heart_dance_dir = noone;
heart_y_lose = 60;
heart_y_screen = ((canvas_y + (canvas_h/2)))/2;
heart_y = heart_y_screen;
heart_shake_timer = -1;
heart_shake_timer_max = -1;
heart_show_lose_seq = false;
heart_begin = true;
heart_wait = -1;


//--------------------------------------------------------------------------------------------------------
// OUTRO
//--------------------------------------------------------------------------------------------------------
ou_glass_parts = [];
ou_glass_part_count = 8;
ou_glass_part_sprite = ___spr_glass_part;
ou_draw_glass_parts = false;
ou_gameboy_x = 183;
ou_angle_target = 45;
ou_angle_speed = 0.1;
ou_swing_dir = 0;
ou_show_gameover_text = false;
ou_gameover_text_scale_done = false;
ou_surf_circle = noone;
ou_circle_dir = 0;
ou_flash = 0;
ou_draw_games = false;
ou_games_dir = 0;
ou_games_global_rad_max = 230;
ou_games_global_rad_target_1 = 120;
ou_games_global_rad = ou_games_global_rad_max;
ou_games_global_scale = 3;
ou_games_global_rad_dir = 0;
ou_scorebox_scale_mod = 0;
ou_scorebox_scale_mod_max = 0.1;
ou_score_display = 0;
ou_score_per_game = 100;
ou_draw_scorebox = false;
ou_cart_pullback_max = 6;
ou_scorebox_frame = 0;
ou_scorebox_larold_scale = 0;
ou_scorebox_larold_scale_dir = 0;
ou_scorebox_larold_scale_done = false;
ou_scorebox_larold_shake = 0;
ou_scorebox_y_offset = 0;
ou_scorebox_y_offset_speed = 0;
ou_gameboy_y_angle = 0;
ou_gameboy_y_is_spinning = false;
ou_pitch_shift = 1;
ou_light_alpha = 0;
ou_show_larold = false;
ou_larold_frame = 0;
ou_larold_speed = 1/6;

//--------------------------------------------------------------------------------------------------------
// END SCREEN
//--------------------------------------------------------------------------------------------------------
es_score_highlight = -1;
es_score_in_scoreboard = false;
es_new_high_score = false;
es_col_bar = make_color_rgb(43, 36, 56);
es_col_date = make_color_rgb(99, 81, 110);
es_song_id = noone;
var _action_play_again = function(){
	workspace_end();
	application_surface_draw_enable(true);
	instance_create_layer(0, 0, layer, ___MG_MNGR);
	instance_destroy();
}
var _action_main_menu = function(){
	workspace_end();
	application_surface_draw_enable(true);
	room_goto(___rm_main_menu);
	instance_create_layer(0, 0, layer, ___obj_main_menu);
	instance_destroy();
}
es_menu = [
	{name:"SUBMIT SCORE", action: ___noop},
	{name:"PLAY AGAIN", action: _action_play_again},
	{name:"MAIN MENU", action: _action_main_menu},
];
es_menu_cursor = 0;
es_menu_confirmed = false;
es_confirm_shake_time = 15;
es_cursor_v_move = 0;
es_cursor_v_move_last = 0;
es_input_cooldown = 0;
es_input_is_scrolling = false;
es_input_cooldown_init_max = 14;
es_input_cooldown_max = 7;
es_score_submitted = false;

es_close_circle_prog = 1;
es_surf_circle = noone;

var b = 0
repeat(3){
for (var i = 0; i < ds_list_size(microgame_unplayed_list); i++){
	b++;
	array_push(played_record, 
	{
		game: microgame_unplayed_list[| i],
		dist: 0,
		spd: 0,
		wait: irandom(60*2),
		state: 0,
		scale: ou_games_global_scale,
		pullback:0,
	});
}}


for (var i = 0; i < ou_glass_part_count; i++){
	var _data = {
		x: 140 + random_range(-5,5),
		y: 145 + random_range(-5,5),
		hsp: random_range(-8, 8)*3,
		vsp: random_range(-6, 6)*3,
		grav: random_range(0.1, 0.2),
		frame: irandom(sprite_get_number(___spr_glass_part)-1),
	}
	array_push(ou_glass_parts, _data);
}


}

