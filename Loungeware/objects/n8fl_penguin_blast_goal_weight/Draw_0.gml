draw_self();

var blast_player = n8fl_penguin_blast_player;
if(!instance_exists(blast_player)){
	exit;	
}

var scale = 0.8;
var spr_height = sprite_get_height(n8fl_penguin_blast_projectile_spr) * scale;

for(var i=0; i < ds_list_size(blast_player.score_list); i++){
	var yy = i * spr_height / 2  + 1;

	draw_sprite_ext(
		n8fl_penguin_blast_projectile_spr, 
		blast_player.score_list[| i], 
		x, 
		y - yy - spr_height / 2,
		scale,
		scale,
		0,
		c_white,
		1
	);
}