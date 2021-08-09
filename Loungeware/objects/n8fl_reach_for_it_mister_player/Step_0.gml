par_scroll += (par_scroll_max - par_scroll) * par_speed;

event_inherited();


if(combo_index >= combo_max){
	is_win = true;
}

var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;
if(t >= dead_time){
	if (!game_over){
		var end_snd = n8fl_reach_for_it_mister_lose_snd;
		if (is_win){
			end_snd = n8fl_reach_for_it_mister_win_snd;
		}
		sfx_play(end_snd, 0.7, false);
	}
	game_over = true;
	exit;
}

if(is_dead || is_win){
	exit;	
}



if(t >= draw_time && combo_index < combo_max){
	var next = combo[combo_index];
	var pressed = -1;
	
	if(KEY_DOWN_PRESSED){
		pressed = 0;
	}else if(KEY_LEFT_PRESSED){
		pressed = 1;
	}else if(KEY_RIGHT_PRESSED){
		pressed = 2;
	}else if(KEY_PRIMARY_PRESSED){
		pressed = 3;	
	}else if(KEY_SECONDARY_PRESSED){
		pressed = 4;	
	}
	
	if(pressed == next){
		spawn_emote(next);
		combo_index++;
		shoot(combo_index < combo_max);
	}else if(pressed != -1){
		combo_index = 0;
		spawn_emote(game_pieces_num);
		shoot(true);
	}
}
