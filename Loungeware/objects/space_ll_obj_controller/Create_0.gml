function value_in_array(val, array){
	for (var i = 0; i < array_length(array); i++){
		if (array[i] == val) return true;
	}
	return false;
}

function smooth_move(_current_val, _target_val, _minimum, _divider){
	
//# ALLOW banned-functions
	if (object_index == ___MG_MNGR){
//# WARN banned-functions
		_divider = (_divider / transition_speed);
		_minimum = (_minimum * transition_speed);
	}
	
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

time_allowed = 60*2;
col_floor = make_color_rgb(165, 98, 67);
col_bg = make_color_rgb(40, 19, 24);
col_shadow_lineup = make_color_rgb(136, 87, 70);
col_baku_shadow = make_color_rgb(36,15,22);
shadow_dir = 0;

state = /*"selected_incorrectly"*/"wait";
substate = 0;
wait = 18;

fade_alpha = 0;

// create suspects
max_suspects = 3;
seperation = -5;
frames_per_char = 6;
suspect_pool_size = sprite_get_number(space_ll_spr_larolds)/frames_per_char;
suspect_w = 80;
suspects = [];
used_indexes = [];
used_numbers = [];

suspects_total_w = ((max_suspects-1) * seperation) + (max_suspects * suspect_w)
base_x = (room_width - suspects_total_w)/2;

for (var i = 0; i < max_suspects; i++){
	suspects[i] = {};
	var _suspect= suspects[i];
	
	var _base_image = noone;
	while (value_in_array(_base_image, used_indexes) || _base_image == noone) _base_image = irandom(suspect_pool_size-1) * frames_per_char;
	_suspect.base_image = _base_image;
	array_push(used_indexes, _base_image);
	
	var _card_number = noone;
	while(value_in_array(_card_number, used_numbers) || _card_number == noone) _card_number = irandom(2)+1;
	_suspect.card_number = _card_number;
	array_push(used_numbers, _card_number);
	
	_suspect.x_goto = base_x + (i*(suspect_w+seperation));
	_suspect.x = _suspect.x_goto + room_width;
	_suspect.image = _suspect.base_image + _suspect.card_number;
	_suspect.shaking = 0;
	_suspect.shake_set = false;
	_suspect.sx = 0;
	_suspect.sy = 0;
}



// DIFFICULTY 1 -------------------------------------
// (numbers always in order 1, 2, 3)
if (DIFFICULTY == 1){
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			card_number = i+1;
			image = base_image + card_number;
		}
	}
}
// DIFFICULTY 2 -------------------------------------
// (numbers always in reverse: 3, 2, 1)
if (DIFFICULTY == 2){
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			card_number = array_length(other.suspects) - i;
			image = base_image + card_number;
		}
	}
}
	
// DIFFICULTY 3 -------------------------------------
// numbers are always random order but never in order or reverse order
if (DIFFICULTY >= 3){
	var _new_order = choose([2, 3, 1], [1, 3, 2], [2, 1, 3], [3, 1, 2]);
	for (var i = 0; i < array_length(suspects); i++){
		with (suspects[i]){
			card_number = _new_order[i];
			image = base_image + card_number;
		}
	}
}

if (DIFFICULTY == 4){
	time_allowed = time_allowed * 0.5;
}

if (DIFFICULTY == 5){
	time_allowed = time_allowed * 0.2;
}

guilty_suspect_index = irandom(max_suspects-1);
guilty_suspect = suspects[guilty_suspect_index];
show_lineup = true;
show_menu = false;
poster_y_begin = -(room_height*2);
poster_y = poster_y_begin
poster_prog = 0;
selected = 0;
confirmed = false;
is_correct = false;
paper_dir = 0;
baku_dir = 0;
baku_frame = 0;
exclamation_frame = 0;
exclamation_alpha = 0;
baku_shake = 0;
step = -1;
voice_playing = noone;
hmm_played = false;
spr_freezeframe = noone;
show_freezeframe = false;
surf_freezeframe = noone;
show_answers = false;
answershake = 0;

bars_x = room_width;
show_bars = false;
screenshake = 0;

baku_throw_start_x = -40;
baku_throw_end_x = room_width/2;
baku_throw_x = baku_throw_start_x;


show_baku_throw = false;
baku_throw_frame = 0;
baku_throw_frame_prev = -1;

bars_done = false;
bars_started = false;

bars_shake_x = 0;
bars_shake_y = 0;

function shader_shadow_on(_color){
	var _r1 = (color_get_red(_color)/255) + 0.0;
	var _g1 = (color_get_green(_color)/255) + 0.0;
	var _b1 = (color_get_blue(_color)/255) + 0.0;
	var _shadow_col = shader_get_uniform(space_ll_shd_shadow, "shadow_col");
	shader_set(space_ll_shd_shadow);
	shader_set_uniform_f_array(_shadow_col, [_r1, _g1, _b1, 1.0]);
}

function play_voice(_snd){
	if (voice_playing != noone && !is_undefined(voice_playing) && audio_is_playing(voice_playing)) audio_stop_sound(voice_playing);
	voice_playing = sfx_play(_snd, 1, false);
}
