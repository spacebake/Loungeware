image_speed = 0.21 + (DIFFICULTY / 5) * 0.13;
do_shoot = false;

words = 
[
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Primary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Secondary]
	],
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Secondary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Primary],
	]
];


phrase = ds_list_create();

var max_syl = 15;

while(ds_list_size(phrase) < max_syl){
	var use_hard_ones = true;
	switch(DIFFICULTY){
		case 0:
		case 1:
		case 2:
			use_hard_ones = ds_list_size(phrase) > max_syl / 1.5;
			break;
		case 3:
		case 4:
		case 5:
			use_hard_ones = ds_list_size(phrase) > max_syl / 2
		break;
	}
	
	var group = words[use_hard_ones ? 1 : 0];
	
	var index = irandom_range(0, array_length(group)-1);
	
	var word = group[index];
	if(ds_list_size(phrase) + array_length(word) > max_syl){
		continue;
	}
	
	for(var i = 0; i < array_length(word); i++){
		ds_list_add(phrase, word[i]);
	}
	
	ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
	ds_list_add(phrase, -1);
}

_tick = function(){
	var blast_player = n8fl_penguin_blast_player;
	if(!instance_exists(blast_player)){
		exit;	
	}

	if(ds_list_size(phrase) > 0){
		var last_do_shoot = do_shoot;
		do_shoot = image_index > 1;

		if(do_shoot != last_do_shoot){
			var index = phrase[| 0];
			ds_list_delete(phrase, 0);
			if(index >= 0){
				var proj = instance_create_depth(x, y, depth, n8fl_penguin_blast_projectile);
				proj.image_index = index;
				proj.dest_x = blast_player.x-20;
				proj.dest_y = blast_player.y;
			}
		}
	}else{
		image_index = 0;	
	}	
}