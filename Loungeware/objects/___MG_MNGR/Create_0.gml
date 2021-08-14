randomize();
___global.difficulty_level = 1;
___state_setup("start");
force_substate = noone;
dev_mode = false;
gallery_mode = false;
gallery_first_pass = true;

transition_speed = 1;
games_played = 0;

window_scale = 0;
prev_window_scale = window_scale;
pause_cooldown = 0;

// score
score_total = 0;
life_max = 4;
life = life_max;

// microgame
microgame_populate_unplayed_list = function(){
	ds_list_clear(microgame_unplayed_list);
	for (var i = 0; i < array_length(microgame_namelist); i++){
		ds_list_add(microgame_unplayed_list, microgame_namelist[i]);
	}
}
 
gui_scale = 0;
gui_x = 0;
gui_y = 0;

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

// gameboy overlay
gameboy_sprite = ___spr_gameboy_overlay;
gameboy_padding_x = 30;
gameboy_padding_y = 32;
gameboy_frame = 0;
gb_timerbar_visible = false;
gb_timerbar_alpha = 0;
gb_timerbar_fadespeed = 1/8;

// microgame canvas (gameboy screen)
canvas_w = 480;
canvas_h = 320;
canvas_x = gameboy_padding_x;
canvas_y = gameboy_padding_y;

// surfaces
surf_master = noone; // <-- radical 😎
surf_gameboy = noone;
surf_transition_circle = noone;
surf_larold = noone;
surf_cart = noone;


// end microgame transition
wait = 0;
microgame_end_transition_time = 30;
transition_circle_rad_max = canvas_h;
transition_circle_rad = transition_circle_rad_max;
transition_circle_speed = transition_circle_rad / microgame_end_transition_time;
transition_appsurf_zoomscale = 1;
spin_frame = 0;
prompt_alpha = 1;
gb_scale = 1;
gb_offset_x = 0;
gb_offset_y = 0;
cart_offset_x = 0;
cart_offset_y = 0;
cart_angle = 0;
cart_draw_over = false;
spin_speed = 0.75;
gb_min_scale = 0.4;
gb_max_scale = 1;
gb_scale_diff =  gb_max_scale - gb_min_scale;
title_y = 64;
transition_music = noone;
transition_music_began = false;


// larold reflection
larold_dir = 0;
larold_alpha = 3;
larold_index = 1;

// game change cutscene
gb_scale = 1;
cart_sprite = noone;
garbo_sprites = ds_list_create(); //___ds_list_create_builtin();
prompt_alpha = 1;
prompt_timer_max = 30;
prompt_timer = prompt_timer_max;
prompt = "";
prompt_sprite = -1;



// IF TEST MODE ACTIVE: turn on dev mode and load the current test microgame on game start
var _microgame_metadata = ___global.microgame_metadata;
var _test_vars = ___global.test_vars;

if (_test_vars.test_mode_on){
	var _game_key = _test_vars.microgame_key;
	
	if (is_undefined(variable_struct_get(_microgame_metadata, _game_key))){
		show_message("Incorrect microgame key set for test mode, no metadata exists with this key. \nYour key should be the name of your metadata file, minus the \".json\".\n If your metadata file is named \"sam_cookiedunk.json\", then your key would be \"sam_cookiedunk\"");
		game_end();
		exit;
	}

	___state_change("playing_microgame");
	// This should only run when launching the game in debug mode (prompt is normally initialized in draw)
	prompt =  ___microgame_get_prompt(_game_key);
	dev_mode = true;
	
	if (!instance_exists(___dev_debug)) instance_create_layer(0, 0, layer, ___dev_debug);
	___microgame_start(_game_key);
}


if (!dev_mode){

	//show_message("No test game is currently set.\nOpen the _getting_started file in the _HELP_DOCS folder to learn how to make/run your game. It's very easy!\n-space");
	___microgame_load_fake();
	room_goto(___rm_restroom);
	
	___state_change("intro");
	
} 














