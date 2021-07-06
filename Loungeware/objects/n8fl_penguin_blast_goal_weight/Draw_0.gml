draw_self();

var blast_player = n8fl_penguin_blast_player;
if(!instance_exists(blast_player)){
	exit;	
}

var spr_height = sprite_get_height(n8fl_penguin_blast_projectile_spr);

for(var i=0; i < ds_list_size(blast_player.score_list); i++){
	var yy = i * spr_height / 2;
	draw_sprite(n8fl_penguin_blast_projectile_spr, blast_player.score_list[| i], x, y - yy - spr_height / 2);
}