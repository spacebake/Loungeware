//-------------------------------------------------------------------------------------
// ADVANCED TEXT
//-------------------------------------------------------------------------------------
_DTA_WAVE_DIR = _DTA_WAVE_DIR + _DTA_WAVE_SPEED;
if (_DTA_WAVE_DIR >= 360) _DTA_WAVE_DIR -= 360;

// count down timers on alive letters
for (var i = 0; i < ds_list_size(active_char_timer_list); i++){
	var time_remaining = active_char_timer_list[| i];
	
	// count down timer
	time_remaining = max(0, time_remaining-1);
	
	// if timer is finished, remove index and timer from both lists
	if (time_remaining <= 0){
		
		ds_list_delete(active_char_id_list, i);
		ds_list_delete(active_char_timer_list, i);
	} else { // else, update the remaining time in list
		
		active_char_timer_list[| i] = time_remaining;	
	}
}

// add new alive letters
if (!irandom(new_active_char_frequency)){
	
	// pick a random char id from list of letters currently being drawn
	var random_potential_char = ds_list_find_value(active_char_potential_letters, irandom(ds_list_size(active_char_potential_letters)-1));
	
	// add it to the active char list (if it isn't already in there)
	if (ds_list_find_index(active_char_id_list, random_potential_char) == -1){
		ds_list_add(active_char_id_list, random_potential_char);
		ds_list_add(active_char_timer_list, active_char_timer_max);
	}
}

// clear the potential char list every step so it can be updated
ds_list_clear(active_char_potential_letters);