//--------------------------------------------------------------------------------------------------------
// DRAW CIRCLE TRANSITION SURFACE (requires master surface)
//--------------------------------------------------------------------------------------------------------
function draw_circle_transition(){
		var _circle_pixel_scale = 5;

		var _stc_w = canvas_w / _circle_pixel_scale;
		var _stc_h = canvas_h / _circle_pixel_scale;
		// create the circle surface
		if (!surface_exists(surf_transition_circle)){
			surf_transition_circle = surface_create(_stc_w, _stc_h);
		}
		
		// clear
		surface_set_target(surf_transition_circle);
		draw_clear(c_black);
		surface_reset_target();
		
		// draw larold
		surface_set_target(surf_transition_circle);
		draw_surf_larold(
			-gameboy_padding_x / _circle_pixel_scale, 
			-gameboy_padding_y / _circle_pixel_scale, 
			surface_get_width(surf_transition_circle)*2, 
			surface_get_height(surf_transition_circle)*2, 
			1,
			bm_add
		);
		surface_reset_target();
		
		// subtract the circle
		
		if (transition_circle_rad > 0){
		surface_set_target(surf_transition_circle);
		gpu_set_blendmode(bm_subtract);
		draw_circle(_stc_w /2, _stc_h /2, transition_circle_rad / _circle_pixel_scale, 0);
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		}
		
		// draw circle transition surface to the master surface

		surface_set_target(surf_master);
		draw_surface_stretched(
			surf_transition_circle, 
			canvas_x * window_scale, 
			canvas_y * window_scale, 
			canvas_w * window_scale, 
			canvas_h * window_scale
		);
		surface_reset_target();
}

function draw_surf_larold(_x, _y, _w, _h, _alpha, _blend){
	
	var _store_surf = surface_get_target();
	var _store_blend = gpu_get_blendmode();

	if (!surface_exists(surf_larold)) surf_larold = surface_create(canvas_w, canvas_h);

	
	// clear
	surface_set_target(surf_larold);
	draw_clear(c_gboff);
	surface_reset_target();
	
	// move
	var _dir_speed = 5;
	var _larold_rad = 2;
	larold_dir += _dir_speed;
	var _y_offset_larold = lengthdir_y(_larold_rad, larold_dir);
	var _y_offset_glare = lengthdir_y(_larold_rad * 0.75, larold_dir + 180);
		
	// draw larold
	surface_set_target(surf_larold);
	draw_set_alpha(0.025);
	draw_sprite(___spr_larold_reflection, larold_index, 0, _y_offset_larold);
	surface_reset_target();
		
	// draw glare
	surface_set_target(surf_larold);
	draw_set_alpha(0.015);
	draw_sprite(___spr_larold_reflection, 0, 0, _y_offset_glare);
	surface_reset_target();
	draw_set_alpha(1);
	
	gpu_set_blendmode(_blend);
	surface_set_target(_store_surf);
	draw_surface_stretched_ext(
		surf_larold, 
		_x, _y, _w, _h,
		c_white, 
		_alpha
	);
	gpu_set_blendmode(_store_blend);
	surface_reset_target();
}

//--------------------------------------------------------------------------------------------------------
// DRAW GAMEBOY SURFACE (requires master surface)
//--------------------------------------------------------------------------------------------------------
function draw_gameboy_overlay(){
	
	var _win_w = WINDOW_BASE_SIZE * window_scale;
	var _win_h = WINDOW_BASE_SIZE * window_scale;
	
	// create gameboy surface if it doesn't exist
	if (!surface_exists(surf_gameboy)){
		surf_gameboy = surface_create(WINDOW_BASE_SIZE/2, WINDOW_BASE_SIZE/2);
	}
	

	// draw gameboy onto gameboy surface
	surface_set_target(surf_gameboy);
	draw_clear(c_gboff);
	draw_sprite(gameboy_sprite, gameboy_frame, 0, 0);
	{ // comment out this block if you don't like the moving d-pad
		var dpad_dx = KEY_RIGHT - KEY_LEFT;
		var dpad_dy = KEY_DOWN - KEY_UP;
		var dpad_id = -1;
		if (dpad_dx != 0) {
			var x_options = [0, 2];
			dpad_id = x_options[dpad_dx < 0];
		}
		if (dpad_dy != 0) {
			var y_options = [1, 3];
			dpad_id = y_options[dpad_dy > 0];
		}
		if (dpad_id != -1) {
			draw_sprite(
					___spr_gameboy_dpad, dpad_id,
					25 - sprite_get_xoffset(gameboy_sprite),
					208 - sprite_get_yoffset(gameboy_sprite)); // magic numbers taken from the sprite editor!!!!
		}
	}
	surface_reset_target();


	// draw timerbar
	surface_set_target(surf_gameboy);
	draw_timerbar();
	surface_reset_target();
	
	// draw gameboy surface onto master surface
	surface_set_target(surf_master);
	draw_surface_stretched(surf_gameboy, 0, 0, _win_w, _win_h);
	surface_reset_target();
}

