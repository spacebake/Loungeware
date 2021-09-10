function ___MG_MNGR_declare_variables(){
	
//--------------------------------------------------------------------------------------------------------
// gallery mode
//--------------------------------------------------------------------------------------------------------
gallery_mode = false;
gallery_first_pass = true;
force_substate = noone;

//--------------------------------------------------------------------------------------------------------
// window
//--------------------------------------------------------------------------------------------------------
window_scale = 0;
prev_window_scale = window_scale;
pause_cooldown = 0;

//--------------------------------------------------------------------------------------------------------
// score
//--------------------------------------------------------------------------------------------------------
score_total = 0;
life_max = 4;
life = life_max;
games_played = 0;
___global.difficulty_level = 1;

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
transition_music = noone;
transition_music_began = false;
transition_garbo_sprites = ds_list_create();
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
gb_spin_speed = 0.75;
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

//--------------------------------------------------------------------------------------------------------
// TRANSITION CARTRIDGE VARS
//--------------------------------------------------------------------------------------------------------
cart_x = noone;
cart_y = noone;
cart_metadata = microgame_current_metadata;
cart_sprite = noone;
cart_scale = noone;
cart_vsp = noone;
cart_in_slot_x = noone;
cart_in_slot_y = noone;
cart_offscreen_x = VIEW_W;
cart_offscreen_y = 30;
cart_show = false;
cart_angle = 0;

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

}