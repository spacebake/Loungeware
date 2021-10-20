function ___MG_MNGR_declare_functions(){
	
	//--------------------------------------------------------------------------------------------------------
	// MICROGAME START
	// name says it all tbh
	//--------------------------------------------------------------------------------------------------------
	function microgame_start(_microgame_propname){
	
		// init new microgame
		with(___MG_MNGR){
		
			// garbo the sprites from last cutscene
			while (ds_list_size(transition_garbo_sprites) > 0){
				sprite_delete(transition_garbo_sprites[| 0]);
				ds_list_delete(transition_garbo_sprites, 0);
			}
		
			var _metadata = variable_struct_get(___global.microgame_metadata, _microgame_propname);
			microgame_current_metadata = _metadata;
			microgame_current_name = _microgame_propname;
			cart_change(microgame_current_metadata);
		
			microgame_timer = _metadata.time_seconds * 60;
			microgame_timer_max = _metadata.time_seconds * 60;
			if (TEST_MODE_ACTIVE && _metadata.time_seconds > ___global.max_microgame_time){
				show_message("You are exceeding the maximum amount of time allowed for a microgame. Please make a game that is " + string(___global.max_microgame_time) + " seconds or shorter.\nIf you need to test your microgame without a timer then press \"I\" while in test mode to toggle infinite timer.");
			}
		
			microgame_won = false;
			microgame_timer_skip = false;
			cart_sprite = ___cart_sprite_create(_metadata);
			gbo_timerbar_visible = true;
			transition_appsurf_zoomscale = 1;
			transition_circle_rad = canvas_h;
		
			if (_metadata.music_track >= 0) microgame_music_start(_metadata.music_track, 1, _metadata.music_loops);
			microgame_music_auto_stopped = false;
			microgame_initiated = false;
			room_goto(_metadata.init_room);
		
			// destroy and recreate fake global
			with (___fake_global) instance_destroy();
			instance_create_layer(0, 0, layer, ___fake_global);
			// garbage collect any leftover ds structures from previous microgame
			workspace_end();
			workspace_begin();
		}
	}

	//--------------------------------------------------------------------------------------------------------
	// MICROGAME END
	// name says it all tbh
	//--------------------------------------------------------------------------------------------------------
	function microgame_end(){
	
		games_played += 1;
		show_debug_overlay(false);
	
		// update save data
		if (!TEST_MODE_ACTIVE && !gallery_mode){
			var _save_struct = variable_struct_get(___global.save_data.microgame_data, ___MG_MNGR.microgame_current_name);
			_save_struct.play_count = _save_struct.play_count + 1;
			if (___MG_MNGR.microgame_won){
				_save_struct.wins = _save_struct.wins + 1;
				var _time_taken = ___MG_MNGR.microgame_timer_max - ___MG_MNGR.microgame_time_finished;
				if (_time_taken < _save_struct.best_time) _save_struct.best_time = _time_taken;
			}
		}
		___save_game();
	
		// send to server if data collection on
		if (___global.save_data.data_collection){
			// < CODE GO HERE AT SOME POINT >
		}
		
		// if win
		if (___MG_MNGR.microgame_won){
			larold_index = 1;
			var _points = 1; //1 + (___MG_MNGR.microgame_timer / ___MG_MNGR.microgame_timer_max) + (DIFFICULTY/5);
			___MG_MNGR.score_total += _points;
			games_won += 1;
			microgame_add_to_played_record(___MG_MNGR.microgame_current_name);
		} 
	
		if (DIFFICULTY < ___global.difficulty_max && !gallery_mode && !TEST_MODE_ACTIVE){
			games_until_next_diff_up = max(games_until_next_diff_up-1, 0);
			if (games_until_next_diff_up <= 0){
				games_until_next_diff_up = games_until_next_diff_up_max;
				transition_difficulty_up = true;
				___global.difficulty_level = min(___global.difficulty_level + 1, ___global.difficulty_max);
				if (DIFFICULTY > support_no_difficulty_up_to_level) cull_gameslist_no_difficulty();
			
			}
		}
	
	
		// go to rest room (lol)
		room_goto(___rm_restroom);
	
		if (!TEST_MODE_ACTIVE && !gallery_mode){
		

		
			// remove game from unplayed list 
			var _index_to_remove = ds_list_find_index(microgame_unplayed_list, ___MG_MNGR.microgame_current_name);
			ds_list_delete(microgame_unplayed_list, _index_to_remove);
	
			// if uplayed list is empty, repopulate it with all games (exclude the one just played, if possble, see below)
			if (ds_list_size(microgame_unplayed_list) <= 0){
			
				microgame_populate_unplayed_list();
				// remove games with no difficulty scaling if difficulty is more than N (Again)
				if (DIFFICULTY > support_no_difficulty_up_to_level) cull_gameslist_no_difficulty();
		
		
				// if there is more than 1 game, delete the last played game from the new list as to not get repeats
				if (ds_list_size(microgame_unplayed_list) > 1){
					_index_to_remove = ds_list_find_index(microgame_unplayed_list, ___MG_MNGR.microgame_current_name);
					ds_list_delete(microgame_unplayed_list, _index_to_remove);
				}
			}
	
			// choose next game from uplayed list
			microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
			microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
		} else {
			microgame_next_name = microgame_current_name;
			microgame_next_metadata = microgame_current_metadata;
		}
	
	}

	//--------------------------------------------------------------------------------------------------------
	// LOAD FAKE MICROGAME
	// loads a fake microgame as the first game to pop out of the gameboy, no game is actually attached to it
	//--------------------------------------------------------------------------------------------------------
	function microgame_load_fake(){

			var _cart = ___get_fake_label();
			_cart.cartridge_label = ___spr_fake_labels;
			cart_sprite = ___cart_sprite_create(_cart);
			microgame_current_metadata = _cart;
			cart_change(microgame_current_metadata);

			//show_message(microgame_current_metadata);
			microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
			microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
	}

	// ------------------------------------------------------------------------------------------
	// MICROGAME GET PROMPT
	// ------------------------------------------------------------------------------------------
	// returns a random prompt from the microgame prompt array
	function microgame_get_prompt(_key){
		var _metadata = variable_struct_get(___global.microgame_metadata, _key);
		return _metadata.prompt[irandom(array_length(_metadata.prompt) - 1)];
	}

	//--------------------------------------------------------------------------------------------------------
	// MICRO GAME POPULATE UNPLAYED LIST
	//--------------------------------------------------------------------------------------------------------
	function microgame_populate_unplayed_list(){
		ds_list_clear(microgame_unplayed_list);
		for (var i = 0; i < array_length(microgame_namelist); i++){
			ds_list_add(microgame_unplayed_list, microgame_namelist[i]);
		}

	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW CIRCLE TRANSITION SURFACE (requires master surface)
	//--------------------------------------------------------------------------------------------------------
	function draw_circle_transition(){

			var _show_reflection = (transition_circle_rad < transition_circle_rad_max);
			if (!_show_reflection) return;
			// draw larold
			draw_reflection(0, 0, 0.25);

			// draw a circle ontro a surface
			if (_show_reflection){
				var _circle_pixel_scale = 5;
				var _stc_w = canvas_w / _circle_pixel_scale;
				var _stc_h = canvas_h / _circle_pixel_scale;
				// create the circle surface
				if (!surface_exists(surf_transition_circle)){
					surf_transition_circle = surface_create(_stc_w, _stc_h);
				}
				surface_set_target(surf_transition_circle);
				draw_clear_alpha(c_black, 0);
				draw_set_color(c_white);
				draw_circle(_stc_w /2, _stc_h /2, transition_circle_rad / _circle_pixel_scale, 0);
				surface_reset_target();
			}
		
			// cut the new circle out of the reflection surface
			surface_set_target(surf_reflection);
			gpu_set_blendmode(bm_subtract);
			draw_surface_stretched(surf_transition_circle, 0, 0, surface_get_width(surf_reflection), surface_get_height(surf_reflection));
			gpu_set_blendmode(bm_normal);
			surface_reset_target();
		
			// draw circle transition surface to the master surface

			surface_set_target(surf_master);
			draw_surface_stretched(
				surf_reflection, 
				canvas_x * window_scale, 
				canvas_y * window_scale, 
				canvas_w * window_scale, 
				canvas_h * window_scale
			);
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
		draw_sprite(gbo_sprite, gbo_frame, 0, 0);
	
		if (___global.opt_show_button_presses) {
			// D PAD
			var _dpad_in_use = KEY_RIGHT || KEY_UP || KEY_LEFT || KEY_DOWN;
			var _dpad_frame = point_direction(
				0, 0,
				-KEY_LEFT + KEY_RIGHT,
				-KEY_UP + KEY_DOWN
			);
			_dpad_frame = _dpad_frame div 90;
			if (_dpad_in_use) {
				draw_sprite(
					___spr_gameboy_dpad, _dpad_frame,
					25 - sprite_get_xoffset(gbo_sprite),
					208 - sprite_get_yoffset(gbo_sprite)
				); // magic numbers taken from the sprite editor!!!!
			}
			// A BUTTON
			draw_sprite(
				___spr_gameboy_button_a, KEY_PRIMARY, 
				223  - sprite_get_xoffset(gbo_sprite), 
				204  - sprite_get_yoffset(gbo_sprite)
			);
			// B BUTTON
			draw_sprite(
				___spr_gameboy_button_b, KEY_SECONDARY, 
				195  - sprite_get_xoffset(gbo_sprite), 
				232  - sprite_get_yoffset(gbo_sprite)
			);
		}
		surface_reset_target();

		// draw timerbar
		draw_timerbar();
	
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
		draw_set_alpha(gbo_timerbar_alpha);
		surface_set_target(surf_gameboy);
		gpu_set_colorwriteenable(1, 1, 1, 0); 
	
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
		
			var _scl = 1;
			var _seg_x1 = round((_xx + _shake_x)*_scl)/_scl;
			var _seg_x2 = round((_seg_x1 + _seg_w)*_scl)/_scl;
			var _seg_y1 = round((_y1 + _shake_y)*_scl)/_scl;
			var _seg_y2 = round((_seg_y1 + _seg_h)*_scl)/_scl;
		
			draw_set_color(c_gbtimer_empty);
			draw_rectangle_fix(_seg_x1,_seg_y1, _seg_x2, _seg_y2);
			draw_set_color(c_gbtimer_full);
			if (_secs > i) draw_rectangle_fix(_seg_x1,_seg_y1, _seg_x2, _seg_y2);
		
		}
		gpu_set_colorwriteenable(1, 1, 1, 1); //thanks mimpy
		draw_set_alpha(_store_alpha);
		surface_reset_target();
	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW GAME VIEW INTO CANVAS AREA
	//--------------------------------------------------------------------------------------------------------
	function draw_microgame(){

		var _surf_w_target = canvas_w * window_scale;
		var _surf_h_target = canvas_h * window_scale;
	
		if (microgame_current_metadata.allow_subpixels) {
			if (window_scale > 0) 
			&& ((window_scale != prev_window_scale) 
			|| (surface_get_width(application_surface) != _surf_w_target 
			|| surface_get_height(application_surface) != _surf_h_target)) {
				var _w = max(5, _surf_w_target);
				var _h = max(5, _surf_h_target);
				surface_resize(application_surface, _w , _h);
			}
		} else if (surface_get_width(application_surface) != room_width || surface_get_height(application_surface) != room_height) {
			// IMPLEMENTED BY KAT, CRY ABOUT IT!!!!
			surface_resize(application_surface, room_width, room_height);
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
	
		// set gui size (sets the gui scale to fit the gameboy)
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

	//--------------------------------------------------------------------------------------------------------
	// CART CHANGE | change the cartridge sprite / colour
	//--------------------------------------------------------------------------------------------------------
	function cart_change(_microgame_metadata){
		cart_metadata = _microgame_metadata;
		if (sprite_exists(cart_sprite)) sprite_delete(cart_sprite);
		cart_sprite = ___cart_sprite_create(cart_metadata);
	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW GAMEBOY CENTERED | draws the gameboy for transitions
	//--------------------------------------------------------------------------------------------------------
	function draw_gameboy(_scale, _x_offset, _y_offset, _spin_angle, _slot_is_empty){
	
		var _draw_scale = VIEW_W / WINDOW_BASE_SIZE;
		var _y_offset_at_zoom_min = 114;
		var _spin_frame = (_spin_angle / 360) * sprite_get_number(___spr_gameboy_spin_x);
		var _screen_scale = _scale;
		var _spin_lock = (_spin_angle mod 360 == 0);

	
		var _sprite = ___spr_gameboy_overlay;
		if (_scale <= gb_scale_min || !_spin_lock){
			var _compensation = 1.257692307;
			_sprite = ___spr_gameboy_spin_x;
			_scale = _scale * _compensation;
			_y_offset_at_zoom_min = ((_y_offset_at_zoom_min-4) * _compensation);
		}
	
		var _origin_offset_x = sprite_get_xoffset(_sprite);
		var _gameboy_width = sprite_get_width(_sprite);
		var _screen_width = _gameboy_width - (_origin_offset_x * 2); // note: _screen_width/height include the screen border (use canvas_w/h to exlcude)
		var _center_x = (WINDOW_BASE_SIZE * _draw_scale)/2;
		var _x = round(_center_x - (_screen_width / 2) * _scale) + _x_offset;
	
		var _scale_prog = clamp(((_scale - gb_scale_min) / (1-gb_scale_min)), 0, 1);
		var _y = round((_y_offset_at_zoom_min * (1-_scale_prog)) + _y_offset);

		var _screen_margin = 15;
		var _screen_x = _x + (_screen_margin * _scale);
		var _screen_y = _y + (_screen_margin * _scale);
		if (_spin_lock) draw_reflection(_screen_x, _screen_y, _screen_scale)
	
		if (gb_shake > 0){
			_x += random_range(-gb_shake, gb_shake);
			_y += random_range(-gb_shake, gb_shake);
			gb_shake = max(0, gb_shake-1);
		}
	
		if (ou_gameboy_y_is_spinning){
			_sprite = ___spr_gameboy_spin_y;
			_spin_frame = ((ou_gameboy_y_angle / 360) * (sprite_get_number(_sprite)));
		} 
	
		// draw gameboy
		if (_sprite == ___spr_gameboy_spin_x && _slot_is_empty) _sprite = ___spr_gameboy_spin_x_empty;
		___shader_cartridge_on(cart_metadata);
		draw_sprite_ext(_sprite, _spin_frame, _x, _y, _scale, _scale, 0, c_white, 1);
		___shader_cartridge_off();
	
	
		// draw empty slot if applicable
		if (_slot_is_empty && floor(_spin_frame) == 15 && !ou_gameboy_y_is_spinning){
			draw_sprite_ext(___spr_gameboy_back, 0, _x, _y, _scale, _scale, 0, c_white, 1);
		}

		gb_x = _x;
		gb_y = _y;
		cart_in_slot_y = _y;
		gb_scale_true =_scale;
		if (!sprite_exists(cart_sprite)) cart_sprite = ___cart_sprite_create(cart_metadata);
	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW REFLECTION
	//--------------------------------------------------------------------------------------------------------
	function draw_reflection(_x, _y, _scale){
		//draw reflection
		var _reflection_alpha = clamp(((_scale - gb_scale_min) / (1-gb_scale_min)), 0, 1);
		var _larold_alpha = 0.025;
		var _glare_alpha = 0.015;
		var _larold_rad = 2;
		var _dir_speed = 2.5 * transition_speed;
		static _larold_dir = 0;
		_larold_dir += _dir_speed;
		var _y_offset_larold = lengthdir_y(_larold_rad, _larold_dir);
		var _y_offset_glare = lengthdir_y(_larold_rad * 0.75, _larold_dir + 180);
		if (!surface_exists(surf_reflection)){
			surf_reflection = surface_create(canvas_w/2, canvas_h/2);
		}
		surface_set_target(surf_reflection);
		draw_clear(c_gboff);

		var _x_on_surf = (surface_get_width(surf_reflection) - sprite_get_width(___spr_larold_reflection)) / 2;
		var _y_on_surf = -(canvas_y/2);
	
		gpu_set_colorwriteenable(1, 1, 1, 0); //thanks mimpy
		draw_set_alpha(_larold_alpha);
		draw_sprite(___spr_larold_reflection, larold_index, _x_on_surf, _y_on_surf + _y_offset_larold);
		draw_set_alpha(_glare_alpha);
		draw_sprite(___spr_larold_reflection, 0, _x_on_surf, _y_on_surf + _y_offset_glare);
		draw_set_alpha(1);
		gpu_set_colorwriteenable(1, 1, 1, 1); 
		surface_reset_target();
		draw_set_color(c_gboff);
		draw_rectangle_fix(_x, _y, _x + surface_get_width(surf_reflection) * _scale, _y + surface_get_height(surf_reflection) * _scale); 
		draw_surface_ext(surf_reflection, _x, _y, _scale, _scale, 0, c_white, _reflection_alpha);
	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW PROMPT
	//--------------------------------------------------------------------------------------------------------
	function draw_prompt(){

		var _win_h = window_get_height();
		var _shake_val = max(0, (prompt_scale - 1) * 20);
		var _shake_x = random_range(-_shake_val, _shake_val);
		var _shake_y = random_range(-_shake_val, _shake_val);
		var _prompt_x = _shake_x;
		var _prompt_y = -(80) + _shake_y;
		var _prompt_alpha = min(prompt_scale, 1);
	
		_prompt_x -= (prompt_scale - 1) * (_win_h/2);
		_prompt_y -= (prompt_scale - 1) * (_win_h/2);
		//show_message(_prompt_y);
	
		draw_sprite_stretched_ext(
			prompt_sprite,
			0,
			_prompt_x,
			_prompt_y,
			_win_h * prompt_scale,
			_win_h * prompt_scale, 
			c_white,
			_prompt_alpha
		);

	
		if (!prompt_scale_done){
		
			prompt_scale = -lengthdir_y(1.5, prompt_scale_dir);
			prompt_scale_dir += 5;
			if (prompt_scale_dir > 90 && prompt_scale <= 1){
				prompt_scale = 1;
				prompt_scale_done = true;
			
			}
		} else {
			prompt_timer = max(0, prompt_timer-1);
		}
	
	}

	//--------------------------------------------------------------------------------------------------------
	// DIFFICULTY UP TEXT PLAY
	//--------------------------------------------------------------------------------------------------------
	function dft_play(){
		dft_x = dft_x_min;
		dft_wait = 10;
		dft_shake = 0;
		dft_state = 0;
		dft_scale_hard = 1;
	}




	//--------------------------------------------------------------------------------------------------------
	// cull games from list which dont support difficulty
	//--------------------------------------------------------------------------------------------------------
	// if difficulty is more than 3, remove all games that dont support difficulty
	function cull_gameslist_no_difficulty(){
	
		for (var i = 0; i < ds_list_size(microgame_unplayed_list); i++){
			var _key = microgame_unplayed_list[| i];
			var _metadata = variable_struct_get(___global.microgame_metadata, _key);
			var _supports_difficulty = _metadata.supports_difficulty_scaling;
			if (!_supports_difficulty){
				ds_list_delete(microgame_unplayed_list, i);
				i--;
			}
		}
	}
	
	//--------------------------------------------------------------------------------------------------------
	// add a new score to the local scoreboard if it is great enough
	//--------------------------------------------------------------------------------------------------------
	function add_score_to_board_local(_score){
		
		// check if new score makes it onto leaderboard
		var _board = ___global.scores_local;
		var _max = ___global.scores_local_count_max;
		for (var i = 0; i < _max; i++){
			
			if (i >= array_length(_board) || _score >= variable_struct_get(_board[i], "points")){
				
				// insert score into board
				var _data = new ___score_create("", _score);
				array_insert(_board, i, _data);
				
				// delete the last entry
				if (array_length(_board) > _max) array_delete(_board, _max, array_length(_board)-_max); 

				
				// mark this list position as new for display purposes
				es_score_highlight = i;
				es_score_in_scoreboard = true;
				if (i == 0) es_new_high_score = true;
				
				break;
			} 
		}
		
		// save score here
		var _file = file_text_open_write(___global.scores_local_fp);
		var _json = json_stringify(_board);
		file_text_write_string(_file, _json);
		file_text_close(_file);
	}

	//--------------------------------------------------------------------------------------------------------
	// load local scores froms save file (or create default values if no file exists)
	//--------------------------------------------------------------------------------------------------------
	function load_local_scores(){
		var _path = ___global.scores_local_fp;
		var _file_exists = file_exists(_path);
		var _json_is_valid = false;
		var _data;
		
		if (_file_exists){
			var _file = file_text_open_read(_path);
			var _json = file_text_read_string(_file);
			try {
				_data = json_parse(_json);
				_json_is_valid = true;
			}
			catch(_exception){
				show_debug_message(_exception.message);
				file_delete(_path);
			}
		
			file_text_close(_file);
		}
		
		if (_json_is_valid){
			___global.scores_local = _data;
		} else {
			___global.scores_local = [];
		}
		
		
	}
	
	//--------------------------------------------------------------------------------------------------------
	// add game to the record of won games so that it can be displayed during the end sequence
	//--------------------------------------------------------------------------------------------------------
	function microgame_add_to_played_record(_microgame_key){
	
		array_push(played_record, {
			game: _microgame_key,
			dist: 0,
			spd: 0,
			wait: irandom(60*2),
			state: 0,
			scale: ou_games_global_scale,
			pullback:0,
		});
	}

}