//--------------------------------------------------------------------------------------------------------
// DRAW TIMERBAR
//--------------------------------------------------------------------------------------------------------
function draw_timerbar(){
	
	var _seg_h = 6;
	var _x1 = 15;
	var _y1 = 181;
	var _x2 = 255;
	var _y2 = _y1 + _seg_h;
	
	var _time = ___MG_MNGR.microgame_timer;
	var _time_max = ___MG_MNGR.microgame_timer_max;
	if (_time == -1) return;
	var _secs = ceil(_time/60);
	var _secs_max = ceil(_time_max/60);

	var _seg_spacer_w = _y2 - _y1;
	var _bar_w = _x2 - _x1;
	var _seg_w = floor((_bar_w - (_seg_spacer_w * (_secs_max-1))) / _secs_max);
	
	var _store_alpha = draw_get_alpha();
	draw_set_alpha(gb_timerbar_alpha);
	
	// draw segments
	for (var i = 0; i < _secs_max; i++){
		
		var _shake_x = 0;
		var _shake_y = 0;
		var _shake_val = ((_time / 60) mod 1);
		if (i == _secs-1){
			_shake_x = random_range(-_shake_val, _shake_val);
			_shake_y = random_range(-_shake_val, _shake_val);
		}
		var _xx = _x1 + (i * (_seg_w + _seg_spacer_w));
		draw_set_color(c_gbtimer_empty);
		draw_rectangle_fix(_xx + _shake_x, _y1 + _shake_y, _xx + _seg_w + _shake_x, _y2 + _shake_y);
		draw_set_color(c_gbtimer_full);
		if (_secs > i) draw_rectangle_fix(_xx + _shake_x, _y1 + _shake_y, _xx + _seg_w + _shake_x, _y2 + _shake_y);
		
	}
	
	draw_set_alpha(_store_alpha);
}


//--------------------------------------------------------------------------------------------------------
// DRAW GAME VIEW INTO CANVAS AREA
//--------------------------------------------------------------------------------------------------------
function draw_microgame(){


	var _surf_w_target = canvas_w * window_scale;
	var _surf_h_target = canvas_h * window_scale;

	if (window_scale > 0) && ((window_scale != prev_window_scale) || (surface_get_width(application_surface) != _surf_w_target || surface_get_height(application_surface) != _surf_h_target)) {
		var _w = max(5, _surf_w_target);
		var _h = max(5, _surf_h_target);
		surface_resize(application_surface, _w , _h);
	}

	// draw game view onto master surface
	surface_set_target(surf_master);
	draw_surface_stretched(
		application_surface, 
		canvas_x * window_scale, 
		canvas_y * window_scale,
		canvas_w * window_scale, 
		canvas_h * window_scale
	);
	surface_reset_target();
	
	// set gui size (sets the gui scale to fit the gameboy
	gui_scale = (canvas_w * window_scale) / VIEW_W;
	gui_x = (canvas_x * window_scale) + ((window_get_width() - (WINDOW_BASE_SIZE * window_scale))/2);
	gui_y = (canvas_y * window_scale) + ((window_get_height() - (WINDOW_BASE_SIZE * window_scale))/2);
	display_set_gui_maximise(gui_scale, gui_scale, gui_x, gui_y);

}

//--------------------------------------------------------------------------------------------------------
// DRAW MASTER SURFACE / CREATE MASTER SURFACE
//--------------------------------------------------------------------------------------------------------
function create_master_surface(){
	// create the master surface if it doesn't exit
	if (!surface_exists(surf_master) && window_scale != 0){
		var _size = max(5, WINDOW_BASE_SIZE * window_scale);
		surf_master = surface_create(_size, _size);
	}
	
	if (window_scale != prev_window_scale){
		var _size = max(5, WINDOW_BASE_SIZE * window_scale);
		surface_resize(surf_master, _size, _size);
	}
}
function draw_master_surface(){
	
	var _size = window_scale * WINDOW_BASE_SIZE;
	var _x = (window_get_width()/2) - (_size/2);
	var _y = (window_get_height()/2) - (_size/2);
	// draw master surface
	draw_surface_stretched(surf_master, _x, _y, _size, _size);
}


