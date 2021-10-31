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
		
		var _won_last_game = ___MG_MNGR.microgame_won;
		var _is_arcade_mode = (!gallery_mode && !TEST_MODE_ACTIVE);
	
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
	
		
		// if win
		if (_won_last_game){
			log("MG WON!");
			var _game_name = ___MG_MNGR.microgame_current_name;
			var _points = ou_score_per_game + ((DIFFICULTY-1) * ou_score_additional_per_diff);
			larold_index = 1;
			microgame_add_to_played_record(_game_name, _points);
		} 
		
		
		if (!TEST_MODE_ACTIVE){
			// 🤫
			var _mode = "arcade";
			if (gallery_mode) _mode = "gallery";
			var _data = {
				key : ___MG_MNGR.microgame_current_name,
				difficulty : DIFFICULTY,
				win : ___MG_MNGR.microgame_won, 
				player_id : ___global.player_id, 
				mode : _mode,
				game_name : ___MG_MNGR.microgame_current_metadata.game_name,
				is_html : HTML_MODE
			}
			var _json = json_stringify(_data);
			http_post_string(___API_BASE_URL + "stats", _json);
		}
	
		if (_is_arcade_mode){
			
			// increase difficulty by 1 after N consecutive wins
			if (_won_last_game && DIFFICULTY < ___global.difficulty_max){
				games_until_next_diff_up = max(games_until_next_diff_up-1, 0);
				if (games_until_next_diff_up <= 0){
					games_until_next_diff_up = games_until_next_diff_up_max;
					transition_difficulty_up = true;
					___global.difficulty_level = min(___global.difficulty_level + 1, ___global.difficulty_max);
			
				}
			}
			
			// decrease difficulty by 1 after a fail and reset the win counter
			if (!_won_last_game){
				if (DIFFICULTY > 1){
					___global.difficulty_level = max(1, DIFFICULTY - 1);
					transition_difficulty_down = true;
					dd_trigger_shake_diff_down  = true;
				}
				
				games_until_next_diff_up = games_until_next_diff_up_max;
			}
			
		}
	
	
		if (_is_arcade_mode){
			
			// go to next game in playlist (loops back around and shuffles if end of list is reached)
			microgame_playlist_increment();
				
			var _supports_difficulty = function(){
				var _potential_next_microgame_metadata = variable_struct_get(___global.microgame_metadata, microgame_playlist[microgame_playlist_index]);
				return _potential_next_microgame_metadata.supports_difficulty_scaling;
			}
				
			// increment playlist index until a suitable game is found
			while (DIFFICULTY  > support_no_difficulty_up_to_level && !_supports_difficulty()){
				microgame_playlist_increment();
				// note: game will freeze here if there are no enabled microgames in the project that support difficulty scaling
			}
			
			microgame_next_name = microgame_playlist[microgame_playlist_index];
			microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
			
		// repeat last game if gallery mode or test mode
		} else {
			microgame_next_name = microgame_current_name;
			microgame_next_metadata = microgame_current_metadata;
		}
		
		
		
		// go to rest room (lol)
		room_goto(___rm_restroom);
	
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
			microgame_next_name = microgame_playlist[microgame_playlist_index];
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
	function microgame_playlist_shuffle(){
		microgame_playlist = ___array_shuffle(microgame_namelist);
		log("playlist suffled");
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
				floor(canvas_x * window_scale), 
				floor(canvas_y * window_scale),
				floor(canvas_w * window_scale), 
				floor(canvas_h * window_scale),

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
			floor(canvas_x * window_scale), 
			floor(canvas_y * window_scale),
			floor(canvas_w * window_scale), 
			floor(canvas_h * window_scale)
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
		if (!surface_exists(surf_master)){
			var _size = max(5, WINDOW_BASE_SIZE * window_scale);
			surf_master = surface_create(_size, _size);
		}
	
		if (window_scale != prev_window_scale){
			var _size = max(5, WINDOW_BASE_SIZE * window_scale);
			surface_resize(surf_master, _size, _size);
		}
		
		surface_set_target(surf_master);
		draw_clear_alpha(c_white, 0);
		surface_reset_target();
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
	
		if (state == "playing_microgame") exit;
	
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

		if (gb_shake > 0){
			_x += random_range(-gb_shake, gb_shake);
			_y += random_range(-gb_shake, gb_shake);
			gb_shake = max(0, gb_shake-1);
		}

		var _screen_margin = 15;
		var _screen_x = _x + (_screen_margin * _scale);
		var _screen_y = _y + (_screen_margin * _scale);
		if (_spin_lock) draw_reflection(_screen_x, _screen_y, _screen_scale); // < here

	

	
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
		if (_reflection_alpha > 0) draw_rectangle_fix(_x, _y, _x + (surface_get_width(surf_reflection) * _scale), (_y + (surface_get_height(surf_reflection) * _scale) + 2)); 
		draw_surface_ext(surf_reflection, _x, _y, _scale, _scale, 0, c_white, _reflection_alpha);
	}

	//--------------------------------------------------------------------------------------------------------
	// DRAW PROMPT
	//--------------------------------------------------------------------------------------------------------
	function draw_prompt(){

		var _win_h = window_get_height();
		var _win_w = window_get_width();
		var _shake_val = max(0, (prompt_scale - 1) * 15);
		var _shake_x = random_range(-_shake_val, _shake_val);
		var _shake_y = random_range(-_shake_val, _shake_val);
		
		var _prompt_y = -(80) + _shake_y;
		var _prompt_alpha = min(prompt_scale, 1);
	
		var _prompt_x = ((_win_w / 2) - ((_win_h * prompt_scale)/2)) + _shake_x;
		_prompt_y -= (prompt_scale - 1) * (_win_h/2);
	
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

	function microgame_add_to_played_record(_microgame_key, _points){
		tsd_score += _points;
		array_push(played_record, {
			game: _microgame_key,
			dist: 0,
			spd: 0,
			wait: irandom(60*2),
			state: 0,
			scale: ou_games_global_scale,
			pullback:0,
			points: _points,
		});
	}

	
	//--------------------------------------------------------------------------------------------------------
	// draw the current score
	//--------------------------------------------------------------------------------------------------------
	function draw_score(_scale=0.5){
		if (gallery_mode || TEST_MODE_ACTIVE) exit;
		
		
		var  _draw_score_box, _score, _score_str, _margin, 
		_xx, _yy, _padding_x1, _padding_y1, 
		 _sv, _store_halign, _store_col, _store_font, 
		_store_alpha, _y_offset, _meter_x, _meter_y;
		
		_y_offset = 60 * (1-tsd_alpha);
		
		var _draw_score_box = function(_x1, _y1, _x2, _sep_x, _scale){
			var _spr = ___spr_gui_score_display_box;
			var _w = sprite_get_width(_spr) * _scale;
			for (var _xx = _x1; _xx < _x2; _xx += _w){
				var _frame = 0;
				draw_sprite_ext(_spr, _frame, _xx, _y1, _scale, _scale, 0, c_white, draw_get_alpha());
			}
			draw_sprite_ext(_spr, 1, _x1, _y1, _scale, _scale, 0, c_white, draw_get_alpha());
			draw_sprite_ext(_spr, 1, _x2, _y1, _scale, _scale, 0, c_white, draw_get_alpha());
			draw_sprite_ext(_spr, 1, _sep_x, _y1, _scale, _scale, 0, c_white, draw_get_alpha());
		}
		
		_score = tsd_score;
		_score_str = string(_score);
		while (string_length(_score_str) < 4) _score_str = "0" + _score_str;
		
		_store_halign = draw_get_halign();
		_store_col = draw_get_color();
		_store_font = draw_get_font();
		_store_alpha = draw_get_alpha();
		draw_set_halign(fa_left);
		draw_set_color(tsd_col);
		draw_set_font(fnt_frogtype);
		draw_set_alpha(tsd_alpha);
		gpu_set_colorwriteenable(1, 1, 1, 0);
		
		_margin = 6;
		_xx = 30;
		_yy = ( VIEW_H - 28) + _y_offset;
		_padding_x1 = 2.5;
		_padding_y1 = 2.5;
	
		//if (tsd_shake_timer > 0){
		//	_sv = (tsd_shake_timer / tsd_shake_max) * 4;
		//	_xx += random_range(-_sv, _sv);
		//	_yy += random_range(-_sv, _sv);
		//}
		

		// draw score bar
		draw_sprite_ext(___spr_diff_meter, 2, _xx, _yy, _scale, _scale, 0, c_white, draw_get_alpha());
		
		// draw score text
		var _text_x = _xx + 3;
		var _text_y = _yy + 11;
		draw_set_font(___global.___fnt_transition_score);
		draw_set_color(c_gbwhite);
		draw_text_transformed(_text_x, _text_y, _score_str, _scale, _scale, 0);
		
		// draw meter
		_meter_x = _xx;
		_meter_y = _yy;
		if (tsd_shake_timer > 0 || tsd_draw_diff >= 5){
			_sv = (tsd_shake_timer / tsd_shake_max) * 5;
			if (tsd_draw_diff >= 5) _sv = 0.5;
			_meter_x += random_range(-_sv, _sv);
			_meter_y += random_range(-_sv, _sv);
		}
		draw_diff_meter(_meter_x, _meter_y);



		gpu_set_colorwriteenable(1, 1, 1, 1);
		draw_set_halign(_store_halign);
		draw_set_color(_store_col);
		draw_set_font(_store_font);
		draw_set_alpha(_store_alpha);
	}
	
	// ------------------------------------------------------------------------------------------
	// draw difficulty meter
	// ------------------------------------------------------------------------------------------
	function draw_diff_meter(_x, _y, _scale=0.5){
		static _current_dir = 180;
		var _diff_is_max = (tsd_draw_diff >= 5);
		var _dir_lock = [180, 135, 90, 45, 0];
		var _dir_goto = _dir_lock[tsd_draw_diff-1];
		_current_dir = ___smooth_move(_current_dir, _dir_goto, 0.1, 12);
		var _dir_draw = _current_dir;
		if (_diff_is_max) _dir_draw += random_range(-4,4);
		
		draw_sprite_ext(___spr_diff_meter, 0, _x, _y, _scale, _scale, 0, c_white, draw_get_alpha());
		var _red_alpha = (tsd_draw_diff-1)/4;
		draw_sprite_ext(___spr_diff_meter, 3, _x, _y, _scale, _scale, 0, c_white, _red_alpha * draw_get_alpha());
		draw_sprite_ext(___spr_diff_meter, 1, _x, _y, _scale, _scale, _dir_draw, c_white, draw_get_alpha());
		
		var _part_x_range = 26 * _scale;
		if (_diff_is_max && !irandom(8)) particle_fire_create(_x + random_range(-_part_x_range, _part_x_range), _y);
		particle_fire_draw();
	}
	
	// ------------------------------------------------------------------------------------------
	// increment playlist index
	// ------------------------------------------------------------------------------------------
	function microgame_playlist_increment(){
		var _store_previous = microgame_playlist[microgame_playlist_index];
		microgame_playlist_index++;
		
		if (microgame_playlist_index >= array_length(microgame_playlist)){
			microgame_playlist = ___array_shuffle(microgame_namelist);
			microgame_playlist_index = 0;
			if (microgame_playlist[0] == _store_previous) microgame_playlist_index++;
			
		}
	}
	
	// ------------------------------------------------------------------------------------------
	// create spark particle
	// ------------------------------------------------------------------------------------------
	function particle_fire_create(_x, _y){
		var _part = {
			x : _x,
			y : _y,
			vsp : random_range(-3, -1),
			hsp : random_range(-0.5, 0.5),
			grav : random_range(0.15, 0.2),
			grav_max : random_range(0.5, 0.75),
			deaccel : random_range(0.95, 0.99),
			alpha : 1 - random(0.2),
			frame : irandom(sprite_get_number(___spr_diff_fire_part)-1),
		}
		array_push(tsd_flame_parts, _part);
	}
	
	// ------------------------------------------------------------------------------------------
	// draw spark particle
	// ------------------------------------------------------------------------------------------
	function particle_fire_draw(){
		for (var i = 0; i < array_length(tsd_flame_parts); i++){
			with (tsd_flame_parts[i]){	
				draw_sprite_ext(___spr_diff_fire_part, frame, x, y, 1, 1, 0, c_white, alpha * draw_get_alpha());
			}
		}
	}
	
	// ------------------------------------------------------------------------------------------
	// move spark particle
	// ------------------------------------------------------------------------------------------
	function particle_fire_move(){
		for (var i = 0; i < array_length(tsd_flame_parts); i++){
			with (tsd_flame_parts[i]){
				vsp = min(grav_max, vsp + grav);
				hsp = hsp * deaccel;
				if (vsp >= grav_max) alpha -= (1/10);
				x += hsp;
				y += vsp;
				if (alpha <= 0){
					array_delete(other.tsd_flame_parts, i, 1);
					i--;
				}
			}
		}
		log(array_length(tsd_flame_parts));
	}

}