var blast_player = n8fl_penguin_blast_player;
if(!instance_exists(blast_player)){
	exit;	
}

if(ds_list_size(phrase) > 0){
	var last_do_shoot = do_shoot;
	do_shoot = image_index > 1;

	if(do_shoot != last_do_shoot){
		var proj = instance_create_depth(x, y, depth, n8fl_penguin_blast_projectile);
		proj.image_index = phrase[| 0];
		ds_list_delete(phrase, 0);
		proj.dest_x = blast_player.x-20;
		proj.dest_y = blast_player.y;
	}
}else{
	image_index = 0;	
}