start_x = room_width / 2 + -dir * 20;
start_y = y;
x = start_x;
y = start_y;
offset_x = 0;
walk_time = 2/8;
walk_distance = 48;
is_dead = false;
last_is_dead = false;
is_win = false;
image_speed = 0;
hop_offset = 0;
hop_force = 4;
hop_speed = 200;
has_gun = false;

vx = 0;
vy = 0;
grav = 0.3;
hit_force = 4;
shoot_force = 0.5;
death_timer = 0;

sprite_index = global.n8fl_player.get_char();

spawn_emote = function(_index){
	var proj = instance_create_depth(x, y-40, depth+1, n8fl_reach_for_it_mister_char_emotes);
	proj.image_index = _index;
}

shoot = function(_miss){
	var xx = 0;
	var yy = 0;
	switch(sprite_index){
		case n8fl_reach_for_it_mister_cnet_spr:
			xx = 30;
			yy = -15;
		break;
		case n8fl_reach_for_it_mister_cpine_spr:
			xx = 48;
			yy = -14;
		break;
		case n8fl_reach_for_it_mister_csahaun_spr:
			xx = 48;
			yy = -20;
		break;
		case n8fl_reach_for_it_mister_cmimps_spr:
			xx = 48;
			yy = -20;
		break;
		case n8fl_reach_for_it_mister_cbulbs_spr:
			xx = 58;
			yy = -30;
		break;
	}
	
	var proj = instance_create_depth(x+xx * dir, y+yy, depth-1, n8fl_reach_for_it_mister_projectile);
	proj.dir = dir;
	var offset_range = _miss ? (random_range(5,12) * choose(-1, 1)) : 0;
	var a = (dir ? 0 : 180) + offset_range;
	
	vx = (shoot_force) * -dir;
	vy = -(shoot_force);
	
	proj.image_angle = a;
	proj.dir_x = lengthdir_x(1, a);
	proj.dir_y = lengthdir_y(1, a);
	proj.miss = _miss;
	proj.target = object_index == n8fl_reach_for_it_mister_player ? n8fl_reach_for_it_mister_rake : n8fl_reach_for_it_mister_player;
	if(sprite_index == n8fl_reach_for_it_mister_cbulbs_spr){
		proj.image_xscale = 3;
		proj.image_yscale = 3;
	}
	
	if(_miss){
		var _snd_id = sfx_play(n8fl_reach_for_it_mister_gunshot_snd, 0.4, 0);
		audio_sound_pitch(_snd_id, random_range(0.5,1.2));
		
		_snd_id = sfx_play(n8fl_reach_for_it_mister_ricochet_snd, 0.2, 0);
		audio_sound_pitch(_snd_id, random_range(0.7,1));
		
	}else{
		var _snd_id = sfx_play(n8fl_reach_for_it_mister_gunshot_snd, 1, 0);
		audio_sound_pitch(_snd_id, random_range(0.5,1.2));
		
		_snd_id = sfx_play(n8fl_reach_for_it_mister_gunshot_hit_snd, 1, 0);
		audio_sound_pitch(_snd_id, random_range(0.7,1));
	}
	
}

var exc = instance_create_depth(x, y  - sprite_height - 5,depth-1,n8fl_reach_for_it_mister_char_exclame);
exc.owner = id;
exc.delay = random_range(40, 110);
