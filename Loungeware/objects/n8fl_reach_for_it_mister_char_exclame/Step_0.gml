tick++;

if(owner){
	x = owner.x;
}

if(tick < delay){
	exit;	
}


y += ((start_y-dist) - y) * spd;
image_alpha -= alpha_spd;