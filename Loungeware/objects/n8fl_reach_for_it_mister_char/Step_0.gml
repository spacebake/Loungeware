var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}


if(last_is_dead != is_dead){
	vx = -dir * hit_force / 2;
	vy = -hit_force;
	last_is_dead = is_dead;
	

}

if(is_dead){
	x += vx;
	y += vy;
	vx *=0.95;
	vy += grav;
	image_index = 2;	
	if(y > start_y){
		y=start_y;
		vy=0;
	}
	if(sprite_index == n8fl_reach_for_it_mister_cbulbs_spr){
		death_timer++;
		if(death_timer == 20){
			
			instance_create_depth(x, y, depth, n8fl_reach_for_it_mister_explosion);
			image_alpha=0;
			exit;
		}
	}
}else{
	last_is_dead = is_dead;

	var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;

	if(t < reach_player.draw_time){
		has_gun = false;
		image_index = 0;
		image_xscale = dir;
		var walk_t = clamp(t / walk_time, 0, 1);
		offset_x = lerp(0, -dir * walk_distance, walk_t);
		if(walk_t < 1){
			var hop_t =  ((1 + sin(t*hop_speed)) /2);
			hop_offset = hop_t * -hop_force;
		}else{
			hop_force -= 0.02;	
		}
	
	}else{
		has_gun = true;
		image_xscale = -dir;
		hop_offset = 0;
		x += vx;
		y += vy;
		vx *=0.8;
		vy += grav;
		if(y > start_y){
			y=start_y;
			vy=0;
		}
		image_index = 1;	
	}
}