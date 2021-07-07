if(other.object_index != target){
	exit;	
}

if(miss == false){
	other.is_dead = true;
	instance_destroy(id);
	exit;
}