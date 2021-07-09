_start_y = y ;
_in_tween = new n8fl_FTween(_start_y - sprite_height, _start_y, 0.8);
_in_tween.play();

_init = function(){
	
}

_tick = function(){
	y = _in_tween.get_delta();
	show_debug_message(y);
}

n8fl_execute_next_once(_init);