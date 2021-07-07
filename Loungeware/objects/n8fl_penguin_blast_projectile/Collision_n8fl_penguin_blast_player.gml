var hud = n8fl_penguin_blast_hud;
if(instance_exists(hud) == false){
	return;	
}

if(has_collided){
	exit;	
}
has_collided = true;

if(image_index == n8fl_penguin_blast_EProjectile.Bomb){
	if(other.image_index == n8fl_penguin_blast_EPlayerAnimation.Dodge){
		is_miss = true;
		vy = -jump_force;
		vx = random_range(2,4);
		exit;
	}else{
		if(ds_list_size(other.score_list) > 0){
			ds_list_delete(other.score_list, 0);
			hud.make_intense();
		}
		other.is_hurt = true;
		instance_create_depth(x,y, depth-10, n8fl_penguin_blast_boom);
		instance_destroy();
		exit;
	}
}


if(other.image_index == n8fl_penguin_blast_EPlayerAnimation.Idle){
	other.is_hurt = true;
	is_miss = true;
	vy = -jump_force;
	vx = random_range(2,4);
	exit;
}

if(
	(other.image_index == n8fl_penguin_blast_EPlayerAnimation.Primary &&
	image_index == n8fl_penguin_blast_EProjectile.Primary) 
	||
	(other.image_index == n8fl_penguin_blast_EPlayerAnimation.Secondary &&
	image_index == n8fl_penguin_blast_EProjectile.Secondary)
){
	ds_list_add(n8fl_penguin_blast_player.score_list, image_index);
	hud.make_intense();
	is_success=true;
	vy = -jump_force;
	vx = -random_range(2,4);
	exit;
}

is_miss = true;
vx = random_range(2,4);
vy = -jump_force;
