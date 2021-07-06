var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}

var par_x = (reach_player.par_scroll - reach_player.par_scroll_max) * 0.6;
x = start_x + offset_x + par_x;
y = start_y + hop_offset;

draw_self();