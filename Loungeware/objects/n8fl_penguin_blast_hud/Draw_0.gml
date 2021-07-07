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
var p = (((ds_list_size(blast_player.score_list) / blast_player.score_total) * 100) div 10) * 10;
draw_text_transformed(62, 32, string(p)+"%", scale, scale, angle);

if(blast_player.game_over){
	draw_text_transformed(room_width/2,room_height/2-20, blast_player.did_win ? "PENGUIN SAVED" : "PENGUIN DEAD", 1.5, 1.5, 0);
}
