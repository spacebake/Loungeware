dir = image_xscale;

is_pushing = false;

intensity = 0;

vx = 0;
vy = 0;

move_speed = 4;

wave = new n8fl_FWave(5,30);
tween = new n8fl_FTween(0, 0, 0.5);

allow_movement = true;

inst_4DC1830C.collided.add(function(){
	allow_movement = false;
});

begin_push = function(){
	is_pushing = true;
}

end_push = function(){
	is_pushing = false;	
}

move = function(_dir){
	if(allow_movement){
		vy = n8fl_impossible_move_to(vy, _dir * move_speed, 0.2);
	}
}

_tick = function(){
	tween.start = room_width / 2 + dir * (room_width / 2) + dir * 20;
	tween.dest = tween.start - dir * 30;	
	intensity = tween.normalized_value();
	
	if(allow_movement == false){
		end_push();	
	}

	if(is_pushing){
		tween.play_speed = 1;
	}else{
		tween.play_speed = -0.5;
	}


	wave.amp = lerp(5, 10, intensity);
	wave.freq = lerp(2, 0.3, intensity);
	
	x = tween.value() + wave.value();
	
	if(allow_movement){
		var puck = n8fl_ice_broom_puck;
		if(instance_exists(puck)){
			y += puck.get_cam_velocity().y;
		}
	}
	
	vy *= 0.9;
	y += vy;
}