state_handle_changes();

if (state = "pause"){

		if (pause_timer <= 0){
			state_change("flying");
			exit;
		}
		pause_timer--;
		
}

if (state == "flying"){
	vsp = min(vsp + grav, grav_max);
	thrusting = false;
	if (KEY_UP || KEY_PRIMARY || KEY_SECONDARY){
		thrusting = true;
		vsp = max(-1, vsp - (grav*2));
		if (thrust_sound_id == noone){
			thrust_sound_id = sfx_play(space_lander_snd_thrust, 1, 1);
			audio_sound_pitch(thrust_sound_id, 0.2);
		}
	} else {
		if (thrust_sound_id != noone){
			sfx_stop(thrust_sound_id, 20);
			thrust_sound_id = noone;
		}
	}
	
	// stop flying too high
	if (y+vsp < oy ){
		y = oy;
		vsp = max(vsp, 0);
	}
	
	//land
	if (bbox_bottom + vsp >= floor_y){
		ship_shake = 5;
		y = floor_y - 14;
		thrusting = false;
		landed = true;
		if (thrust_sound_id != noone){
			sfx_stop(thrust_sound_id, 20);
			thrust_sound_id = noone;
		}
		if (vsp > land_speed_max){
			ship_shake_val = 1;
			ship_index = 1;
			pause_timer = 25;
			sfx_play(space_lander_snd_rocket_crash, 1, 0);
			view_shake_val = 1;
			view_shake = 6;
			microgame_music_stop(100);
			state_change("fail");
			exit;
		} else {
			sfx_play(space_lander_snd_rocket_land, 1, 0);
			microgame_win();
			pause_timer = 30;
			state_change("won");
			exit;
		}
		
	}
	
	y += vsp;
}

if (state == "fail"){
	if (substate == 0){
		pause_timer--;
		if (pause_timer <= 0){
			ship_shake_val = 1
			ship_shake = 10;
			substate++;
		}
	}
	if (substate == 1){
		if (ship_shake <= 0){
			//create particles here
			create_smoke_part(20);
			view_shake_val = 2;
			view_shake = 12;
			state_change("invisible");
		}
	}

}

if (state == "won"){
	if (state_begin){
		sfx_play(space_lander_snd_alien, 1, 0);
	}
	if (pause_timer <= 0) lid_dir = min(180, lid_dir + lid_speed);
	var _prog = lid_dir / 180;
	lid_x_mod = -(_prog * 4);
	if (lid_dir > 30) lid_frame = 4;
	pause_timer--;
	if (lid_dir >= 180){
		alien_y_mod = max(0, alien_y_mod - 1);
		if (!alien_talked){
			sfx_play(space_lander_snd_bogos, 1, 0);
			alien_talked = true;
		}
	}
}


if (view_shake){
	var _shake_val = view_shake_val;
	view_shake = max(0, view_shake - 1);
	camera_set_view_pos(CAMERA, random_range(-_shake_val,_shake_val), random_range(-_shake_val, _shake_val));
	if (view_shake <= 0) camera_set_view_pos(CAMERA, 0, 0);
} 