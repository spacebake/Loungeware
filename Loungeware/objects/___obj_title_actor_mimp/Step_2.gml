

___state_handler();


if (state == "reveal"){
	if (state_begin) {
		sprite_index = ___spr_title_mimpy_jump;
		image_index = 3;
		draw_logo = true;
		vsp = -7;
		wait = 60*2;
		x = 155;
		y = 275;
	}
	
	if (substate == 0){
		wait--;
		if (wait <= 0){
			___substate_change(substate+1);
		}
	}
	
	if (substate == 1){
		y += vsp;
		vsp = min(grav_max, vsp + grav);
		if (vsp > 0) draw_logo = false;
		if (y >= floor_y){
			y = floor_y;
			screenshake = 8;
			___substate_change(substate+1);
			
		}
		
		image_index = 3;
		if (vsp >= -1 && vsp < -0.5) image_index = 4;
		if (vsp >= -0.5 && vsp < 0.5) image_index = 5;
		if (vsp >= 0.5) image_index = 6;
		
		
	}
	
	// land
	if (substate == 2){
		if (substate_begin){
			image_index = 7;
			___play_sfx(___snd_title_mimpy_sqeak, 0.45, 1.8);
		}
		
		image_index += 0.2;
		if (image_index >= sprite_get_number(sprite_index)){
			image_index = 0;
			
			___substate_change(substate+1);
		}
	}
	
	// wait
	if (substate == 3){
		if (substate_begin){
			//sprite_index = ___spr_title_mimpy_idle;
			image_index = 0;
			wait = 60;
		}
		image_speed = 1;
		wait--;
		if (wait <= 0) ___substate_change(substate+1);
	}
	
	// walk right
	if (substate == 4){
		if (substate_begin){
			sprite_index = ___spr_title_mimpy_walk;
			image_index = 0;
		}
		x += 1;
		image_speed = 1;
		if (x >= 320){
			
			___substate_change(substate+1);
		}
	}
	
	// shock
	if (substate = 5){
		if (substate_begin){
			___play_sfx(___snd_title_mimpy_scream, 1, 1.8);
			sprite_index = ___spr_title_mimpy_shock;
			image_speed = 0.1;
			mimpy_shake = 10;
			wait = 20;
		}
		if (mimpy_shake >= 7) image_index = 0; else image_index = 1;
		wait--;
		if (wait <= 0){
			___substate_change(substate+1);
		}
	}
	
	// run away
	if (substate == 6){
		if (substate_begin){
			engine_sound = ___play_sfx(___snd_title_engine_idle, 0, 1, true);
			audio_sound_gain(engine_sound, 1, 1000);
			image_speed = 1;
			image_xscale = -1;
			sprite_index = ___spr_title_mimpy_run;
		}
		
		net_frame += 0.2;
		create_smoke_part();
		x -= 3;
		net_x -= 4.5;
		
		if (net_x < -50){
			___substate_change(substate+1);
		}
	}
	
	if (substate == 7){
		if (substate_begin){
			audio_sound_gain(engine_sound, 0, 1000);
		}
		if (audio_sound_get_gain(engine_sound) <= 0){
			audio_stop_sound(engine_sound);
			___substate_change(substate+1);
		}
	} 
	
	if (substate == 8){
		if (substate_begin){
			___play_sfx(___snd_title_mimpy_ded, 0.8, 1.4);
			
		}
		if (array_length(smoke_parts) == 0){
			instance_destroy();
		}
	}
}

steps++;
mimpy_shake = max(0, mimpy_shake - 1);
if (screenshake > 0){
	var _sv = 10//clamp(screenshake / 4, 0, 3);
	camera_set_view_pos(0, random_range(-_sv, _sv), random_range(-_sv, _sv));
	screenshake = max(0, screenshake - 1);
	if (screenshake <= 0) camera_set_view_pos(0, 0, 0);
}

move_smoke_part();
if (!instance_exists(___obj_title_screen)){
	if (engine_sound != noone && audio_is_playing(engine_sound)) audio_stop_sound(engine_sound);
	instance_destroy();
}