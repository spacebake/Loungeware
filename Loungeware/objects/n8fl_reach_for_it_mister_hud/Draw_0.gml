var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}

var rake = n8fl_reach_for_it_mister_rake;
if(instance_exists(rake) == false){
	exit;	
}

var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;
draw_set_color(make_colour_rgb(61,51,51));

draw_set_font(fnt_frogtype);

var _x = 240 / 2;
var _y = 160 / 2 - 20;

var _scale1 = 1;
var _scale2 = 2;

if(reach_player.game_over){
	_scale1 = lerp(1.0, 1.2, (1 + sin((get_timer()/100000) * 1.2) / 2)); 
	_scale2 = lerp(1.0, 1.2, (1 + sin(((get_timer()/100000)+r) * 1.2) / 2)); 
}
	

draw_set_halign(fa_center);
draw_set_valign(fa_center);

if(reach_player.game_over){
	if(reach_player.is_dead && rake.is_dead){
		draw_text_transformed(_x, _y, "DRAW", 1, 1, 0);
		microgame_win();
	}else if(reach_player.is_dead){
		draw_text_transformed(_x, _y, "DEAD", 1, 1, 0);
		microgame_fail();
	}else if(rake.is_dead){
		draw_text_transformed(_x, _y, win_message, _scale1, _scale1, 0);
		microgame_win();
	}
}

if(t >= reach_player.draw_time){
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text_transformed(12, 12, string(time), _scale2, _scale2, 0);
	
	if(rake.is_dead == false && reach_player.is_dead == false){
		time += delta_time / 1000000;
	}
	
	if(reach_player.game_over == false){
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_text_transformed(_x, _y, "REACH FOR IT", 1, 1, 0);
	
		for(var i=0; i < reach_player.combo_max; i++){
			if(reach_player.combo_index == i){
				draw_sprite_ext(
					n8fl_reach_for_it_mister_btn_prompt_outline_spr, 
					reach_player.combo[i], 
					_x + i * 32 - (reach_player.combo_max -1) * 16, 
					_y + 24, 
					1.1,
					1.1,
					0, 
					c_white, 
					1
				);
			}
			if(reach_player.combo_index <= i){
				draw_sprite_ext(
					n8fl_reach_for_it_mister_btn_prompt_spr, 
					reach_player.combo[i], 
					_x + i * 32 - (reach_player.combo_max -1) * 16, 
					_y + 24, 
					reach_player.combo_index == i ? 1.1 : 1, 
					reach_player.combo_index == i ? 1.1 : 1, 
					0, 
					c_white, 
					reach_player.combo_index == i ? 1 : 0.5
				);
			}
		}
	}
	
}

var limit = 0.15;
if(t > limit){
	var tt = (t - limit) / limit;
	var _xx = lerp(_x-20, _x, clamp(tt, 0, 1));
	
	tt = (t-limit-0.10) / limit;
	var alpha = lerp(1, 0, tt);
	
	draw_set_alpha(alpha);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text_transformed(_xx, _y, "Ready?", 1, 1, 0);
	draw_set_alpha(1);
}
