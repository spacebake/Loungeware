var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}
cloud_x+=0.2;
draw_sprite(n8fl_reach_for_it_mister_sand_spr, 0, 0, 116);

var xx = reach_player.par_scroll * 0.1;
draw_sprite(n8fl_reach_for_it_mister_plateu_spr, 0, 88 + xx, 78);

xx = reach_player.par_scroll * 0.5;
draw_sprite(n8fl_reach_for_it_mister_cactus_foreground_spr, 0, 140 + xx, 56);

xx = reach_player.par_scroll * 0.3;
draw_sprite(n8fl_reach_for_it_mister_cactus_background_spr, 0, 15 + xx, 68);

xx = reach_player.par_scroll * 0.1;
draw_sprite(n8fl_reach_for_it_mister_cloud_spr, 0, 7 + xx + cloud_x, 7);


