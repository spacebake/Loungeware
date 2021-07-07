var blast_player = n8fl_penguin_blast_player;
if(!instance_exists(blast_player)){
	exit;	
}
weight_t += (blast_player.score_t - weight_t) * 0.05;
weight_t = clamp(weight_t, 0, 1);
y = lerp(start_y, end_y, weight_t);