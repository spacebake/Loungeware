if (gallery_mode && gallery_init &&  microgame_current_metadata.supports_difficulty_scaling){
	if (state == "wait") state = "pause_room";
	gallery_init = false;
	array_insert(menu, 1, {name:"DIFFICULTY", execute: function(){___obj_pause.confirm_shake_timer = 0;}});
}

beat_count_prev = beat_count;
beat_count = floor((audio_sound_get_track_position(jam_id)-(beat_interval)) / beat_interval);

if (beats mod 8 == 0){
	if (!larold_changed){
		larold_frame = used_frames[| 0];
		ds_list_delete(used_frames, 0);
		if (ds_list_size(used_frames) <= 0) populate_frame_list();
		larold_changed = true;
	}
} else {
	larold_changed = false;
}

beat_prog = audio_sound_get_track_position(jam_id)

if (beat_count > beat_count_prev){
		beated = 0.5 + (0.5 * beat_alt);
		beat_alt = !beat_alt;
		if (beat_alt) double_alt = -double_alt;
		beats += 1;
}
beated = max(0, beated - (1/5));

if (state == "wait"){
	if (room == ___rm_restroom){
		state = "pause_room";
	} else {
		if (___KEY_PAUSE_PRESSED){
			___MG_MNGR.pause_cooldown = 1;
			instance_destroy();
		}
	}
}

if (state == "paused"){
	
	var _vmove = -KEY_UP + KEY_DOWN;
	var _confirm = KEY_PRIMARY_PRESSED;
	var _menu_len = array_length(menu);
	if (_vmove != last_v_move){
		input_cooldown = 0;
		input_is_scrolling = false;
	}
	last_v_move = _vmove;
	if (abs(_vmove) && input_cooldown <= 0){
		if (input_is_scrolling){
			input_cooldown = input_cooldown_max;
		} else {
			input_cooldown = input_cooldown_init_max;
			input_is_scrolling = true;
		}
		___sound_menu_tick_vertical();
	} else {
		_vmove = 0;
		input_cooldown = max(0, input_cooldown - 1);
	}
	cursor += _vmove;
	if (cursor >= _menu_len) cursor = 0;
	if (cursor < 0) cursor = _menu_len - 1;
	
	if (_confirm){
		confirm_shake_timer = confirm_shake_timer_max;
		menu[cursor].execute();

		//var _snd_index  = ___snd_cart_insert;
		//var _snd_id = audio_play_sound(_snd_index, 0, 0);
		// var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
	}
	
	if (!_confirm) && (___KEY_PAUSE_PRESSED || KEY_SECONDARY_PRESSED){
		state = "end";
	}
}

confirm_shake_timer = max(0, confirm_shake_timer-1);
	
// deactivate instances after screenshot is taken and surface is resized
if (state == "pause_room"){
	
	with(all){
		var not_pause = id != other.id;
		var not_global = object_index != ___global;
		
		if (not_pause && not_global){
			instance_deactivate_object(id);
			array_push(other.deactivated_instances, id);
		}
	}
	
	// pause sounds
	var _active_audio_list = ___global.___audio_active_list;
	for (var i = 0; i < ds_list_size(_active_audio_list); i++){
		var _snd_id = _active_audio_list[| i];
		if (!audio_is_paused(_snd_id)){
			array_push(paused_sounds, _snd_id);
			audio_pause_sound(_snd_id);
		}
	}
	
	___reset_draw_vars();
	state = "paused";
	
}

if (state == "end"){
	for (var i = 0; i < array_length(deactivated_instances); i++){
		var _id = deactivated_instances[i];
		instance_activate_object(_id);
	}
	
	if (jam_id != noone && audio_is_playing(jam_id)) audio_stop_sound(jam_id);
	
	for (var i = 0; i < array_length(paused_sounds); i++){
		var _snd_id = paused_sounds[i];
		audio_resume_sound(_snd_id);
	}

	with(___MG_MNGR){
		pause_cooldown = 1;
		if (room != ___rm_restroom){
			audio_stop_all();
			___state_change("playing_microgame");
			microgame_start(microgame_current_name);
		}
	}
	
	instance_destroy();
}
		
step++;