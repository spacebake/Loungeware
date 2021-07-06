var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}

var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(fnt_frogtype);

var _x = 240 / 2;
var _y = 160 / 2 - 42;

if(reach_player.is_dead){
	draw_text_transformed(_x, _y, "DEAD", 1, 1, 0);
	exit;
}

if(reach_player.is_win){
	draw_text_transformed(_x, _y, "WIN", 1, 1, 0);
	exit;
}

if(t >= reach_player.draw_time){
	draw_text_transformed(_x, _y, "REACH FOR IT", 1, 1, 0);
	
	for(var i=0; i < reach_player.combo_max; i++){
		draw_sprite_ext(
			n8fl_reach_for_it_mister_btn_prompt_spr, 
			reach_player.combo[i], 
			_x + i * 32 - (reach_player.combo_max -1) * 16, 
			_y + 24, 
			1, 
			1, 
			0, 
			c_white, 
			reach_player.combo_index == i ? 1 : 0.5
		);
	}
	
}else{
	if(t > 0.3){
		var tt = (t - 0.3) / 0.2;
		var _xx = lerp(_x-20, _x, clamp(tt, 0, 1));
		//draw_text_transformed(_xx, _y, "Wait For It", 1, 1, 0);
	}

	if(t > 0.1){
		var tt = (t - 0.1) / 0.2;
		var _xx = lerp(_x-20, _x, clamp(tt, 0, 1));
	
		tt = (t-0.15) / 0.2;
		var alpha = lerp(1, 0, tt);
	
		draw_set_alpha(alpha);
		draw_text_transformed(_xx, _y, "Ready?", 1, 1, 0);
		draw_set_alpha(1);
	}
}
