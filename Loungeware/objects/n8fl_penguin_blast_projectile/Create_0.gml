enum n8fl_penguin_blast_EProjectile{
	Primary,
	Secondary,
	Bomb,
	Length
}

angle_wave = new n8fl_FWave(0.2, 15)

duration = random_range(2.5, 2.6);
start_x = x;
start_y = y;
dest_x = 0;
dest_y = 0;
max_height = random_range(40, 80);
time=0;
image_speed = 0;
has_collided = false;

is_success = false;
is_miss = false;

jump_force = random_range(4,5);
vx = 0
vy = 0;
grav = 0.4;

_init = function(){
	angle_wave.play();	
}

_tick = function(){
	

	if(is_miss || is_success){
		vy += grav;
		x += vx;
		y += vy;
		if(is_success){
			image_alpha -= 0.1;
		}
	
		var max_y = 150;
	
	
		y = min(max_y, y);
		if(y == max_y){
			vx *= 0.4;
		}
	
		if(is_miss){
			x = min(175,x);
		}
		exit;	
	}

	time+=1/60;

	var t = time / duration;

	if(t < 1){
		x = lerp(start_x, dest_x, t);
		y = lerp(start_y, dest_y, t) - sin(t * 4) * max_height;
	} else {
		x += 1;
		y += 1;
	}
	
	image_angle += angle_wave.get_delta();
}

can_collide = function(){
	return has_collided == false;	
}

collide_success = function(player){
	is_success=true;
	has_collided = true;
	vy = -jump_force;
	vx = -random_range(2,4);

	audio_sound_pitch(
		sfx_play(n8fl_penguin_blast_hit_snd, 0.8, 0),
		random_range(1.2,1.5)
	);
}

collide_fail = function(player){
	has_collided = true;
	is_miss = true;
	vy = -jump_force;
	vx = random_range(2,4);
	
	audio_sound_pitch(
		sfx_play(n8fl_penguin_blast_hit_snd, 0.8, 0),
		random_range(0.9,1.1)
	);
	

	
	if(image_index != n8fl_penguin_blast_EProjectile.Bomb){
		audio_sound_pitch(
			sfx_play(
				choose(n8fl_penguin_blast_hit_oof1_snd,n8fl_penguin_blast_hit_oof2_snd),
				0.1, 
				0
			),
			random_range(0.9,1.1)
		);
		
		audio_sound_pitch(
			sfx_play(n8fl_penguin_blast_hit_fail_snd, 0.2, 0),
			random_range(0.9,1.1)
		);	
	}
}

collide_explode = function(player){
	has_collided = true;
	audio_sound_pitch(
		sfx_play(n8fl_penguin_blast_hit_boom_snd, 0.8, 0),
		random_range(0.9,1.1)
	);
	audio_sound_pitch(
			sfx_play(
				choose(n8fl_penguin_blast_hit_oof1_snd,n8fl_penguin_blast_hit_oof2_snd),
				0.3, 
				0
			),
			random_range(0.9,1.1)
		);
	instance_create_depth(x,y, depth-10, n8fl_penguin_blast_boom);
	instance_destroy();
}

n8fl_execute_next_once(_init);