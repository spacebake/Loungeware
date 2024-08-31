/// @description Game loop
if (start_game){
	if (key_count >= key_sequence_length){
		microgame_win();
		chacon_not_enough_tacos_glasses.visible = false;
		chacon_not_enough_tacos_larold.image_index = 2;
		if (!audio_is_playing(chacon_not_enough_tacos_sound_vocal)){
			sfx_play(chacon_not_enough_tacos_sound_vocal);
		}
		with(chacon_not_enough_tacos_light){
			if (alarm[0] == -1){
				alarm[0] = game_get_speed(gamespeed_fps) * time;
			}
		}
	} else {
		if (KEY_ANY_RELEASED) {	  
			ShakeObject(chacon_not_enough_tacos_glasses, true);
			Screenshake(5, 1, 1);
			
			if (KeyMatch()) { // If key is a match to sequence
				sprite_alpha[key_count] = 1; // Make correct key pressed visible
				sprite_color = make_color_rgb(181,255,208); // Change button color to green
				key_count++; // Keep count of combo sequence
				
				var _slash_audio = sfx_play(chacon_not_enough_tacos_sound_slash);
				audio_sound_pitch(_slash_audio, random_range(0.5, 2))
				
				ShakeObject(chacon_not_enough_tacos_trompo); // Shake trompo
				CreateSlash();
			}  else{
				microgame_fail();
				start_game = false; // Disable key pressing
				draw_x = true; // Draw red X
				draw_correct_key = true;
				if (!audio_is_playing(chacon_not_enough_tacos_sound_wrong)){
					sfx_play(chacon_not_enough_tacos_sound_wrong);
				}
				chacon_not_enough_tacos_larold.image_index = 1;
			}
		}
	}
}