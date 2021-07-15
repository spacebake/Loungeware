any_key = KEY_PRIMARY || KEY_SECONDARY || ___KEY_PAUSE;

if (state == "intro"){
	beat_count_prev = beat_count;
	beat_count = floor((audio_sound_get_track_position(sng_id)-(beat_interval)) / beat_interval);
	

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
		state = "close";
		audio_stop_sound(sng_id);
	}

}

step++;