if(has_collided){
	exit;	
}
has_collided = true;

if(other.image_index != n8fl_penguin_blast_EPlayerAnimation.Dodge &&
	image_index = n8fl_penguin_blast_EProjectile.Bomb)
{
	other.is_hurt = true;
	instance_destroy();
	exit;
}

if(other.image_index == n8fl_penguin_blast_EPlayerAnimation.Idle){
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
	instance_destroy();
}


