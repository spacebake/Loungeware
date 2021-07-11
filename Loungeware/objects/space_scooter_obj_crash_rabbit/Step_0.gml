if (state == 0){
	vsp = min(grav_max, vsp+grav);
	image_angle = point_direction(0,0,hsp,vsp) - 90;
	
	x += hsp;
	if (place_meeting(x, y+vsp, space_scooter_obj_block)){
		y = floor(y);
		while(!place_meeting(x, y + sign(vsp), space_scooter_obj_block)) y += sign(vsp);
		vsp = 0;
		//instance_create_layer(x, y, layer, space_scooter_obj_rogue_wheel);
		state = 1;
		sfx_play(space_scooter_snd_squeak, 1, 0)
		image_angle = 0;
		image_index = 1;
		space_scooter_obj_scooter.shake = 3;
		y = 0;
		while(!place_meeting(x, y + 1, space_scooter_obj_block)) y += 1;
	}
	
	y += vsp;
}

if (state == 1){
	hsp = hsp * 0.9;
	x += hsp;
	if (hsp <= 0.01){
		with (instance_create_layer(0, 0, layer, space_scooter_obj_indicator)) frame = 0;
		state = 2;
	}
}

if (state == 2){
	
}