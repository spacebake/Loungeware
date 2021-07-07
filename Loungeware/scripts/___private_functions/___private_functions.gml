//--------------------------------------------------------------------------------------------------------
// checks if key is held using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check(_list[i])) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// DRAW RECTANGLE FIX
// draws a rectangle but with 1 pixel removed from the x2 and y2 values
//--------------------------------------------------------------------------------------------------------
function draw_rectangle_fix(_x1, _y1, _x2, _y2){
	draw_rectangle(_x1, _y1, _x2 - 1, _y2 - 1, 0);
}

	
//--------------------------------------------------------------------------------------------------------
// checks if key is pressed using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check_pressed(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check_pressed(_list[i])) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// checks if key is released using ___global.default_input_keys. provide a string as the property name for key type
//--------------------------------------------------------------------------------------------------------
function ___macro_keyboard_check_released(_keystr){
	var _list =  variable_struct_get(___global.default_input_keys, _keystr);
	for (var i = 0; i < array_length(_list); i++){
		if (keyboard_check_released(_list[i])) return true;
	}
	return false;
}

//--------------------------------------------------------------------------------------------------------
// LOAD FAKE MICROGAME
// loads a fake microgame as the first game to pop out of the gameboy, no game is actually attached to it
//--------------------------------------------------------------------------------------------------------
function ___microgame_load_fake(){

		var _cart = ___get_fake_label();
		
		
		_cart.cartridge_label = ___spr_fake_labels;
		cart_sprite = ___cart_sprite_create(_cart);
		
		microgame_current_metadata = _cart;

		//show_message(microgame_current_metadata);
		microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
		microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME START
// name says it all tbh
//--------------------------------------------------------------------------------------------------------
function ___microgame_start(_microgame_propname){
	
	// init new microgame
	with(___GM){
		
		// garbo the sprites from last cutscene
		while (ds_list_size(garbo_sprites) > 0){
			sprite_delete(garbo_sprites[| 0]);
			ds_list_delete(garbo_sprites, 0);
		}
		
		var _metadata = variable_struct_get(___global.microgame_metadata, _microgame_propname);
		microgame_current_metadata = _metadata;
		microgame_current_name = _microgame_propname;
		
		
		microgame_timer = _metadata.time_seconds * 60;
		microgame_timer_max = _metadata.time_seconds * 60;
		if (dev_mode && _metadata.time_seconds > ___global.max_microgame_time){
			show_message("You are exceeding the maximum amount of time allowed for a microgame. Please make a game that is " + string(___global.max_microgame_time) + " seconds or shorter.\nIf you are just doing this for testing purposes then hit \"ok\" to proceed.");
		}

		microgame_won = false;
		cart_sprite = ___cart_sprite_create(_metadata);
		gb_timerbar_visible = true;
		transition_appsurf_zoomscale = 1;
		transition_circle_rad = canvas_h;
		
		if (_metadata.music_track != noone) microgame_music_start(_metadata.music_track, 1, _metadata.music_loops);
		microgame_music_auto_stopped = false;
		room_goto(_metadata.init_room);
	}
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME END
// name says it all tbh
//--------------------------------------------------------------------------------------------------------
function ___microgame_end(){
	

	
	// update save data
	if (!dev_mode && !gallery_mode){
		var _save_struct = variable_struct_get(___global.save_data.microgame_data, ___GM.microgame_current_name);
		_save_struct.play_count = _save_struct.play_count + 1;
		if (___GM.microgame_won){
			_save_struct.wins = _save_struct.wins + 1;
			var _time_taken = ___GM.microgame_timer_max - ___GM.microgame_time_finished;
			if (_time_taken < _save_struct.best_time) _save_struct.best_time = _time_taken;
		}
	}
	___save_game();
	
	// send to server if data collection on
	if ___global.save_data.data_collection{
		// < CODE GO HERE AT SOME POINT >
	}
		
	// if win
	if (___GM.microgame_won){
		larold_index = 1;
		var _points = 1 + (___GM.microgame_timer / ___GM.microgame_timer_max) + (DIFFICULTY/5);
		___GM.score_total += _points;
	// if lose
	} else {
		//show_message("lose");
		//show_message("time remaining: " + ___GM.microgame_timer);
	}
	
	// destroy and recreate fake global
	with (___fake_global) instance_destroy();
	instance_create_layer(0, 0, layer, ___fake_global);
	// garbage collect any leftover ds structures from microgame
	//___ds_gc_collect()
	workspace_end();
	workspace_begin();
	
	// go to rest room (lol)
	room_goto(___rm_restroom);
	
	// remove game from unplayed list 
	var _index_to_remove = ds_list_find_index(microgame_unplayed_list, ___GM.microgame_current_name);
	ds_list_delete(microgame_unplayed_list, _index_to_remove);
	
	// if uplayed list is empty, repopulate it with all games (excluse the one just played, if possble, see below)
	if (ds_list_size(microgame_unplayed_list) <= 0){
		microgame_populate_unplayed_list();
		
		// if there is more than 1 game, delete the last played game from the new list as to not get repeats
		if (ds_list_size(microgame_unplayed_list) > 1){
			_index_to_remove = ds_list_find_index(microgame_unplayed_list, ___GM.microgame_current_name);
			ds_list_delete(microgame_unplayed_list, _index_to_remove);
		}
	}
	
	// choose next game from uplayed list
	microgame_next_name = microgame_unplayed_list[| irandom_range(0, ds_list_size(microgame_unplayed_list) - 1)];
	microgame_next_metadata = variable_struct_get(___global.microgame_metadata, microgame_next_name);
	
	if (dev_mode && ___global.test_vars.loop_game){
		microgame_next_name = microgame_current_name;
		microgame_next_metadata = microgame_current_metadata;
	}
	
}


//--------------------------------------------------------------------------------------------------------
// SMOOTH MOVE
// moves a number towards another number, slows down as it approaches
//--------------------------------------------------------------------------------------------------------
function ___smooth_move(_current_val, _target_val, _minimum, _divider){
	var _diff = _target_val - _current_val;
	var _store_sign = sign(_diff);
	if (abs(_diff) <= _minimum){
		_current_val = _target_val;
	} else {
		_current_val += max(_minimum/3, abs(_diff / _divider)) * sign(_diff);
		if (_store_sign != sign(_target_val - _current_val)){
			_current_val = _target_val;
		}
	}
	return _current_val;
}


//--------------------------------------------------------------------------------------------------------
// LOG | log multiple values at once
//--------------------------------------------------------------------------------------------------------
function log(){
	var _str = "";
	var _i = 0; repeat(argument_count) {
		_str += string(argument[_i++]) + " | ";    
	}
	show_debug_message(_str);
}

// ------------------------------------------------------------------------------------------
// STATE SETUP || call this in the create event.
// ------------------------------------------------------------------------------------------
function ___state_setup(_starting_state){
	state = _starting_state;
	state_goto = _starting_state;
	state_begin = true;
	substate = 0;
	subsubstate = 0;
	store_substate = 0;
	substate_begin = false;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE FUNCTION | prepares a state change. state won't change until state_handler is called
// state_setup must have been called in the create event to use this function.
// ------------------------------------------------------------------------------------------
function ___state_change(_state_goto){
	// note: when this function is called state_begin is set to TRUE for the next step 
	//(this will happen even if you try to change into a state you are already in).
	state_goto = _state_goto;
}

// ------------------------------------------------------------------------------------------
// STATE CHANGE HANDLER | 
// ------------------------------------------------------------------------------------------
function ___state_handler(){
	state_begin = false;
	substate_begin = false;
	if (state_goto != noone){
		state_begin = true;
		state = state_goto;
		state_goto = noone;
		substate = 0;
		subsubstate = 0;
	}
	
	if (substate !=  store_substate) substate_begin = true;
	store_substate = substate;
	
}

// ------------------------------------------------------------------------------------------
// CENTER GAME WINDOW | clue is in the name
// ------------------------------------------------------------------------------------------
function ___center_window(){
	with (___GM) alarm_set(0, 1);
}

// ------------------------------------------------------------------------------------------
// RESET DRAW VARS
// ------------------------------------------------------------------------------------------
function ___reset_draw_vars(){
	draw_set_color(c_white);
	draw_set_font(fnt_frogtype);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}