var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}
var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;

var xx = reach_player.par_scroll * 0.6;
x = start_x + xx - 100;
draw_self();




draw_self();

if(t >= reach_player.draw_time){
	draw_sprite_ext(n8fl_reach_for_it_mister_gun_spr, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);	
}