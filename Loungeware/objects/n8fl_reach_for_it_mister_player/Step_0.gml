var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;

par_scroll += (100 - par_scroll) * 0.05;

if(is_dead || is_win){
	exit;	
}

if(combo_index >= combo_max){
	is_win = true;
	exit;	
}

if(t >= dead_time){
	is_dead = true;
	image_angle=90;
	exit;
}

if(t >= draw_time){
	var next = combo[combo_index];
	var pressed = -1;
	
	if(KEY_DOWN_PRESSED){
		pressed = 0;
	}else if(KEY_LEFT_PRESSED){
		pressed = 1;
	}else if(KEY_RIGHT_PRESSED){
		pressed = 2;
	}
	
	if(pressed == next){
		combo_index++;
	}else if(pressed != -1){
		combo_index = 0;	
	}
}
