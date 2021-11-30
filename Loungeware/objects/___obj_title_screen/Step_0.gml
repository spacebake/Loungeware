any_key = KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED || ___KEY_PAUSE_PRESSED;
if (step <= 10) any_key = false;
___state_handler();

if (state == "wait"){
	wait--;
	if (wait <= 0) ___state_change("intro");
}

if (state == "intro"){
	if (state_begin){
		bg_layer = layer_background_get_id(layer_get_id("Background"));
		layer_background_visible(bg_layer, false);
		bg_show = true;
		sng_id = audio_play_sound(___sng_zandintro, 0, 1);
		logo_show_pump = true;
	}
	beat_count_prev = beat_count;
	beat_count = floor((audio_sound_get_track_position(sng_id)-(beat_interval)) / beat_interval);
	next_beat_prog = ((audio_sound_get_track_position(sng_id)-(beat_interval)) / beat_interval) - beat_count;
	
		
	ribbon_hide_prog = ___smooth_move(ribbon_hide_prog, 0, 0.01, 6);
	if (ribbon_hide_prog > 0) label_x = label_x_snap_target;
	

	label_x = ___smooth_move(label_x, label_x_snap_target, 0.5, 3);
	
	if (beat_count > beat_count_prev){
		label_x_snap_target -= (label_w + label_sep);
		trigger_pump = true;
		offbeat_timer = (beat_interval / 2)*60;
	}

	if (label_x_snap_target <= label_x_min){
		label_x += label_w_total;
		label_x_snap_target = label_x - (label_w + label_sep);
	}
	


	
	if (any_key){
		___state_change("close");
		logo_shake = 10;
		___sound_menu_select();
		audio_sound_gain(sng_id, 0, 500);
		logo_draw_last = true;
		any_key = false;
	}

}


// skip
if (state == "close" || state == "logo_move") && (any_key){
	if (audio_is_playing(sng_id)) audio_stop_sound(sng_id);
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
		logo_disable_zoom_intro = true;
	}
	instance_destroy();
	exit;
}

if (state == "close"){
	close_circle_prog = max(0, close_circle_prog - (1/30));
	if (close_circle_prog <= 0) close_wait--;
	if (close_wait <= 0){
		//instance_create_layer(0, 0, layer, ___obj_main_menu);
		//instance_destroy();
		___state_change("logo_move");
	}
}

if (state == "logo_move"){

	if (state_begin){
		___play_sfx(___snd_score_pulse_1, 0.4, 1.5);
		next_beat_prog = 0;
	}

	if (substate == 0){
		if (logo_show_pump && logo_scale <= 1){
			logo_show_pump = false;
			logo_scale = 1;
			___substate_change(substate+1);
		}
	} 
	
	if (substate == 1){
		var _div = 5;
		logo_scale = ___smooth_move(logo_scale, 0.5, 0.002, _div);
		logo_y = ___smooth_move(logo_y, logo_end_target, 0.5, _div);
		logo_scale_master = max(0, logo_scale_master - (1/10));
		if (logo_scale <= 0.5 && logo_y == logo_end_target){
			logo_scale = 0.5;
			logo_y = logo_end_target;
			
			___substate_change(substate+1);
		}
	}
	
	if (substate == 2){
		if (audio_is_playing(sng_id)) audio_stop_sound(sng_id);
		instance_create_layer(0, 0, layer, ___obj_main_menu);
		instance_destroy();
	}
}

if (logo_show_pump){
	var _pump_scale, _pump_speed;
	if (logo_pumpstate == 0){
		_pump_scale = 1.2;
		_pump_speed = 15
		logo_scale = abs(lengthdir_y(_pump_scale, logo_scale_dir));
		if (logo_scale_dir > 90 && logo_scale <= 1){
			logo_pumpstate++;
			
			logo_scale = 1;
			logo_scale_dir = 180;
		}
		logo_scale_dir += _pump_speed;
	}

	if (logo_pumpstate == 1){
		_pump_speed = 20;
		_pump_scale = 1.05;
		if (trigger_pump){
			logo_scale_dir = 0; 
			trigger_pump = false;
		}
		
		var _extra_scale = abs(lengthdir_y(_pump_scale-1, logo_scale_dir));
		logo_scale = 1 + _extra_scale;
		logo_scale_dir = min(180, logo_scale_dir + _pump_speed);
	}
}

if (logo_show_pump) bg_alpha_multiplier = min(1, bg_alpha_multiplier+(1/10));
bg_alpha = ___toggle_fade(bg_alpha, bg_show, 20);
logo_shake = max(0, logo_shake - 1);
mimpytimer = max(0, mimpytimer - 1);
if (mimpytimer <= 0 && !mimpydone){
	mimpydone = true;
	instance_create_layer(0, 0, layer, ___obj_title_actor_mimp);
}
step++;

