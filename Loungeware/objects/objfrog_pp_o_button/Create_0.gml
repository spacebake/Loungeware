// Position
if (objfrog_pp_o_car.direction == 0 || objfrog_pp_o_car.direction == 180) {
	x = objfrog_pp_o_car.x - sprite_width/2 + (objfrog_pp_o_car.x - objfrog_pp_o_car.bbox_left);
} else {
	x = objfrog_pp_o_car.x - sprite_width/2;	
}

y = objfrog_pp_o_car.y - 32;

image_speed = 0.05;

decrease = true;
