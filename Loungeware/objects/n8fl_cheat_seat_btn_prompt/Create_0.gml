enum n8fl_cheat_seat_EBtnType {
	Left = -1,
	Right = 1
}

enum n8fl_cheat_seat_EBtnImage {
	Primary,
	Secondary,
	Left,
	Right
}

_transform = new n8fl_FTransform(x,y);
_fade_out_tween = new n8fl_FTween(1, 0, 0.5);
_target_size = 1;
_size_min = 0.5;
_size_max = 1;

image_speed = 0;
depth = - room_height;

_init = function(){
	inst_n8fl_cheat_seat_player.d_busted.once(_on_player_busted);
}

_tick = function(){
	image_index = button_dir == n8fl_cheat_seat_EBtnType.Left ? n8fl_cheat_seat_EBtnImage.Left : n8fl_cheat_seat_EBtnImage.Right;
	image_alpha += _fade_out_tween.get_delta();
	
	_target_size = _size_min;
	
	var is_active = false;
	if(
		inst_n8fl_cheat_seat_player.get_target_desk() == inst_n8fl_cheat_seat_desk_left && 
		button_dir == n8fl_cheat_seat_EBtnType.Left
	){
		is_active = true;
	}
	
	if(
		inst_n8fl_cheat_seat_player.get_target_desk() == inst_n8fl_cheat_seat_desk_right && 
		button_dir == n8fl_cheat_seat_EBtnType.Right
	){
		is_active = true;
	}
	
	
	if(is_active && inst_n8fl_cheat_seat_player.is_cheating()){
		image_index =  button_dir == n8fl_cheat_seat_EBtnType.Left ? n8fl_cheat_seat_EBtnImage.Secondary : n8fl_cheat_seat_EBtnImage.Primary;
		_target_size = _size_max;
		if((KEY_PRIMARY_PRESSED && button_dir == n8fl_cheat_seat_EBtnType.Right) || (KEY_SECONDARY_PRESSED && button_dir == n8fl_cheat_seat_EBtnType.Left)){
			image_xscale+=0.5;
			inst_n8fl_cheat_seat_player.perform_cheat();
		}
	}else if(is_active && inst_n8fl_cheat_seat_player.is_cheating() == false){
		_target_size = _size_max;
	}
	
	var scale = n8fl_impossible_move_to(image_xscale, _target_size, 0.2);// + _rumble_wave.get_value_one();// * _rumble_tween.get_normalized_value();
	image_xscale = scale;
	image_yscale = scale;
}

_draw = function(){
	draw_self();	
}

_on_player_busted = function(){
	_fade_out_tween.play();
}

n8fl_execute_next_once(_init);