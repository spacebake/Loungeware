
if (state == 0){
	
	vsp = min(grav_max, vsp + grav);
	
	image_speed = 0;

	prog = steps/max_steps;
	image_angle = 360 * (prog);
	x_offset = 7.5 * prog;

	y += vsp;
	
	
	if (y >= oy){
		y = oy;
		image_angle = 0;
		state = 1;
		image_index = 1;
		wait = 5;
	}
	
}
if (state == 1){
	wait--;
	if (wait <= 0){
		image_index = 2;
		state = 2;
		finished = true;
		space_scoot_obj_bg.big_rabbit_play = true;
		
	}
}

if (state == 2){

}


steps++;
x = space_scooter_obj_scooter.x + x_offset;