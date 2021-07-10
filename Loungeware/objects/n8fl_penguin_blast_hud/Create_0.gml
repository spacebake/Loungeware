intensity = 0;

_win_wave = new n8fl_FWave(0.2, 1);

make_intense = function(){
	intensity = 1;	
}

_draw = function(){
	var blast_player = n8fl_penguin_blast_player;

	if(instance_exists(blast_player) == false){
		exit;	
	}

	var chaos = (1 + sin(TIME_REMAINING)) / 2;

	intensity -= 0.05;
	intensity = max(0, intensity);

	var angle_min = -10;
	var angle_max = 10;
	var angle = lerp(angle_min, angle_max, chaos) * intensity;

	var scale_min = 2;
	var scale_max = 3;
	var scale = lerp(scale_min, scale_max, chaos * intensity);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	//draw_set_font(fnt_frogtype);
	var p = clamp((((ds_list_size(blast_player.score_list) / blast_player.score_total) * 100) div 10) * 10, 0, 100);
	draw_text_transformed(62, 32, string(p)+"%", scale, scale, angle);

	if(blast_player.game_over){
		_win_wave.play();
		
		var angle_min = -15;
		var angle_max = 15;
		var angle = lerp(angle_min, angle_max, _win_wave.get_value_one());
		
		var scale_min = 1.8;
		var scale_max = 2.3;
		var scale = lerp(scale_min, scale_max, _win_wave.get_value_one());

		draw_set_color(blast_player.did_win ? c_green : c_gbpink);
		draw_text_transformed(room_width/2,room_height/2-20, blast_player.did_win ? "PENGUIN SAVED" : "PENGUIN DEAD", scale, scale, angle);
	}

}